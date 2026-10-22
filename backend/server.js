require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { connectDB, DB } = require('./config/db');

const authRoutes = require('./routes/auth');
const examRoutes = require('./routes/exams');
const questionRoutes = require('./routes/questions');
const adminRoutes = require('./routes/admin');
const settingsRoutes = require('./routes/settings');
const noteRoutes = require('./routes/notes');

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json({ limit: '10mb' }));

// Lightweight Ping Endpoint (for 10-minute Render Keep-Alive)
app.get('/api/ping', (req, res) => {
  res.status(200).json({ status: 'alive', timestamp: new Date().toISOString() });
});

// Health Check
app.get('/api/health', async (req, res) => {
  const [exams, questions, users] = await Promise.all([
    DB.getAllExams(),
    DB.getAllQuestions(),
    DB.getAllUsers(),
  ]);
  res.json({
    status: 'ok',
    service: 'LokSewa Prep Multi-Exam Node.js + MongoDB Atlas API',
    databaseMode: DB.isNativeMongo() ? 'MongoDB Atlas Cloud' : 'Persistent Document Store',
    totalExams: exams.length,
    totalQuestions: questions.length,
    totalUsers: users.length,
    timestamp: new Date().toISOString(),
  });
});

// API Routes
app.use('/api/auth', authRoutes);
app.use('/api/exams', examRoutes);
app.use('/api/questions', questionRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/settings', settingsRoutes);
app.use('/api/notes', noteRoutes);

// Serve Flutter Web static build (if present in backend/public)
const path = require('path');
const fs = require('fs');
const https = require('https');
const publicDir = path.join(__dirname, 'public');
if (fs.existsSync(publicDir)) {
  app.use(express.static(publicDir));
  app.get('*', (req, res, next) => {
    if (req.path.startsWith('/api')) return next();
    res.sendFile(path.join(publicDir, 'index.html'));
  });
}

// 10-Minute Keep-Alive Self-Pinger to prevent Render Free Tier spin-down
const RENDER_URL = process.env.RENDER_EXTERNAL_URL || 'https://loksewa-prep-app.onrender.com';
function startKeepAliveCron() {
  const TEN_MINUTES_MS = 10 * 60 * 1000;
  setInterval(() => {
    const pingUrl = `${RENDER_URL}/api/ping`;
    https
      .get(pingUrl, (res) => {
        console.log(`🔄 [Keep-Alive] Pinged ${pingUrl} — Status: ${res.statusCode} at ${new Date().toISOString()}`);
      })
      .on('error', (err) => {
        console.error(`⚠️ [Keep-Alive] Ping error:`, err.message);
      });
  }, TEN_MINUTES_MS);
  console.log(`⏱️  24/7 Keep-Alive Cron active: Pinging ${RENDER_URL}/api/ping every 10 minutes`);
}

async function startServer() {
  await connectDB();
  app.listen(PORT, () => {
    console.log(`\n🚀 LokSewa Prep Multi-Exam Backend running at: http://localhost:${PORT}`);
    console.log(`   ├─ Health Check:   http://localhost:${PORT}/api/health`);
    console.log(`   ├─ Keep-Alive:     http://localhost:${PORT}/api/ping`);
    console.log(`   ├─ Exams API:      http://localhost:${PORT}/api/exams`);
    console.log(`   ├─ Questions API:  http://localhost:${PORT}/api/questions`);
    console.log(`   ├─ Auth API:       http://localhost:${PORT}/api/auth/login`);
    console.log(`   ├─ Notes API:      http://localhost:${PORT}/api/notes`);
    console.log(`   └─ Admin API:      http://localhost:${PORT}/api/admin/stats\n`);
    startKeepAliveCron();
  });
}

startServer();
