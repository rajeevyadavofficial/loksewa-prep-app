const express = require('express');
const router = express.Router();
const { DB } = require('../config/db');

// GET /api/notes - Retrieve study notes with optional filters
router.get('/', async (req, res) => {
  try {
    const { exam_id = 'rbb_it_5', paper, unit, search } = req.query;
    const notes = await DB.getAllNotes({
      examId: exam_id,
      paper,
      unit: unit ? parseInt(unit, 10) : undefined,
      search,
    });

    res.json({
      success: true,
      count: notes.length,
      notes,
    });
  } catch (err) {
    console.error('Error fetching notes:', err);
    res.status(500).json({ success: false, message: 'Server error fetching notes', error: err.message });
  }
});

// GET /api/notes/:id - Retrieve single note by ID
router.get('/:id', async (req, res) => {
  try {
    const note = await DB.getNoteById(req.params.id);
    if (!note) {
      return res.status(404).json({ success: false, message: 'Study note not found' });
    }
    res.json({ success: true, note });
  } catch (err) {
    console.error('Error fetching note by id:', err);
    res.status(500).json({ success: false, message: 'Server error fetching note', error: err.message });
  }
});

module.exports = router;
