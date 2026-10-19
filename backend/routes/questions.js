const express = require('express');
const { DB } = require('../config/db');
const { optionalAuth, requireAuth, requireAdmin } = require('../middleware/auth');

const router = express.Router();

function applyPaywallToQuestion(q, user) {
  const plan = user?.plan || 'free';
  const isAdmin = !!user?.isAdmin;
  const isPro = isAdmin || plan === 'premium' || plan === 'basic' || plan === 'pro';

  const isLocked = !isPro && !!q.is_premium;

  if (!isLocked) {
    return q;
  }

  return {
    ...q,
    answer_nepali: null,
    answer_english: null,
    explanation: null,
  };
}

// GET /api/questions (Supports server-side pagination with limit=10 by default)
router.get('/', optionalAuth, async (req, res) => {
  try {
    const { exam_id, paper, section, unit_number, type, page, limit, search, all } = req.query;

    const isAll = all === 'true' || limit === 'all';
    const numLimit = isAll ? 0 : (parseInt(limit) || 10);
    const numPage = Math.max(1, parseInt(page) || 1);

    if (isAll) {
      let rawQuestions = await DB.getAllQuestions({ exam_id, paper, section, unit_number, type });
      if (
        req.user &&
        !req.user.isAdmin &&
        Array.isArray(req.user.enrolledExams) &&
        req.user.enrolledExams.length > 0
      ) {
        const enrolledSet = new Set(req.user.enrolledExams);
        rawQuestions = rawQuestions.filter((q) => enrolledSet.has(q.exam_id || 'rbb_it_5'));
      }
      const protectedQuestions = rawQuestions.map((q) => applyPaywallToQuestion(q, req.user));
      return res.json({
        total: protectedQuestions.length,
        userPlan: req.user?.plan || 'free',
        questions: protectedQuestions,
      });
    }

    const filters = { exam_id, paper, section, unit_number, type, search };
    const pagedResult = await DB.getQuestionsPaginated(filters, { page: numPage, limit: numLimit });

    // Apply paywall protection
    const protectedQuestions = pagedResult.questions.map((q) => applyPaywallToQuestion(q, req.user));

    return res.json({
      total: pagedResult.total,
      page: pagedResult.page,
      limit: pagedResult.limit,
      totalPages: pagedResult.totalPages,
      userPlan: req.user?.plan || 'free',
      questions: protectedQuestions,
    });
  } catch (err) {
    console.error('Error fetching questions:', err);
    return res.status(500).json({ error: 'Failed to load questions from database' });
  }
});

// GET /api/questions/donations/my (Candidate's own donated questions & Rs. earnings)
router.get('/donations/my', requireAuth, async (req, res) => {
  try {
    const donations = await DB.getDonationsByUser(req.user._id);
    const verifiedList = donations.filter((d) => d.status === 'approved');
    const verifiedCount = verifiedList.length;
    const unclaimedVerifiedCount = verifiedList.filter((d) => !d.claimed).length;
    const claimedCount = verifiedList.filter((d) => !!d.claimed).length;
    const pendingCount = donations.filter((d) => d.status === 'pending').length;
    const rejectedCount = donations.filter((d) => d.status === 'rejected').length;
    // 100 valid and verified questions generate Rs. 5 (Rs. 0.05 per verified question)
    // Candidate becomes eligible to claim & provide payment ID once unclaimed verified questions reach 200 (Rs. 10.00)
    const earnedRupees = Number((verifiedCount * 0.05).toFixed(2));
    const claimableRupees = Number((unclaimedVerifiedCount * 0.05).toFixed(2));
    return res.json({
      totalSubmitted: donations.length,
      verifiedCount,
      unclaimedVerifiedCount,
      claimedCount,
      pendingCount,
      rejectedCount,
      earnedRupees,
      claimableRupees,
      eligibleToClaim: unclaimedVerifiedCount >= 200,
      minQuestionsToClaim: 200,
      rateDescription: '100 Valid & Verified Questions = Rs. 5.00 (Reach 200 Verified Questions to Claim Payout)',
      donations,
    });
  } catch (err) {
    console.error('Error loading user donations:', err);
    return res.status(500).json({ error: 'Failed to load donated questions' });
  }
});

// POST /api/questions/donations/claim (Eligible once candidate reaches 200 verified questions)
router.post('/donations/claim', requireAuth, async (req, res) => {
  try {
    const { paymentMethod, walletId } = req.body || {};
    if (!walletId || !String(walletId).trim()) {
      return res.status(400).json({ error: 'Please enter your eSewa / Khalti Payment ID to claim your reward.' });
    }
    const result = await DB.claimDonationReward(req.user._id, {
      paymentMethod: paymentMethod || 'eSewa',
      walletId: String(walletId).trim(),
    });
    if (!result.ok) {
      return res.status(400).json({ error: result.error });
    }
    return res.json({
      message: `Reward claim of Rs. ${result.claimedRupees.toFixed(2)} (${result.claimedQuestions} verified questions) submitted for ${result.paymentMethod} ID: ${result.walletId}!`,
      ...result,
    });
  } catch (err) {
    console.error('Error claiming donation reward:', err);
    return res.status(500).json({ error: 'Failed to submit reward claim' });
  }
});

// POST /api/questions/donations (Candidate donates a question for their enrolled exam)
router.post('/donations', requireAuth, async (req, res) => {
  try {
    const {
      exam_id,
      paper,
      section,
      unit_number,
      unit_title,
      marks,
      type,
      years_asked,
      question_nepali,
      question_english,
      answer_nepali,
      answer_english,
      options,
      correct_option_index,
      explanation,
      question_photo_url,
      answer_photo_url,
    } = req.body || {};

    const targetExam = (exam_id || '').trim();
    const enrolledExams = Array.isArray(req.user.enrolledExams) ? req.user.enrolledExams : [];

    // Enforce that a candidate can only donate questions for the exam course(s) they are enrolled in
    if (!req.user.isAdmin) {
      if (enrolledExams.length === 0) {
        return res.status(403).json({
          error: 'Please enroll in an exam course first before donating questions.',
        });
      }
      if (!targetExam || !enrolledExams.includes(targetExam)) {
        return res.status(403).json({
          error: 'You can only donate questions for the exam course you are enrolled in.',
        });
      }
    }

    const qNp = (question_nepali || '').trim();
    const qEn = (question_english || '').trim();
    const qPhoto = (question_photo_url || '').trim();
    const aPhoto = (answer_photo_url || '').trim();

    if (!qNp && !qEn && !qPhoto) {
      return res.status(400).json({
        error: 'Please enter the question text or upload a clear photo of the question.',
      });
    }

    const cleanType = type === 'mcq' ? 'mcq' : 'subjective';
    const aNp = (answer_nepali || '').trim();
    const aEn = (answer_english || '').trim();

    if (cleanType === 'subjective') {
      if (!aNp && !aEn && !aPhoto && !qPhoto) {
        return res.status(400).json({
          error: 'Please provide a well-written model answer (typed or clear handwritten/printed answer photo) for verification.',
        });
      }
    } else {
      const hasValidOptions =
        Array.isArray(options) && options.filter((o) => String(o).trim().length > 0).length >= 4;
      if (!hasValidOptions && !qPhoto && !aPhoto) {
        return res.status(400).json({
          error: 'Please provide all 4 MCQ options (A, B, C, and D) or upload a clear photo of the MCQ and answer.',
        });
      }
    }

    const fallbackQuestionLabel = `[Photo Submitted] ${(unit_title || `Unit ${unit_number || 1}`).trim()}`;
    const finalQNp = qNp || qEn || fallbackQuestionLabel;
    const finalQEn = qEn || qNp || fallbackQuestionLabel;
    const fallbackAnsLabel = aPhoto || qPhoto ? '[See attached well-written answer photo for verification]' : '';

    const created = await DB.createQuestionDonation({
      userId: String(req.user._id),
      userName: req.user.name,
      userEmail: req.user.email,
      walletId: '',
      claimed: false,
      claimStatus: 'unclaimed',
      exam_id: targetExam || enrolledExams[0] || 'rbb_it_5',
      paper: paper === 'paper2' ? 'paper2' : 'paper1',
      section: section === 'sectionB' ? 'sectionB' : 'sectionA',
      unit_number: Number(unit_number) || 1,
      unit_title: (unit_title || `Unit ${unit_number || 1}`).trim(),
      marks: Number(marks) || (cleanType === 'mcq' ? 1 : 5),
      type: cleanType,
      years_asked: Array.isArray(years_asked) && years_asked.length > 0
        ? years_asked
        : ['Candidate Contributed'],
      question_nepali: finalQNp,
      question_english: finalQEn,
      answer_nepali: cleanType === 'subjective' ? (aNp || aEn || fallbackAnsLabel) : null,
      answer_english: cleanType === 'subjective' ? (aEn || aNp || fallbackAnsLabel) : null,
      options: cleanType === 'mcq' && Array.isArray(options) ? options.map((o) => String(o).trim()) : null,
      correct_option_index: cleanType === 'mcq' ? (Number(correct_option_index) || 0) : null,
      explanation: cleanType === 'mcq' ? ((explanation || '').trim() || null) : null,
      question_photo_url: qPhoto || null,
      answer_photo_url: aPhoto || null,
      status: 'pending',
    });

    return res.status(201).json({
      message: 'Question & answer submitted for Admin verification! Reach 200 verified questions to claim your reward.',
      donation: created,
    });
  } catch (err) {
    console.error('Error submitting question donation:', err);
    return res.status(500).json({ error: 'Failed to submit question donation' });
  }
});

// POST /api/questions (Admin only)
router.post('/', requireAuth, requireAdmin, async (req, res) => {
  try {
    const qData = req.body;
    if (!qData.id || !qData.question_english || !qData.question_nepali) {
      return res.status(400).json({ error: 'id, question_nepali, and question_english are required' });
    }
    const created = await DB.createQuestion(qData);
    return res.status(201).json({ question: created });
  } catch (err) {
    console.error('Error creating question:', err);
    return res.status(500).json({ error: 'Failed to create question' });
  }
});

// PUT /api/questions/:id (Admin only)
router.put('/:id', requireAuth, requireAdmin, async (req, res) => {
  try {
    const updated = await DB.updateQuestion(req.params.id, req.body);
    if (!updated) {
      return res.status(404).json({ error: 'Question not found' });
    }
    return res.json({ question: updated });
  } catch (err) {
    console.error('Error updating question:', err);
    return res.status(500).json({ error: 'Failed to update question' });
  }
});

// DELETE /api/questions/:id (Admin only)
router.delete('/:id', requireAuth, requireAdmin, async (req, res) => {
  try {
    const deleted = await DB.deleteQuestion(req.params.id);
    if (!deleted) {
      return res.status(404).json({ error: 'Question not found' });
    }
    return res.json({ message: 'Question deleted successfully' });
  } catch (err) {
    console.error('Error deleting question:', err);
    return res.status(500).json({ error: 'Failed to delete question' });
  }
});

module.exports = router;
