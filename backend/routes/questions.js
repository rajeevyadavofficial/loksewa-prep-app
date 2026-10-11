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

// GET /api/questions
router.get('/', optionalAuth, async (req, res) => {
  try {
    const { exam_id, paper, section, unit_number, type } = req.query;
    let rawQuestions = await DB.getAllQuestions({ exam_id, paper, section, unit_number, type });
    // If non-admin candidate has enrolled exams, restrict to only their enrolled exams
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
  } catch (err) {
    console.error('Error fetching questions:', err);
    return res.status(500).json({ error: 'Failed to load questions from database' });
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
