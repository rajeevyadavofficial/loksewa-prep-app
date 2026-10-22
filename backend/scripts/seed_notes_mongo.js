const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });
const mongoose = require('mongoose');
const fs = require('fs');
const Note = require('../models/Note');

const SEED_NOTES_FILE = path.join(__dirname, '..', 'data', 'notes.json');

async function seed() {
  const uri = process.env.MONGO_URI;
  if (!uri) throw new Error('MONGO_URI not found in backend/.env');
  console.log('Connecting to Mongo Atlas...');
  await mongoose.connect(uri, { serverSelectionTimeoutMS: 15000 });
  console.log('Connected to Mongo!');

  const raw = fs.readFileSync(SEED_NOTES_FILE, 'utf8');
  const notes = JSON.parse(raw);

  const ops = notes.map((n) => ({
    updateOne: {
      filter: { id: n.id },
      update: { $set: n },
      upsert: true,
    },
  }));

  const res = await Note.bulkWrite(ops);
  console.log('BulkWrite result upserted:', res.upsertedCount, 'modified:', res.modifiedCount);
  const count = await Note.countDocuments();
  console.log(`Total notes in MongoDB: ${count}`);

  // Also update mongodb_collections.json localStore
  const localDbFile = path.join(__dirname, '..', 'data', 'mongodb_collections.json');
  if (fs.existsSync(localDbFile)) {
    const localStore = JSON.parse(fs.readFileSync(localDbFile, 'utf8'));
    localStore.notes = notes;
    fs.writeFileSync(localDbFile, JSON.stringify(localStore, null, 2), 'utf8');
    console.log('Updated localStore.notes in mongodb_collections.json!');
  }

  await mongoose.disconnect();
}

seed().catch(console.error);
