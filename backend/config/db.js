const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const bcrypt = require('bcryptjs');
const mongoose = require('mongoose');

const User = require('../models/User');
const Exam = require('../models/Exam');
const Question = require('../models/Question');
const Payment = require('../models/Payment');
const Settings = require('../models/Settings');
const QuestionDonation = require('../models/QuestionDonation');

const DATA_DIR = path.join(__dirname, '..', 'data');
const LOCAL_DB_FILE = path.join(DATA_DIR, 'mongodb_collections.json');
const SEED_QUESTIONS_FILE = path.join(__dirname, '..', '..', 'assets', 'data', 'questions.json');
const SEED_EXAMS_FILE = path.join(__dirname, '..', '..', 'assets', 'data', 'exams.json');

const DEFAULT_SETTINGS = {
  key: 'payment_config',
  whatsappNumber: '+977-9705419699',
  whatsappLink: 'https://wa.me/9779705419699',
  whatsappQrUrl: 'https://res.cloudinary.com/rajeevyadav/image/upload/v1791720922/loksewa_prep/s2kdezawa20cg6ycco7d.jpg',
  paymentQrUrl: 'https://res.cloudinary.com/rajeevyadav/image/upload/v1791720911/loksewa_prep/wxs7zoxae5cwyczac6lx.jpg',
  esewaId: '9800000000',
  khaltiId: '9800000001',
  fonepayMerchant: 'LokSewa Prep Nepal (FonePay QR)',
  bankName: 'Rastriya Banijya Bank (RBB)',
  bankAccountName: 'LokSewa Prep Nepal Pvt. Ltd.',
  bankAccountNumber: '1010001007180003',
  bankBranch: 'Singhadurbar Plaza Branch, Kathmandu',
  supportEmail: 'support@loksewaprep.com.np',
  supportPhone: '+977-01-4200000 / 9800000000',
  officeAddress: 'Putalisadak, Kathmandu, Nepal',
  verificationNote: 'After completing payment via eSewa, Khalti, FonePay QR, or Bank Transfer, please send your payment screenshot along with your registered Email Address to our official WhatsApp number or scan the WhatsApp QR code below. Your Pro plan will be activated immediately upon verification.',
};

let isMongoConnected = false;
let localStore = {
  users: [],
  exams: [],
  questions: [],
  payments: [],
  donations: [],
  settings: { ...DEFAULT_SETTINGS },
};

function saveLocalStore() {
  if (!fs.existsSync(DATA_DIR)) {
    fs.mkdirSync(DATA_DIR, { recursive: true });
  }
  fs.writeFileSync(LOCAL_DB_FILE, JSON.stringify(localStore, null, 2), 'utf8');
}

async function getInitialSeedData() {
  let questionsData = [];
  let examsData = [];
  if (fs.existsSync(SEED_QUESTIONS_FILE)) {
    questionsData = JSON.parse(fs.readFileSync(SEED_QUESTIONS_FILE, 'utf8'));
  }
  if (fs.existsSync(SEED_EXAMS_FILE)) {
    examsData = JSON.parse(fs.readFileSync(SEED_EXAMS_FILE, 'utf8'));
  }

  const adminHash = await bcrypt.hash('admin123', 10);
  const now = new Date().toISOString();
  const nextMonth = new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString();

  const usersData = [
    {
      _id: 'usr_admin_01',
      name: 'Rajeev (Admin)',
      email: 'admin@loksewa.com',
      passwordHash: adminHash,
      plan: 'premium',
      planExpiresAt: nextMonth,
      isAdmin: true,
      bookmarkedQuestions: [],
      createdAt: now,
    },
  ];

  const paymentsData = [];

  return { examsData, questionsData, usersData, paymentsData };
}

async function syncSeedToMongo() {
  const { examsData, questionsData, usersData } = await getInitialSeedData();
  for (const ex of examsData) {
    const isComingSoon = ex.id !== 'rbb_it_5';
    await Exam.findOneAndUpdate(
      { id: ex.id },
      { ...ex, is_coming_soon: isComingSoon },
      { upsert: true }
    );
  }
  // Upsert all questions with exam_id
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
}

async function connectDB(forceReseed = false) {
  const uri = process.env.MONGO_URI || 'mongodb://127.0.0.1:27017/loksewa_prep';
  const demoEmails = ['premium@demo.com', 'basic@demo.com', 'demo@loksewa.np', 'pro@loksewa.np'];
  try {
    await mongoose.connect(uri, { serverSelectionTimeoutMS: 15000 });
    isMongoConnected = true;
    console.log(`✅ Connected to MongoDB Atlas Cloud Server!`);

    // Purge any legacy demo accounts and demo payments
    await User.deleteMany({ email: { $in: demoEmails } });
    await Payment.deleteMany({ userEmail: { $in: demoEmails } });

    const eCount = await Exam.countDocuments();
    const qCount = await Question.countDocuments();
    const comingSoonCount = await Exam.countDocuments({ is_coming_soon: true });
    if (eCount === 0 || qCount < 150 || forceReseed) {
      console.log('🌱 Syncing Multi-Exam Catalog & Questions into MongoDB Atlas...');
      await syncSeedToMongo();
      console.log(`✅ Synced Exams & Questions into MongoDB Atlas!`);
    } else if (comingSoonCount === 0) {
      // One-time migration: Set all exams except rbb_it_5 to Coming Soon
      await Exam.updateMany({ id: { $ne: 'rbb_it_5' } }, { $set: { is_coming_soon: true } });
      await Exam.updateOne({ id: 'rbb_it_5' }, { $set: { is_coming_soon: false } });
      console.log('✅ Configured RBB IT Level 5 as Live and all other exams as Coming Soon in MongoDB Atlas.');
    }
  } catch (err) {
    isMongoConnected = false;
    console.log(`ℹ️ MongoDB connection fallback (${err.message}).`);
    console.log(`📂 Using Persistent MongoDB-Compatible Document Store: ${LOCAL_DB_FILE}`);

    const { examsData, questionsData, usersData, paymentsData } = await getInitialSeedData();
    const seededExams = examsData.map((e) => ({
      ...e,
      is_coming_soon: e.id !== 'rbb_it_5',
    }));
    if (fs.existsSync(LOCAL_DB_FILE) && !forceReseed) {
      localStore = JSON.parse(fs.readFileSync(LOCAL_DB_FILE, 'utf8'));
      // Purge any legacy demo accounts and demo payments from localStore
      localStore.users = (localStore.users || []).filter((u) => !demoEmails.includes(u.email));
      localStore.payments = (localStore.payments || []).filter((p) => !demoEmails.includes(p.userEmail));
      if (!localStore.exams || localStore.exams.length === 0) {
        localStore.exams = seededExams;
      } else if (!localStore.exams.some((e) => e.is_coming_soon === true)) {
        localStore.exams = localStore.exams.map((e) => ({
          ...e,
          is_coming_soon: e.id !== 'rbb_it_5',
        }));
      }
      saveLocalStore();
    } else {
      localStore.exams = seededExams;
      localStore.questions = questionsData.map((q) => ({
        _id: 'q_' + crypto.randomBytes(6).toString('hex'),
        ...q,
      }));
      localStore.users = usersData;
      localStore.payments = paymentsData;
      saveLocalStore();
    }
  }
}

const DB = {
  isNativeMongo: () => isMongoConnected,

  // EXAMS
  async getAllExams() {
    if (isMongoConnected) {
      return await Exam.find({ is_active: true }).lean();
    }
    return localStore.exams || [];
  },

  async createExam(examData) {
    if (isMongoConnected) {
      const created = await Exam.findOneAndUpdate({ id: examData.id }, examData, { upsert: true, new: true }).lean();
      return created;
    }
    const idx = localStore.exams.findIndex((e) => e.id === examData.id);
    if (idx >= 0) {
      localStore.exams[idx] = { ...localStore.exams[idx], ...examData };
    } else {
      localStore.exams.push({ _id: 'ex_' + crypto.randomBytes(4).toString('hex'), is_active: true, ...examData });
    }
    saveLocalStore();
    return examData;
  },

  async updateExamStatus(examId, isComingSoon) {
    if (isMongoConnected) {
      return await Exam.findOneAndUpdate(
        { id: examId },
        { $set: { is_coming_soon: !!isComingSoon } },
        { new: true }
      ).lean();
    }
    const idx = localStore.exams.findIndex((e) => e.id === examId);
    if (idx === -1) return null;
    localStore.exams[idx].is_coming_soon = !!isComingSoon;
    saveLocalStore();
    return localStore.exams[idx];
  },

  async deleteExam(examId) {
    if (isMongoConnected) {
      const res = await Exam.findOneAndDelete({ id: examId });
      return !!res;
    }
    const idx = localStore.exams.findIndex((e) => e.id === examId);
    if (idx === -1) return false;
    localStore.exams.splice(idx, 1);
    saveLocalStore();
    return true;
  },

  // Helper: Check and auto-downgrade expired subscriptions
  async _checkAndExpireUser(u) {
    if (!u || u.isAdmin || !u.plan || u.plan === 'free' || !u.planExpiresAt) return u;
    const expTime = new Date(u.planExpiresAt).getTime();
    if (!isNaN(expTime) && expTime <= Date.now()) {
      const uid = u._id ? u._id.toString() : '';
      if (isMongoConnected && uid) {
        await User.findByIdAndUpdate(uid, { $set: { plan: 'free', planExpiresAt: null } });
      }
      const idx = (localStore.users || []).findIndex(
        (item) => String(item._id) === String(uid) || item.email === u.email
      );
      if (idx >= 0) {
        localStore.users[idx].plan = 'free';
        localStore.users[idx].planExpiresAt = null;
        saveLocalStore();
      }
      return { ...u, plan: 'free', planExpiresAt: null };
    }
    return u;
  },

  // USERS
  async findUserByEmail(email) {
    const cleanEmail = email.toLowerCase().trim();
    if (isMongoConnected) {
      const u = await User.findOne({ email: cleanEmail }).lean();
      if (!u) return null;
      return await this._checkAndExpireUser({ ...u, _id: u._id.toString() });
    }
    const found = localStore.users.find((u) => u.email === cleanEmail) || null;
    return await this._checkAndExpireUser(found);
  },

  async findUserById(id) {
    if (isMongoConnected) {
      if (!mongoose.Types.ObjectId.isValid(id)) return null;
      const u = await User.findById(id).lean();
      if (!u) return null;
      return await this._checkAndExpireUser({ ...u, _id: u._id.toString() });
    }
    const found = localStore.users.find((u) => u._id === id) || null;
    return await this._checkAndExpireUser(found);
  },

  async createUser({ name, email, passwordHash, plan = 'free', isAdmin = false }) {
    const cleanEmail = email.toLowerCase().trim();
    if (isMongoConnected) {
      const created = await User.create({ name, email: cleanEmail, passwordHash, plan, isAdmin });
      const obj = { ...created.toObject(), _id: created._id.toString() };
      localStore.users = (localStore.users || []).filter((u) => u.email !== cleanEmail);
      localStore.users.push(obj);
      saveLocalStore();
      return obj;
    }
    const newUser = {
      _id: 'usr_' + crypto.randomBytes(6).toString('hex'),
      name,
      email: cleanEmail,
      passwordHash,
      plan,
      planExpiresAt: null,
      isAdmin,
      bookmarkedQuestions: [],
      enrolledExams: [],
      createdAt: new Date().toISOString(),
    };
    localStore.users.push(newUser);
    saveLocalStore();
    return newUser;
  },

  async updateUserEnrolledExams(userId, enrolledExams) {
    const cleanList = Array.from(new Set((enrolledExams || []).filter(Boolean)));
    if (isMongoConnected) {
      const updated = await User.findByIdAndUpdate(
        userId,
        { $set: { enrolledExams: cleanList } },
        { new: true }
      ).lean();
      if (updated) {
        const idx = (localStore.users || []).findIndex(
          (u) => String(u._id) === String(userId) || u.email === updated.email
        );
        if (idx >= 0) {
          localStore.users[idx].enrolledExams = cleanList;
          saveLocalStore();
        }
      }
      return updated ? { ...updated, _id: updated._id.toString() } : null;
    }
    const idx = localStore.users.findIndex((u) => String(u._id) === String(userId));
    if (idx === -1) return null;
    localStore.users[idx].enrolledExams = cleanList;
    saveLocalStore();
    return localStore.users[idx];
  },

  async updateUserPlan(userId, plan, options = {}) {
    let expiresAt = null;
    if (plan !== 'free') {
      if (options.expiresAt) {
        const parsed = new Date(options.expiresAt);
        expiresAt = !isNaN(parsed.getTime())
          ? parsed.toISOString()
          : new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString();
      } else {
        const days = Number(options.durationDays) > 0 ? Number(options.durationDays) : 30;
        expiresAt = new Date(Date.now() + days * 24 * 60 * 60 * 1000).toISOString();
      }
    }
    if (isMongoConnected) {
      const updated = await User.findByIdAndUpdate(
        userId,
        { plan, planExpiresAt: expiresAt },
        { new: true }
      ).lean();
      if (updated) {
        const idx = (localStore.users || []).findIndex(
          (u) => String(u._id) === String(userId) || u.email === updated.email
        );
        if (idx >= 0) {
          localStore.users[idx].plan = plan;
          localStore.users[idx].planExpiresAt = expiresAt;
          saveLocalStore();
        }
      }
      return updated ? { ...updated, _id: updated._id.toString() } : null;
    }
    const idx = localStore.users.findIndex((u) => String(u._id) === String(userId));
    if (idx === -1) return null;
    localStore.users[idx].plan = plan;
    localStore.users[idx].planExpiresAt = expiresAt;
    saveLocalStore();
    return localStore.users[idx];
  },

  async getAllUsers() {
    if (isMongoConnected) {
      const users = await User.find().sort({ createdAt: -1 }).lean();
      const checked = [];
      for (const u of users) {
        checked.push(await this._checkAndExpireUser({ ...u, _id: u._id.toString() }));
      }
      return checked;
    }
    const checked = [];
    for (const u of [...localStore.users].reverse()) {
      checked.push(await this._checkAndExpireUser(u));
    }
    return checked;
  },

  async deleteUser(userId) {
    if (isMongoConnected) {
      const res = await User.findByIdAndDelete(userId);
      await Payment.deleteMany({ userId: String(userId), status: 'pending' });
      return !!res;
    }
    const idx = localStore.users.findIndex((u) => String(u._id) === String(userId));
    if (idx === -1) return false;
    localStore.users.splice(idx, 1);
    localStore.payments = localStore.payments.filter(
      (p) => !(String(p.userId) === String(userId) && p.status === 'pending')
    );
    saveLocalStore();
    return true;
  },

  async getQuestionsCount(filters = {}) {
    if (isMongoConnected) {
      const query = {};
      if (filters.exam_id) query.exam_id = filters.exam_id;
      return await Question.countDocuments(query);
    }
    if (filters.exam_id) {
      return (localStore.questions || []).filter((q) => (q.exam_id || 'rbb_it_5') === filters.exam_id).length;
    }
    return (localStore.questions || []).length;
  },

  async getAllQuestions(filters = {}) {
    let list;
    if (isMongoConnected) {
      const query = {};
      if (filters.exam_id) query.exam_id = filters.exam_id;
      if (filters.paper) query.paper = filters.paper;
      if (filters.section) query.section = filters.section;
      if (filters.unit_number) query.unit_number = Number(filters.unit_number);
      if (filters.type) query.type = filters.type;
      list = await Question.find(query).lean();
    } else {
      list = localStore.questions.filter((q) => {
        if (filters.exam_id && (q.exam_id || 'rbb_it_5') !== filters.exam_id) return false;
        if (filters.paper && q.paper !== filters.paper) return false;
        if (filters.section && q.section !== filters.section) return false;
        if (filters.unit_number && q.unit_number !== Number(filters.unit_number)) return false;
        if (filters.type && q.type !== filters.type) return false;
        return true;
      });
    }
    return list;
  },

  async getQuestionsPaginated(filters = {}, { page = 1, limit = 10 } = {}) {
    page = Math.max(1, parseInt(page) || 1);
    limit = parseInt(limit) || 10;
    const skip = (page - 1) * limit;

    if (isMongoConnected) {
      const query = {};
      if (filters.exam_id && filters.exam_id !== 'all') query.exam_id = filters.exam_id;
      if (filters.paper) query.paper = filters.paper;
      if (filters.section) query.section = filters.section;
      if (filters.unit_number) query.unit_number = Number(filters.unit_number);
      if (filters.type) query.type = filters.type;
      if (filters.search && filters.search.trim()) {
        const s = filters.search.trim();
        query.$or = [
          { question_nepali: { $regex: s, $options: 'i' } },
          { question_english: { $regex: s, $options: 'i' } },
          { unit_title: { $regex: s, $options: 'i' } },
        ];
      }

      const [total, questions] = await Promise.all([
        Question.countDocuments(query),
        Question.find(query)
          .sort({ unit_number: 1, id: 1 })
          .skip(skip)
          .limit(limit)
          .lean(),
      ]);

      return {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit) || 1,
        questions,
      };
    } else {
      const filtered = localStore.questions.filter((q) => {
        if (filters.exam_id && filters.exam_id !== 'all' && (q.exam_id || 'rbb_it_5') !== filters.exam_id) return false;
        if (filters.paper && q.paper !== filters.paper) return false;
        if (filters.section && q.section !== filters.section) return false;
        if (filters.unit_number && q.unit_number !== Number(filters.unit_number)) return false;
        if (filters.type && q.type !== filters.type) return false;
        if (filters.search && filters.search.trim()) {
          const s = filters.search.trim().toLowerCase();
          const matchNepali = (q.question_nepali || '').toLowerCase().includes(s);
          const matchEnglish = (q.question_english || '').toLowerCase().includes(s);
          const matchUnit = (q.unit_title || '').toLowerCase().includes(s);
          if (!matchNepali && !matchEnglish && !matchUnit) return false;
        }
        return true;
      });

      const total = filtered.length;
      const questions = filtered.slice(skip, skip + limit);
      return {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit) || 1,
        questions,
      };
    }
  },

  async createQuestion(qData) {
    const payload = { exam_id: 'rbb_it_5', ...qData };
    if (isMongoConnected) {
      const created = await Question.findOneAndUpdate({ id: payload.id }, payload, { upsert: true, new: true }).lean();
      return created;
    }
    const newQ = {
      _id: 'q_' + crypto.randomBytes(6).toString('hex'),
      ...payload,
      createdAt: new Date().toISOString(),
    };
    localStore.questions.push(newQ);
    saveLocalStore();
    return newQ;
  },

  async updateQuestion(questionId, updates) {
    if (isMongoConnected) {
      return await Question.findOneAndUpdate({ id: questionId }, updates, { new: true }).lean();
    }
    const idx = localStore.questions.findIndex((q) => q.id === questionId);
    if (idx === -1) return null;
    localStore.questions[idx] = { ...localStore.questions[idx], ...updates };
    saveLocalStore();
    return localStore.questions[idx];
  },

  async deleteQuestion(questionId) {
    if (isMongoConnected) {
      const res = await Question.findOneAndDelete({ id: questionId });
      return !!res;
    }
    const idx = localStore.questions.findIndex((q) => q.id === questionId);
    if (idx === -1) return false;
    localStore.questions.splice(idx, 1);
    saveLocalStore();
    return true;
  },

  // PAYMENTS
  async createPayment(pData) {
    if (isMongoConnected) {
      const created = await Payment.create(pData);
      return created.toObject();
    }
    const newPay = {
      _id: 'pay_' + crypto.randomBytes(6).toString('hex'),
      ...pData,
      createdAt: new Date().toISOString(),
    };
    localStore.payments.push(newPay);
    saveLocalStore();
    return newPay;
  },

  async getAllPayments() {
    if (isMongoConnected) {
      return await Payment.find().sort({ createdAt: -1 }).lean();
    }
    return [...localStore.payments].reverse();
  },

  async verifyPayment(paymentId, action, options = {}) {
    const newStatus = action === 'approve' ? 'completed' : 'rejected';
    if (isMongoConnected) {
      const payment = await Payment.findByIdAndUpdate(
        paymentId,
        { $set: { status: newStatus } },
        { new: true }
      ).lean();
      if (!payment) return null;
      let updatedUser = null;
      if (action === 'approve' && payment.userId && payment.plan) {
        updatedUser = await this.updateUserPlan(payment.userId, payment.plan, options);
      }
      return { payment, user: updatedUser };
    }
    const p = localStore.payments.find((item) => String(item._id) === String(paymentId));
    if (!p) return null;
    p.status = newStatus;
    saveLocalStore();
    let updatedUser = null;
    if (action === 'approve' && p.userId && p.plan) {
      updatedUser = await this.updateUserPlan(p.userId, p.plan, options);
    }
    return { payment: p, user: updatedUser };
  },

  async deletePayment(paymentId) {
    if (isMongoConnected) {
      const res = await Payment.findByIdAndDelete(paymentId);
      return !!res;
    }
    const idx = localStore.payments.findIndex((item) => String(item._id) === String(paymentId));
    if (idx === -1) return false;
    localStore.payments.splice(idx, 1);
    saveLocalStore();
    return true;
  },

  // SETTINGS (Payment QR, WhatsApp QR, Contacts, Bank Details)
  async getSettings() {
    if (isMongoConnected) {
      let doc = await Settings.findOne({ key: 'payment_config' }).lean();
      if (!doc) {
        const seedSettings = localStore.settings || DEFAULT_SETTINGS;
        const created = await Settings.create(seedSettings);
        doc = created.toObject();
      }
      return doc;
    }
    if (!localStore.settings) {
      localStore.settings = { ...DEFAULT_SETTINGS };
      saveLocalStore();
    }
    return localStore.settings;
  },

  async updateSettings(updates) {
    const clean = { ...updates, key: 'payment_config' };
    if (clean.payment_qr_url && !clean.paymentQrUrl) {
      clean.paymentQrUrl = clean.payment_qr_url;
    }
    if (clean.whatsapp_qr_url && !clean.whatsappQrUrl) {
      clean.whatsappQrUrl = clean.whatsapp_qr_url;
    }
    delete clean.payment_qr_url;
    delete clean.whatsapp_qr_url;
    delete clean._id;

    localStore.settings = { ...(localStore.settings || DEFAULT_SETTINGS), ...clean };
    saveLocalStore();

    if (isMongoConnected) {
      const updated = await Settings.findOneAndUpdate(
        { key: 'payment_config' },
        { $set: clean },
        { upsert: true, new: true }
      ).lean();
      return updated;
    }
    return localStore.settings;
  },

  // QUESTION DONATIONS (Candidate Donate & Earn: 100 Verified Questions = Rs. 5)
  async createQuestionDonation(dData) {
    if (isMongoConnected) {
      const created = await QuestionDonation.create(dData);
      const obj = { ...created.toObject(), _id: created._id.toString() };
      localStore.donations = localStore.donations || [];
      localStore.donations.push(obj);
      saveLocalStore();
      return obj;
    }
    localStore.donations = localStore.donations || [];
    const newDonation = {
      _id: 'don_' + crypto.randomBytes(6).toString('hex'),
      status: 'pending',
      ...dData,
      createdAt: new Date().toISOString(),
    };
    localStore.donations.push(newDonation);
    saveLocalStore();
    return newDonation;
  },

  async getDonationsByUser(userId) {
    if (isMongoConnected) {
      const docs = await QuestionDonation.find({ userId: String(userId) }).sort({ createdAt: -1 }).lean();
      return docs.map((d) => ({ ...d, _id: d._id.toString() }));
    }
    localStore.donations = localStore.donations || [];
    return [...localStore.donations]
      .filter((d) => String(d.userId) === String(userId))
      .reverse();
  },

  async getAllDonations() {
    if (isMongoConnected) {
      const docs = await QuestionDonation.find().sort({ createdAt: -1 }).lean();
      return docs.map((d) => ({ ...d, _id: d._id.toString() }));
    }
    localStore.donations = localStore.donations || [];
    return [...localStore.donations].reverse();
  },

  async verifyQuestionDonation(donationId, action) {
    const newStatus = action === 'approve' ? 'approved' : 'rejected';
    let donation = null;

    if (isMongoConnected && mongoose.Types.ObjectId.isValid(donationId)) {
      donation = await QuestionDonation.findById(donationId).lean();
    }
    if (!donation) {
      localStore.donations = localStore.donations || [];
      donation = localStore.donations.find((d) => String(d._id) === String(donationId)) || null;
    }
    if (!donation) return null;

    let publishedQuestionId = donation.publishedQuestionId || null;
    let publishedQuestion = null;

    if (action === 'approve' && !publishedQuestionId) {
      publishedQuestionId = `donated_${Date.now().toString(36)}_${crypto.randomBytes(2).toString('hex')}`;
      publishedQuestion = await this.createQuestion({
        id: publishedQuestionId,
        exam_id: donation.exam_id || 'rbb_it_5',
        paper: donation.paper || 'paper1',
        section: donation.section || 'sectionA',
        unit_number: Number(donation.unit_number) || 1,
        unit_title: donation.unit_title || `Unit ${donation.unit_number || 1}`,
        marks: Number(donation.marks) || (donation.type === 'mcq' ? 1 : 5),
        type: donation.type || 'subjective',
        years_asked: Array.isArray(donation.years_asked) && donation.years_asked.length > 0
          ? donation.years_asked
          : ['Candidate Contributed'],
        question_nepali: donation.question_nepali,
        question_english: donation.question_english,
        answer_nepali: donation.answer_nepali || null,
        answer_english: donation.answer_english || null,
        options: donation.options || null,
        correct_option_index: donation.correct_option_index ?? null,
        explanation: donation.explanation || null,
        is_premium: false,
      });
    }

    if (isMongoConnected && mongoose.Types.ObjectId.isValid(donationId)) {
      donation = await QuestionDonation.findByIdAndUpdate(
        donationId,
        { $set: { status: newStatus, publishedQuestionId } },
        { new: true }
      ).lean();
      if (donation) donation = { ...donation, _id: donation._id.toString() };
    }

    localStore.donations = localStore.donations || [];
    const idx = localStore.donations.findIndex((d) => String(d._id) === String(donationId));
    if (idx >= 0) {
      localStore.donations[idx].status = newStatus;
      localStore.donations[idx].publishedQuestionId = publishedQuestionId;
      saveLocalStore();
      if (!donation) donation = localStore.donations[idx];
    }

    return { donation, publishedQuestion };
  },

  async claimDonationReward(userId, { paymentMethod, walletId }) {
    const cleanWallet = (walletId || '').trim();
    const cleanMethod = (paymentMethod || 'eSewa').trim();
    const nowIso = new Date().toISOString();

    if (isMongoConnected) {
      const unclaimed = await QuestionDonation.find({
        userId: String(userId),
        status: 'approved',
        claimed: { $ne: true },
      }).lean();

      if (unclaimed.length < 200) {
        return {
          ok: false,
          unclaimedCount: unclaimed.length,
          error: `You currently have ${unclaimed.length} unclaimed verified questions. You need at least 200 verified questions to claim your reward.`,
        };
      }

      const ids = unclaimed.map((d) => d._id);
      await QuestionDonation.updateMany(
        { _id: { $in: ids } },
        {
          $set: {
            claimed: true,
            claimStatus: 'claim_requested',
            paymentMethod: cleanMethod,
            walletId: cleanWallet,
            claimedAt: nowIso,
          },
        }
      );

      localStore.donations = localStore.donations || [];
      for (const item of localStore.donations) {
        if (String(item.userId) === String(userId) && item.status === 'approved' && !item.claimed) {
          item.claimed = true;
          item.claimStatus = 'claim_requested';
          item.paymentMethod = cleanMethod;
          item.walletId = cleanWallet;
          item.claimedAt = nowIso;
        }
      }
      saveLocalStore();

      return {
        ok: true,
        claimedQuestions: unclaimed.length,
        claimedRupees: Number((unclaimed.length * 0.05).toFixed(2)),
        paymentMethod: cleanMethod,
        walletId: cleanWallet,
      };
    }

    localStore.donations = localStore.donations || [];
    const unclaimedLocal = localStore.donations.filter(
      (d) => String(d.userId) === String(userId) && d.status === 'approved' && !d.claimed
    );
    if (unclaimedLocal.length < 200) {
      return {
        ok: false,
        unclaimedCount: unclaimedLocal.length,
        error: `You currently have ${unclaimedLocal.length} unclaimed verified questions. You need at least 200 verified questions to claim your reward.`,
      };
    }
    for (const item of unclaimedLocal) {
      item.claimed = true;
      item.claimStatus = 'claim_requested';
      item.paymentMethod = cleanMethod;
      item.walletId = cleanWallet;
      item.claimedAt = nowIso;
    }
    saveLocalStore();
    return {
      ok: true,
      claimedQuestions: unclaimedLocal.length,
      claimedRupees: Number((unclaimedLocal.length * 0.05).toFixed(2)),
      paymentMethod: cleanMethod,
      walletId: cleanWallet,
    };
  },
};

module.exports = { connectDB, DB };
