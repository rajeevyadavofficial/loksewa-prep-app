const mongoose = require('mongoose');

const QuestionSchema = new mongoose.Schema(
  {
    id: {
      type: String,
      required: true,
      unique: true,
      index: true,
    },
    exam_id: {
      type: String,
      required: true,
      default: 'rbb_it_5',
      index: true,
    },
    paper: {
      type: String,
      enum: ['paper1', 'paper2'],
      required: true,
    },
    section: {
      type: String,
      enum: ['sectionA', 'sectionB'],
      required: true,
    },
    unit_number: {
      type: Number,
      required: true,
    },
    unit_title: {
      type: String,
      required: true,
    },
    marks: {
      type: Number,
      required: true,
    },
    type: {
      type: String,
      enum: ['subjective', 'mcq'],
      required: true,
    },
    years_asked: {
      type: [String],
      default: [],
    },
    question_nepali: {
      type: String,
      required: true,
    },
    question_english: {
      type: String,
      required: true,
    },
    answer_nepali: {
      type: String,
      default: null,
    },
    answer_english: {
      type: String,
      default: null,
    },
    options: {
      type: [String],
      default: null,
    },
    correct_option_index: {
      type: Number,
      default: null,
    },
    explanation: {
      type: String,
      default: null,
    },
    is_premium: {
      type: Boolean,
      default: false,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('Question', QuestionSchema);
