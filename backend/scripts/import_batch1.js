const fs = require('fs');
const path = require('path');
const mongoose = require('mongoose');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

const Question = require('../models/Question');

async function importBatch1() {
  const uri = process.env.MONGO_URI;
  if (!uri) {
    console.error('❌ MONGO_URI is not defined in backend/.env');
    process.exit(1);
  }

  console.log('🔄 Connecting to MongoDB Atlas...');
  await mongoose.connect(uri);
  console.log('✅ Connected to MongoDB Atlas.');

  const batchFile = path.join(__dirname, 'batch1_questions.json');
  if (!fs.existsSync(batchFile)) {
    console.error('❌ batch1_questions.json not found!');
    process.exit(1);
  }

  const batchQuestions = JSON.parse(fs.readFileSync(batchFile, 'utf8'));
  console.log(`📦 Loaded ${batchQuestions.length} questions from batch1_questions.json`);

  const initialCount = await Question.countDocuments();
  console.log(`📊 Current Questions in MongoDB: ${initialCount}`);

  let insertedCount = 0;
  let updatedCount = 0;

  for (const q of batchQuestions) {
    const res = await Question.updateOne(
      { id: q.id },
      { $set: q },
      { upsert: true }
    );
    if (res.upsertedCount > 0) {
      insertedCount++;
    } else if (res.modifiedCount > 0) {
      updatedCount++;
    }
  }

  const finalCount = await Question.countDocuments();
  console.log(`\n🎉 Ingestion Complete!`);
  console.log(`   - Newly Inserted: ${insertedCount}`);
  console.log(`   - Updated/Refreshed: ${updatedCount}`);
  console.log(`   - Final MongoDB Total Questions: ${finalCount}`);

  // Sync to assets/data/questions.json
  const seedFile = path.join(__dirname, '..', '..', 'assets', 'data', 'questions.json');
  if (fs.existsSync(seedFile)) {
    const existingSeed = JSON.parse(fs.readFileSync(seedFile, 'utf8'));
    const seedMap = new Map();
    existingSeed.forEach(item => seedMap.set(item.id, item));
    batchQuestions.forEach(item => seedMap.set(item.id, item));
    
    const mergedSeed = Array.from(seedMap.values());
    fs.writeFileSync(seedFile, JSON.stringify(mergedSeed, null, 2), 'utf8');
    console.log(`💾 Synced assets/data/questions.json! Total items now: ${mergedSeed.length}`);
  }

  await mongoose.disconnect();
  console.log('🔌 Disconnected cleanly.');
  process.exit(0);
}

importBatch1().catch(err => {
  console.error('❌ Ingestion Error:', err);
  process.exit(1);
});
