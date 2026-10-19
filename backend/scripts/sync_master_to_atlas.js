const fs = require('fs');
const path = require('path');
const mongoose = require('mongoose');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

const Question = require('../models/Question');

async function syncMasterToAtlas() {
  const uri = process.env.MONGO_URI;
  if (!uri) {
    console.error('❌ MONGO_URI is not defined in backend/.env');
    process.exit(1);
  }

  console.log('🔄 Connecting to MongoDB Atlas...');
  await mongoose.connect(uri);
  console.log('✅ Connected to MongoDB Atlas.');

  const masterFile = path.join(__dirname, 'master_clean_questions.json');
  if (!fs.existsSync(masterFile)) {
    console.error('❌ master_clean_questions.json not found!');
    process.exit(1);
  }

  const masterQuestions = JSON.parse(fs.readFileSync(masterFile, 'utf8'));
  console.log(`📦 Loaded ${masterQuestions.length} master questions from master_clean_questions.json`);

  const initialCount = await Question.countDocuments();
  console.log(`📊 Initial Questions in MongoDB Atlas: ${initialCount}`);

  // Purge any questions with template placeholder text if any exist
  const deleteTemplateRes = await Question.deleteMany({
    $or: [
      { answer_nepali: { $regex: 'सम्बन्धी लोकसेवा आयोगको सम्भावित प्रश्न' } },
      { answer_nepali: { $regex: 'का लागि अपरिहार्य कानुनी तथा प्राविधिक स्तम्भ हो' } }
    ]
  });
  console.log(`🧹 Purged ${deleteTemplateRes.deletedCount} repetitive template records from MongoDB Atlas.`);

  // Perform bulk upsert operations in chunks of 200
  const masterIds = new Set(masterQuestions.map(q => q.id));
  const bulkOps = masterQuestions.map(q => ({
    updateOne: {
      filter: { id: q.id },
      update: { $set: q },
      upsert: true
    }
  }));

  const chunkSize = 200;
  let totalUpserted = 0;
  let totalModified = 0;

  for (let i = 0; i < bulkOps.length; i += chunkSize) {
    const chunk = bulkOps.slice(i, i + chunkSize);
    const result = await Question.bulkWrite(chunk, { ordered: false });
    totalUpserted += result.upsertedCount || 0;
    totalModified += result.modifiedCount || 0;
    process.stdout.write(`   Processed ${Math.min(i + chunkSize, bulkOps.length)}/${bulkOps.length} questions...\r`);
  }

  console.log(`\n✅ Bulk Upsert finished! Upserted: ${totalUpserted}, Modified: ${totalModified}`);

  // Audit final database state
  const finalCount = await Question.countDocuments();
  const mcqCount = await Question.countDocuments({ type: 'mcq' });
  const subjectiveCount = await Question.countDocuments({ type: 'subjective' });

  console.log('\n=========================================');
  console.log('🌟 MONGODB ATLAS SYNCHRONIZATION AUDIT 🌟');
  console.log('=========================================');
  console.log(`🎯 Total Questions in Atlas: ${finalCount}`);
  console.log(`📊 Total MCQs:               ${mcqCount}`);
  console.log(`📝 Total Subjective Q&As:    ${subjectiveCount}`);
  console.log('=========================================\n');

  await mongoose.disconnect();
  console.log('🔌 Disconnected from MongoDB Atlas.');
  process.exit(0);
}

syncMasterToAtlas().catch(err => {
  console.error('❌ Error during synchronization:', err);
  process.exit(1);
});
