const mongoose = require('mongoose');

const QuestionDonationSchema = new mongoose.Schema(
  {
    userId: {
      type: String,
      required: true,
      index: true,
    },
    userName: {
      type: String,
      required: true,
    },
    userEmail: {
      type: String,
      required: true,
    },
    walletId: {
      type: String,
      default: '',
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
      default: 'paper1',
    },
    section: {
      type: String,
      enum: ['sectionA', 'sectionB'],
      default: 'sectionA',
    },
    unit_number: {
      type: Number,
      default: 1,
    },
    unit_title: {
      type: String,
      default: 'Unit 1',
    },
    marks: {
      type: Number,
      default: 5,
    },
    type: {
      type: String,
      enum: ['subjective', 'mcq'],
      default: 'subjective',
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
    status: {
      type: String,
      enum: ['pending', 'approved', 'rejected'],
      default: 'pending',
      index: true,
    },
    publishedQuestionId: {
      type: String,
      default: null,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('QuestionDonation', QuestionDonationSchema);
