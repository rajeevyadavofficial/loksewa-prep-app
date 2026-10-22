const fs = require('fs');
const path = require('path');

const dbJsPath = path.join(__dirname, '..', 'config', 'db.js');
let dbJs = fs.readFileSync(dbJsPath, 'utf8');

// Ensure Note model is imported
if (!dbJs.includes("const Note = require('../models/Note');")) {
  dbJs = dbJs.replace(
    "const Question = require('../models/Question');",
    "const Question = require('../models/Question');\nconst Note = require('../models/Note');"
  );
}

// Ensure SEED_NOTES_FILE is defined
if (!dbJs.includes('const SEED_NOTES_FILE =')) {
  dbJs = dbJs.replace(
    "const SEED_EXAMS_FILE = path.join(__dirname, '..', '..', 'assets', 'data', 'exams.json');",
    "const SEED_EXAMS_FILE = path.join(__dirname, '..', '..', 'assets', 'data', 'exams.json');\nconst SEED_NOTES_FILE = path.join(DATA_DIR, 'notes.json');"
  );
}

// Ensure notes: [] is in localStore
if (!dbJs.includes('notes: [],')) {
  dbJs = dbJs.replace('questions: [],', 'questions: [],\n  notes: [],');
}

// Clean up any syntax issue around syncSeedToMongo
const syncSeedPattern = /async function syncSeedToMongo\(\)[\s\S]*?async function connectDB/;
const newSyncSeed = `async function syncSeedToMongo() {
  const { examsData, questionsData, usersData } = await getInitialSeedData();
  for (const ex of examsData) {
    const isComingSoon = ex.id !== 'rbb_it_5';
    await Exam.findOneAndUpdate(
      { id: ex.id },
      { ...ex, is_coming_soon: isComingSoon },
      { upsert: true }
    );
  }
  const ops = questionsData.map((q) => ({
    updateOne: {
      filter: { id: q.id },
      update: { $set: q },
      upsert: true,
    },
  }));
  if (ops.length > 0) {
    await Question.bulkWrite(ops);
  }
  for (const u of usersData) {
    const { _id, ...rest } = u;
    await User.findOneAndUpdate({ email: rest.email }, rest, { upsert: true });
  }
  await syncNotesToMongo();
}

async function syncNotesToMongo() {
  if (fs.existsSync(SEED_NOTES_FILE)) {
    try {
      const notesData = JSON.parse(fs.readFileSync(SEED_NOTES_FILE, 'utf8'));
      if (notesData && notesData.length > 0) {
        const noteOps = notesData.map((n) => ({
          updateOne: {
            filter: { id: n.id },
            update: { $set: n },
            upsert: true,
          },
        }));
        await Note.bulkWrite(noteOps, { ordered: false });
        console.log(\`✅ Synced \${notesData.length} Study Notes into MongoDB Atlas!\`);
      }
    } catch (e) {
      console.error('⚠️ Error syncing notes to Mongo:', e.message);
    }
  }
}

async function connectDB`;

dbJs = dbJs.replace(syncSeedPattern, newSyncSeed);

// In connectDB(), trigger syncNotesToMongo if Note count is 0
if (!dbJs.includes('await syncNotesToMongo();')) {
  dbJs = dbJs.replace(
    'isMongoConnected = true;\n    console.log(`✅ Connected to MongoDB Atlas Cloud Server!`);',
    'isMongoConnected = true;\n    console.log(`✅ Connected to MongoDB Atlas Cloud Server!`);\n    await syncNotesToMongo();'
  );
}

// In fallback catch, load localStore.notes
if (!dbJs.includes('localStore.notes = JSON.parse(fs.readFileSync(SEED_NOTES_FILE, \'utf8\'));')) {
  dbJs = dbJs.replace(
    'localStore.payments = paymentsData;\n      saveLocalStore();',
    `localStore.payments = paymentsData;
      if (fs.existsSync(SEED_NOTES_FILE)) {
        try {
          localStore.notes = JSON.parse(fs.readFileSync(SEED_NOTES_FILE, 'utf8'));
        } catch (_) {}
      }
      saveLocalStore();`
  );
}

// Add DB.getAllNotes and DB.getNoteById if not present
if (!dbJs.includes('getAllNotes(')) {
  const notesMethods = `  // NOTES
  async getAllNotes({ examId, paper, unit, search } = {}) {
    if (isMongoConnected) {
      const query = {};
      if (examId) query.examId = examId;
      if (paper) query.paper = paper;
      if (unit) query.unitNumber = unit;
      if (search && search.trim()) {
        const regex = new RegExp(search.trim(), 'i');
        query.$or = [
          { title: regex },
          { titleNepali: regex },
          { topic: regex },
          { chapterTitle: regex },
          { content: regex },
        ];
      }
      return await Note.find(query).sort({ order: 1, unitNumber: 1 }).lean();
    }

    let list = localStore.notes || [];
    if (list.length === 0 && fs.existsSync(SEED_NOTES_FILE)) {
      try {
        list = JSON.parse(fs.readFileSync(SEED_NOTES_FILE, 'utf8'));
        localStore.notes = list;
      } catch (_) {}
    }

    return list.filter((n) => {
      if (examId && n.examId !== examId) return false;
      if (paper && n.paper !== paper) return false;
      if (unit && n.unitNumber !== unit) return false;
      if (search && search.trim()) {
        const q = search.toLowerCase().trim();
        const str = \`\${n.title} \${n.titleNepali} \${n.topic} \${n.chapterTitle} \${n.content}\`.toLowerCase();
        if (!str.includes(q)) return false;
      }
      return true;
    }).sort((a, b) => (a.order || 0) - (b.order || 0));
  },

  async getNoteById(id) {
    if (isMongoConnected) {
      return await Note.findOne({ id }).lean();
    }
    let list = localStore.notes || [];
    if (list.length === 0 && fs.existsSync(SEED_NOTES_FILE)) {
      try {
        list = JSON.parse(fs.readFileSync(SEED_NOTES_FILE, 'utf8'));
        localStore.notes = list;
      } catch (_) {}
    }
    return list.find((n) => n.id === id) || null;
  },
};`;

  dbJs = dbJs.replace(/\s*};\s*module\.exports = { connectDB, DB };\s*$/, `\n\n${notesMethods}\n\nmodule.exports = { connectDB, DB };\n`);
}

fs.writeFileSync(dbJsPath, dbJs, 'utf8');
console.log('✅ Successfully patched backend/config/db.js with Note methods and syncing');

// Patch backend/server.js
const serverJsPath = path.join(__dirname, '..', 'server.js');
let serverJs = fs.readFileSync(serverJsPath, 'utf8');

if (!serverJs.includes("const noteRoutes = require('./routes/notes');")) {
  serverJs = serverJs.replace(
    "const settingsRoutes = require('./routes/settings');",
    "const settingsRoutes = require('./routes/settings');\nconst noteRoutes = require('./routes/notes');"
  );
  serverJs = serverJs.replace(
    "app.use('/api/settings', settingsRoutes);",
    "app.use('/api/settings', settingsRoutes);\napp.use('/api/notes', noteRoutes);"
  );
  serverJs = serverJs.replace(
    "console.log(`   └─ Admin API:      http://localhost:${PORT}/api/admin/stats\\n`);",
    "console.log(`   ├─ Notes API:      http://localhost:${PORT}/api/notes`);\n    console.log(`   └─ Admin API:      http://localhost:${PORT}/api/admin/stats\\n`);"
  );
  fs.writeFileSync(serverJsPath, serverJs, 'utf8');
  console.log('✅ Successfully patched backend/server.js with /api/notes endpoint');
}
