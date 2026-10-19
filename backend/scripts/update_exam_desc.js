const mongoose = require('mongoose');
require('dotenv').config({ path: require('path').resolve(__dirname, '../.env') });
const Exam = require('../models/Exam');

async function updateDesc() {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    const res = await Exam.updateOne(
      { id: 'rbb_it_5' },
      { $set: { description: 'Complete 20-year past question bank (2,000+ Q&As: 837 MCQs & 1,174 Subjective Model Q&As) covering Paper I (Banking & Management + IT MCQs) and Paper II (Technical Subjects).' } }
    );
    console.log('Update result:', res);
    await mongoose.disconnect();
    process.exit(0);
  } catch (err) {
    console.error('Error updating exam description:', err);
    process.exit(1);
  }
}

updateDesc();
