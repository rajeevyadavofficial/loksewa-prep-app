const express = require('express');
const bcrypt = require('bcryptjs');
const { DB } = require('../config/db');
const { signToken, requireAuth } = require('../middleware/auth');

const router = express.Router();

function sanitizeUser(u) {
  return {
    uid: u._id,
    name: u.name,
    email: u.email,
    plan: u.plan || 'free',
    planExpiresAt: u.planExpiresAt || null,
    isAdmin: !!u.isAdmin,
    bookmarkedQuestions: u.bookmarkedQuestions || [],
    enrolledExams: u.enrolledExams || [],
  };
}

// POST /api/auth/login
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password are required' });
    }
    const user = await DB.findUserByEmail(email);
    if (!user) {
      return res.status(401).json({ error: 'Account not found. Please register a candidate account first.' });
    }
    const valid = await bcrypt.compare(password, user.passwordHash);
    if (!valid) {
      return res.status(401).json({ error: 'Incorrect email or password' });
    }

    const token = signToken(user);
    return res.json({ token, user: sanitizeUser(user) });
  } catch (err) {
    console.error('Login error:', err);
    return res.status(500).json({ error: 'Server error during login' });
  }
});

// POST /api/auth/register
router.post('/register', async (req, res) => {
  try {
    const { name, email, password } = req.body;
    if (!name || !email || !password || password.length < 6) {
      return res.status(400).json({ error: 'Name, valid email, and 6+ char password required' });
    }
    const existing = await DB.findUserByEmail(email);
    if (existing) {
      return res.status(409).json({ error: 'An account with this email already exists' });
    }
    const passwordHash = await bcrypt.hash(password, 10);
    const user = await DB.createUser({ name, email, passwordHash, plan: 'free', isAdmin: false });
    const token = signToken(user);
    return res.status(201).json({ token, user: sanitizeUser(user) });
  } catch (err) {
    console.error('Register error:', err);
    return res.status(500).json({ error: 'Server error during registration' });
  }
});

// GET /api/auth/me
router.get('/me', requireAuth, async (req, res) => {
  return res.json({ user: sanitizeUser(req.user) });
});

// POST /api/auth/enroll (Enroll or unenroll in a specific exam course)
router.post('/enroll', requireAuth, async (req, res) => {
  try {
    const { examId, action = 'enroll' } = req.body;
    if (!examId) {
      return res.status(400).json({ error: 'examId is required' });
    }
    const current = Array.isArray(req.user.enrolledExams) ? [...req.user.enrolledExams] : [];
    let updatedList;
    if (action === 'unenroll') {
      updatedList = current.filter((id) => id !== examId);
    } else if (action === 'set_single') {
      updatedList = [examId];
    } else {
      if (!current.includes(examId)) current.push(examId);
      updatedList = current;
    }
    const updatedUser = await DB.updateUserEnrolledExams(req.user._id, updatedList);
    if (!updatedUser) {
      return res.status(404).json({ error: 'User not found' });
    }
    return res.json({
      message: action === 'unenroll' ? 'Unenrolled from exam' : 'Successfully enrolled in exam!',
      user: sanitizeUser(updatedUser),
    });
  } catch (err) {
    console.error('Enroll error:', err);
    return res.status(500).json({ error: 'Failed to update exam enrollment' });
  }
});

// POST /api/auth/upgrade (Submits a Pending Payment Verification Request for Admin Approval)
router.post('/upgrade', requireAuth, async (req, res) => {
  try {
    const { plan = 'premium', method = 'esewa', transactionRef = '' } = req.body;
    if (!['basic', 'premium', 'pro'].includes(plan)) {
      return res.status(400).json({ error: 'Invalid subscription plan' });
    }
    const normalizedPlan = 'premium';
    const amount = 299;

    const payment = await DB.createPayment({
      userId: String(req.user._id),
      userName: req.user.name,
      userEmail: req.user.email,
      plan: normalizedPlan,
      amount,
      method,
      transactionRef: transactionRef.trim() || `WhatsApp Screenshot (${method.toUpperCase()})`,
      status: 'pending',
    });

    return res.json({
      status: 'pending',
      message: `Payment verification request submitted for PRO Plan (रू 299)! Admin will verify your WhatsApp screenshot and activate your plan.`,
      payment,
      user: sanitizeUser(req.user),
    });
  } catch (err) {
    console.error('Upgrade request error:', err);
    return res.status(500).json({ error: 'Server error while submitting payment verification request' });
  }
});

module.exports = router;
