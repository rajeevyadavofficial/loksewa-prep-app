const express = require('express');
const { DB } = require('../config/db');
const { requireAuth, requireAdmin } = require('../middleware/auth');

const router = express.Router();

// GET /api/exams — Public list of all Lok Sewa exams with question counts
router.get('/', async (req, res) => {
  try {
    const [exams, allQuestions] = await Promise.all([
      DB.getAllExams(),
      DB.getAllQuestions(),
    ]);

    const countByExam = {};
    for (const q of allQuestions) {
      const eid = q.exam_id || 'rbb_it_5';
      countByExam[eid] = (countByExam[eid] || 0) + 1;
    }

    const enriched = exams.map((e) => ({
      ...e,
      question_count: countByExam[e.id] || 0,
    }));

    return res.json({ total: enriched.length, exams: enriched });
  } catch (err) {
    console.error('Error fetching exams:', err);
    return res.status(500).json({ error: 'Failed to load exams' });
  }
});

// POST /api/exams — Admin creates or updates a Lok Sewa Exam
router.post('/', requireAuth, requireAdmin, async (req, res) => {
  try {
    const examData = req.body;
    if (!examData.id || !examData.title || !examData.category) {
      return res.status(400).json({ error: 'id, title, and category are required' });
    }
    const created = await DB.createExam({
      ...examData,
      is_active: true,
    });
    return res.status(201).json({ exam: created });
  } catch (err) {
    console.error('Error creating exam:', err);
    return res.status(500).json({ error: 'Failed to create exam' });
  }
});

// PUT /api/exams/:id/status — Admin toggles Coming Soon / Live status
router.put('/:id/status', requireAuth, requireAdmin, async (req, res) => {
  try {
    const { is_coming_soon } = req.body;
    const updated = await DB.updateExamStatus(req.params.id, !!is_coming_soon);
    if (!updated) {
      return res.status(404).json({ error: 'Exam not found' });
    }
    return res.json({
      message: `Exam status updated (${updated.is_coming_soon ? 'Coming Soon' : 'Live & Active'})`,
      exam: updated,
    });
  } catch (err) {
    console.error('Error updating exam status:', err);
    return res.status(500).json({ error: 'Failed to update exam status' });
  }
});

// DELETE /api/exams/:id — Admin deletes an Exam
router.delete('/:id', requireAuth, requireAdmin, async (req, res) => {
  try {
    const ok = await DB.deleteExam(req.params.id);
    if (!ok) {
      return res.status(404).json({ error: 'Exam not found' });
    }
    return res.json({ message: 'Exam deleted successfully' });
  } catch (err) {
    console.error('Error deleting exam:', err);
    return res.status(500).json({ error: 'Failed to delete exam' });
  }
});

module.exports = router;
