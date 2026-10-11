const mongoose = require('mongoose');

const ExamSchema = new mongoose.Schema(
  {
    id: {
      type: String,
      required: true,
      unique: true,
      index: true,
    },
    title: {
      type: String,
      required: true,
    },
    title_nepali: {
      type: String,
      required: true,
    },
    category: {
      type: String,
      enum: ['Banking', 'Civil Service', 'IT & Technical', 'Sansthan'],
      required: true,
    },
    organization: {
      type: String,
      required: true,
    },
    level: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      default: '',
    },
    exam_scheme: {
      type: [String],
      default: [],
    },
    syllabus_sections: {
      type: [
        {
          title: String,
          topics: [String],
        },
      ],
      default: [],
    },
    is_active: {
      type: Boolean,
      default: true,
    },
    is_coming_soon: {
      type: Boolean,
      default: false,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('Exam', ExamSchema);
