require('dotenv').config();
const { connectDB, DB } = require('./config/db');

async function runSeed() {
  await connectDB(true);
  const exams = await DB.getAllExams();
  const questions = await DB.getAllQuestions();
  const users = await DB.getAllUsers();
  console.log(`✅ MongoDB Atlas Ready! Total Exams: ${exams.length}, Total Questions: ${questions.length}, Total Users: ${users.length}`);
  process.exit(0);
}

runSeed();
