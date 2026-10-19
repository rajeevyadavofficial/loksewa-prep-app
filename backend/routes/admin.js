const express = require('express');
const { DB } = require('../config/db');
const { requireAuth, requireAdmin } = require('../middleware/auth');

const router = express.Router();

// GET /api/admin/stats
router.get('/stats', requireAuth, requireAdmin, async (req, res) => {
  try {
    const t0 = Date.now();
    const exams = await DB.getAllExams();
    const t1 = Date.now();
    const users = await DB.getAllUsers();
    const t2 = Date.now();
    const totalQuestions = await DB.getQuestionsCount();
    const t3 = Date.now();
    const payments = await DB.getAllPayments();
    const t4 = Date.now();
    const donations = await DB.getAllDonations();
    const t5 = Date.now();

    console.log(`⏱️ [STATS PROFILER] exams: ${t1-t0}ms | users: ${t2-t1}ms | questionsCount: ${t3-t2}ms | payments: ${t4-t3}ms | donations: ${t5-t4}ms | total: ${t5-t0}ms`);

    const freeCount = users.filter((u) => u.plan === 'free').length;
    const basicCount = users.filter((u) => u.plan === 'basic').length;
    const premiumCount = users.filter((u) => u.plan === 'premium').length;
    const pendingPayments = payments.filter((p) => p.status === 'pending');
    const pendingDonations = donations.filter((d) => d.status === 'pending');
    const totalRevenue = payments
      .filter((p) => p.status === 'completed')
      .reduce((acc, p) => acc + (Number(p.amount) || 0), 0);

    return res.json({
      databaseMode: DB.isNativeMongo() ? 'MongoDB Atlas Cloud (Connected)' : 'MongoDB Document Store (Local Persistent)',
      totalExams: exams.length,
      totalUsers: users.length,
      freeCount,
      basicCount,
      premiumCount,
      totalQuestions,
      totalRevenue,
      pendingCount: pendingPayments.length,
      pendingPayments,
      recentPayments: payments.slice(0, 100),
      pendingDonationsCount: pendingDonations.length,
      pendingDonations,
      recentDonations: donations.slice(0, 30),
      users: users.map((u) => ({
        uid: u._id,
        name: u.name,
        email: u.email,
        plan: u.isAdmin ? 'premium' : (u.plan || 'free'),
        planExpiresAt: u.isAdmin ? null : (u.planExpiresAt || null),
        isAdmin: !!u.isAdmin,
        createdAt: u.createdAt,
      })),
    });
  } catch (err) {
    console.error('Admin stats error:', err);
    return res.status(500).json({ error: 'Failed to load admin statistics' });
  }
});

// PUT /api/admin/donations/:id/verify (Admin Only — Verify donated question & auto-publish to Question Bank)
router.put('/donations/:id/verify', requireAuth, requireAdmin, async (req, res) => {
  try {
    const { action } = req.body || {};
    if (!['approve', 'reject'].includes(action)) {
      return res.status(400).json({ error: 'Action must be approve or reject' });
    }
    const result = await DB.verifyQuestionDonation(req.params.id, action);
    if (!result) {
      return res.status(404).json({ error: 'Donated question not found' });
    }
    return res.json({
      message:
        action === 'approve'
          ? `Question verified & published to ${result.donation.exam_id}! Credited +Rs. 0.05 to ${result.donation.userName}.`
          : `Donated question from ${result.donation.userName} rejected.`,
      donation: result.donation,
      publishedQuestion: result.publishedQuestion,
    });
  } catch (err) {
    console.error('Admin verify donation error:', err);
    return res.status(500).json({ error: 'Failed to verify donated question' });
  }
});

// PUT /api/admin/users/:id/plan
router.put('/users/:id/plan', requireAuth, requireAdmin, async (req, res) => {
  try {
    const { plan, durationDays, expiresAt } = req.body;
    if (!['free', 'basic', 'premium'].includes(plan)) {
      return res.status(400).json({ error: 'Invalid plan' });
    }
    const updated = await DB.updateUserPlan(req.params.id, plan, { durationDays, expiresAt });
    if (!updated) {
      return res.status(404).json({ error: 'User not found' });
    }
    return res.json({
      message: `Updated ${updated.name}'s plan to ${plan === 'free' ? 'FREE' : 'PRO (रू 199)'}`,
      user: {
        uid: updated._id,
        name: updated.name,
        email: updated.email,
        plan: updated.plan,
        planExpiresAt: updated.planExpiresAt || null,
      },
    });
  } catch (err) {
    console.error('Admin update user plan error:', err);
    return res.status(500).json({ error: 'Failed to update user plan' });
  }
});

// PUT /api/admin/payments/:id/verify (Admin Only — Verify WhatsApp screenshot & activate plan or reject)
router.put('/payments/:id/verify', requireAuth, requireAdmin, async (req, res) => {
  try {
    const { action, durationDays, expiresAt } = req.body || {};
    if (!['approve', 'reject'].includes(action)) {
      return res.status(400).json({ error: 'Action must be approve or reject' });
    }
    const result = await DB.verifyPayment(req.params.id, action, { durationDays, expiresAt });
    if (!result) {
      return res.status(404).json({ error: 'Payment record not found' });
    }
    return res.json({
      message:
        action === 'approve'
          ? `Payment verified! Activated PRO Plan (रू 199) for ${result.payment.userName}.`
          : `Payment request from ${result.payment.userName} rejected.`,
      payment: result.payment,
      user: result.user,
    });
  } catch (err) {
    console.error('Admin verify payment error:', err);
    return res.status(500).json({ error: 'Failed to verify payment' });
  }
});

// DELETE /api/admin/payments/:id (Admin Only — Delete transaction record / remove fake transactions)
router.delete('/payments/:id', requireAuth, requireAdmin, async (req, res) => {
  try {
    const deleted = await DB.deletePayment(req.params.id);
    if (!deleted) {
      return res.status(404).json({ error: 'Payment transaction record not found' });
    }
    return res.json({ message: 'Transaction record deleted successfully' });
  } catch (err) {
    console.error('Admin delete payment error:', err);
    return res.status(500).json({ error: 'Failed to delete payment record' });
  }
});

// DELETE /api/admin/users/:id (Admin Only — Delete candidate user account)
router.delete('/users/:id', requireAuth, requireAdmin, async (req, res) => {
  try {
    if (String(req.user._id) === String(req.params.id)) {
      return res.status(400).json({ error: 'Cannot delete your own active Admin account' });
    }
    const deleted = await DB.deleteUser(req.params.id);
    if (!deleted) {
      return res.status(404).json({ error: 'User not found' });
    }
    return res.json({ message: 'User account deleted successfully' });
  } catch (err) {
    console.error('Admin delete user error:', err);
    return res.status(500).json({ error: 'Failed to delete user' });
  }
});

module.exports = router;
