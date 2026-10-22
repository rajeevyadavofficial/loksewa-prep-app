const mongoose = require('mongoose');

const noteSchema = new mongoose.Schema(
  {
    id: { type: String, required: true, unique: true },
    examId: { type: String, required: true, default: 'rbb_it_5' },
    paper: { type: String, required: true, enum: ['paper1', 'paper2'] },
    section: { type: String, required: true, enum: ['sectionA', 'sectionB'] },
    category: { type: String, required: true },
    unitNumber: { type: Number, required: true },
    unitTitle: { type: String, required: true },
    chapterTitle: { type: String, required: true },
    topic: { type: String, required: true },
    title: { type: String, required: true },
    titleNepali: { type: String, default: '' },
    summary: { type: String, default: '' },
    summaryEnglish: { type: String, default: '' },
    summaryNepali: { type: String, default: '' },
    content: { type: String, required: true }, // Full Bilingual Content
    contentEnglish: { type: String, default: '' }, // Dedicated English Textbook Content
    contentNepali: { type: String, default: '' }, // Dedicated Nepali Textbook Content
    keyPoints: [{ type: String }],
    keyPointsEnglish: [{ type: String }],
    keyPointsNepali: [{ type: String }],
    order: { type: Number, default: 0 },
    readTimeMinutes: { type: Number, default: 8 },
  },
  { timestamps: true }
);

noteSchema.index({ examId: 1, paper: 1, unitNumber: 1 });
noteSchema.index({ title: 'text', content: 'text', topic: 'text' });

module.exports = mongoose.model('Note', noteSchema);
