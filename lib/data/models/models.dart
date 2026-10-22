// Models: ExamCourse, SyllabusSection, Question, AppUser, SubscriptionPlan, MockTestResult

enum QuestionType { subjective, mcq }
enum PaperType { paper1, paper2 }
enum SectionType { sectionA, sectionB }
enum LanguageMedium { nepali, english, both }

class SyllabusSectionModel {
  final String title;
  final List<String> topics;

  const SyllabusSectionModel({
    required this.title,
    required this.topics,
  });

  factory SyllabusSectionModel.fromJson(Map<String, dynamic> json) {
    return SyllabusSectionModel(
      title: json['title'] ?? '',
      topics: List<String>.from(json['topics'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'topics': topics,
  };
}

class ExamCourse {
  final String id;
  final String title;
  final String titleNepali;
  final String category; // 'Banking', 'Civil Service', 'IT & Technical', 'Sansthan'
  final String organization;
  final String level;
  final String description;
  final List<String> examScheme;
  final List<SyllabusSectionModel> syllabusSections;
  final int questionCount;
  final bool isComingSoon;

  const ExamCourse({
    required this.id,
    required this.title,
    required this.titleNepali,
    required this.category,
    required this.organization,
    required this.level,
    required this.description,
    this.examScheme = const [],
    this.syllabusSections = const [],
    this.questionCount = 0,
    this.isComingSoon = false,
  });

  factory ExamCourse.fromJson(Map<String, dynamic> json) {
    final rawSections = json['syllabus_sections'] as List<dynamic>? ?? [];
    final idStr = (json['id'] ?? '').toString();
    return ExamCourse(
      id: idStr,
      title: json['title'] ?? '',
      titleNepali: json['title_nepali'] ?? '',
      category: json['category'] ?? 'Civil Service',
      organization: json['organization'] ?? 'Lok Sewa Aayog',
      level: json['level'] ?? '',
      description: json['description'] ?? '',
      examScheme: List<String>.from(json['exam_scheme'] ?? []),
      syllabusSections: rawSections
          .map((s) => SyllabusSectionModel.fromJson(s as Map<String, dynamic>))
          .toList(),
      questionCount: json['question_count'] ?? 0,
      isComingSoon: json.containsKey('is_coming_soon')
          ? (json['is_coming_soon'] == true)
          : (idStr != 'rbb_it_5'),
    );
  }
}

class Question {
  final String id;
  final String examId;
  final PaperType paper;
  final SectionType section;
  final int unitNumber;
  final String unitTitle;
  final int marks;
  final QuestionType type;
  final List<String> yearsAsked;
  final String questionNepali;
  final String questionEnglish;
  final String? answerNepali;
  final String? answerEnglish;
  final List<String>? options;
  final int? correctOptionIndex;
  final String? explanation;
  final bool isPremium;

  const Question({
    required this.id,
    this.examId = 'rbb_it_5',
    required this.paper,
    required this.section,
    required this.unitNumber,
    required this.unitTitle,
    required this.marks,
    required this.type,
    required this.yearsAsked,
    required this.questionNepali,
    required this.questionEnglish,
    this.answerNepali,
    this.answerEnglish,
    this.options,
    this.correctOptionIndex,
    this.explanation,
    this.isPremium = false,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] ?? '',
      examId: json['exam_id'] ?? 'rbb_it_5',
      paper: json['paper'] == 'paper2' ? PaperType.paper2 : PaperType.paper1,
      section: json['section'] == 'sectionB' ? SectionType.sectionB : SectionType.sectionA,
      unitNumber: json['unit_number'] ?? 1,
      unitTitle: json['unit_title'] ?? '',
      marks: json['marks'] ?? 5,
      type: json['type'] == 'mcq' ? QuestionType.mcq : QuestionType.subjective,
      yearsAsked: List<String>.from(json['years_asked'] ?? []),
      questionNepali: json['question_nepali'] ?? '',
      questionEnglish: json['question_english'] ?? '',
      answerNepali: json['answer_nepali'],
      answerEnglish: json['answer_english'],
      options: json['options'] != null ? List<String>.from(json['options']) : null,
      correctOptionIndex: json['correct_option_index'],
      explanation: json['explanation'],
      isPremium: json['is_premium'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'exam_id': examId,
    'paper': paper == PaperType.paper2 ? 'paper2' : 'paper1',
    'section': section == SectionType.sectionB ? 'sectionB' : 'sectionA',
    'unit_number': unitNumber,
    'unit_title': unitTitle,
    'marks': marks,
    'type': type == QuestionType.mcq ? 'mcq' : 'subjective',
    'years_asked': yearsAsked,
    'question_nepali': questionNepali,
    'question_english': questionEnglish,
    'answer_nepali': answerNepali,
    'answer_english': answerEnglish,
    'options': options,
    'correct_option_index': correctOptionIndex,
    'explanation': explanation,
    'is_premium': isPremium,
  };
}

// ─── User Model ───────────────────────────────────────────────
enum SubscriptionPlan { free, basic, premium }

class AppUser {
  final String uid;
  final String name;
  final String email;
  final SubscriptionPlan plan;
  final DateTime? planExpiresAt;
  final bool isAdmin;
  final List<String> enrolledExams;
  final Set<String> answeredQuestions;
  final Set<String> bookmarkedQuestions;

  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.plan = SubscriptionPlan.free,
    this.planExpiresAt,
    this.isAdmin = false,
    this.enrolledExams = const [],
    this.answeredQuestions = const {},
    this.bookmarkedQuestions = const {},
  });

  bool get isPremium => plan == SubscriptionPlan.premium || plan == SubscriptionPlan.basic;
  bool get isBasicOrAbove => plan == SubscriptionPlan.basic || plan == SubscriptionPlan.premium;
  String get planDisplayName => plan == SubscriptionPlan.free ? 'Free' : 'Pro';
  bool isEnrolledIn(String examId) => enrolledExams.contains(examId);

  AppUser copyWith({
    String? name,
    String? email,
    SubscriptionPlan? plan,
    DateTime? planExpiresAt,
    bool? isAdmin,
    List<String>? enrolledExams,
    Set<String>? answeredQuestions,
    Set<String>? bookmarkedQuestions,
  }) {
    return AppUser(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      plan: plan ?? this.plan,
      planExpiresAt: planExpiresAt ?? this.planExpiresAt,
      isAdmin: isAdmin ?? this.isAdmin,
      enrolledExams: enrolledExams ?? this.enrolledExams,
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
      bookmarkedQuestions: bookmarkedQuestions ?? this.bookmarkedQuestions,
    );
  }
}

// ─── Mock Test Result ─────────────────────────────────────────
class MockTestResult {
  final int totalQuestions;
  final int answered;
  final int correct;
  final int incorrect;
  final int unanswered;
  final Duration timeTaken;
  final Map<String, int> userAnswers;

  const MockTestResult({
    required this.totalQuestions,
    required this.answered,
    required this.correct,
    required this.incorrect,
    required this.unanswered,
    required this.timeTaken,
    required this.userAnswers,
  });

  double get percentage => totalQuestions == 0 ? 0 : (correct / totalQuestions) * 100;
  bool get isPassing => percentage >= 40;
}

// ─── Payment, WhatsApp QR & Contact Settings Model ────────────
class AppSettings {
  final String whatsappNumber;
  final String whatsappLink;
  final String whatsappQrUrl;
  final String paymentQrUrl;
  final String esewaId;
  final String khaltiId;
  final String fonepayMerchant;
  final String bankName;
  final String bankAccountName;
  final String bankAccountNumber;
  final String bankBranch;
  final String supportEmail;
  final String supportPhone;
  final String officeAddress;
  final String verificationNote;

  const AppSettings({
    this.whatsappNumber = '+977-9705419699',
    this.whatsappLink = 'https://wa.me/9779705419699',
    this.whatsappQrUrl = 'https://res.cloudinary.com/rajeevyadav/image/upload/v1791720922/loksewa_prep/s2kdezawa20cg6ycco7d.jpg',
    this.paymentQrUrl = 'https://res.cloudinary.com/rajeevyadav/image/upload/v1791720911/loksewa_prep/wxs7zoxae5cwyczac6lx.jpg',
    this.esewaId = '9800000000',
    this.khaltiId = '9800000001',
    this.fonepayMerchant = 'LokSewa Prep Nepal (FonePay QR)',
    this.bankName = 'Rastriya Banijya Bank (RBB)',
    this.bankAccountName = 'LokSewa Prep Nepal Pvt. Ltd.',
    this.bankAccountNumber = '1010001007180003',
    this.bankBranch = 'Singhadurbar Plaza Branch, Kathmandu',
    this.supportEmail = 'support@loksewaprep.com.np',
    this.supportPhone = '+977-01-4200000 / 9800000000',
    this.officeAddress = 'Putalisadak, Kathmandu, Nepal',
    this.verificationNote =
        'After completing payment via eSewa, Khalti, FonePay QR, or Bank Transfer, please send your payment screenshot along with your registered Email Address to our official WhatsApp number or scan the WhatsApp QR code below. Your Pro plan will be activated immediately upon verification.',
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    final waQr = (json['whatsappQrUrl'] ?? json['whatsapp_qr_url'] ?? '').toString().trim();
    final payQr = (json['paymentQrUrl'] ?? json['payment_qr_url'] ?? '').toString().trim();
    return AppSettings(
      whatsappNumber: json['whatsappNumber'] ?? '+977-9705419699',
      whatsappLink: json['whatsappLink'] ?? 'https://wa.me/9779705419699',
      whatsappQrUrl: waQr.isNotEmpty
          ? waQr
          : 'https://res.cloudinary.com/rajeevyadav/image/upload/v1791720922/loksewa_prep/s2kdezawa20cg6ycco7d.jpg',
      paymentQrUrl: payQr.isNotEmpty
          ? payQr
          : 'https://res.cloudinary.com/rajeevyadav/image/upload/v1791720911/loksewa_prep/wxs7zoxae5cwyczac6lx.jpg',
      esewaId: json['esewaId'] ?? '9800000000',
      khaltiId: json['khaltiId'] ?? '9800000001',
      fonepayMerchant: json['fonepayMerchant'] ?? 'LokSewa Prep Nepal (FonePay QR)',
      bankName: json['bankName'] ?? 'Rastriya Banijya Bank (RBB)',
      bankAccountName: json['bankAccountName'] ?? 'LokSewa Prep Nepal Pvt. Ltd.',
      bankAccountNumber: json['bankAccountNumber'] ?? '1010001007180003',
      bankBranch: json['bankBranch'] ?? 'Singhadurbar Plaza Branch, Kathmandu',
      supportEmail: json['supportEmail'] ?? 'support@loksewaprep.com.np',
      supportPhone: json['supportPhone'] ?? '+977-01-4200000 / 9800000000',
      officeAddress: json['officeAddress'] ?? 'Putalisadak, Kathmandu, Nepal',
      verificationNote: json['verificationNote'] ??
          'After completing payment via eSewa, Khalti, FonePay QR, or Bank Transfer, please send your payment screenshot along with your registered Email Address to our official WhatsApp number or scan the WhatsApp QR code below. Your Pro plan will be activated immediately upon verification.',
    );
  }

  Map<String, dynamic> toJson() => {
    'whatsappNumber': whatsappNumber,
    'whatsappLink': whatsappLink,
    'whatsappQrUrl': whatsappQrUrl,
    'paymentQrUrl': paymentQrUrl,
    'esewaId': esewaId,
    'khaltiId': khaltiId,
    'fonepayMerchant': fonepayMerchant,
    'bankName': bankName,
    'bankAccountName': bankAccountName,
    'bankAccountNumber': bankAccountNumber,
    'bankBranch': bankBranch,
    'supportEmail': supportEmail,
    'supportPhone': supportPhone,
    'officeAddress': officeAddress,
    'verificationNote': verificationNote,
  };
}

class StudyNote {
  final String id;
  final String examId;
  final String paper; // 'paper1' or 'paper2'
  final String section; // 'sectionA' or 'sectionB'
  final String category;
  final int unitNumber;
  final String unitTitle;
  final String chapterTitle;
  final String topic;
  final String title;
  final String titleNepali;
  final String summary;
  final String content;
  final List<String> keyPoints;
  final int order;
  final int readTimeMinutes;

  const StudyNote({
    required this.id,
    required this.examId,
    required this.paper,
    required this.section,
    required this.category,
    required this.unitNumber,
    required this.unitTitle,
    required this.chapterTitle,
    required this.topic,
    required this.title,
    this.titleNepali = '',
    this.summary = '',
    required this.content,
    this.keyPoints = const [],
    this.order = 0,
    this.readTimeMinutes = 5,
  });

  factory StudyNote.fromJson(Map<String, dynamic> json) {
    return StudyNote(
      id: json['id'] ?? '',
      examId: json['examId'] ?? 'rbb_it_5',
      paper: json['paper'] ?? 'paper1',
      section: json['section'] ?? 'sectionA',
      category: json['category'] ?? '',
      unitNumber: json['unitNumber'] is int
          ? json['unitNumber']
          : (int.tryParse('${json['unitNumber']}') ?? 1),
      unitTitle: json['unitTitle'] ?? '',
      chapterTitle: json['chapterTitle'] ?? '',
      topic: json['topic'] ?? '',
      title: json['title'] ?? '',
      titleNepali: json['titleNepali'] ?? '',
      summary: json['summary'] ?? '',
      content: json['content'] ?? '',
      keyPoints: List<String>.from(json['keyPoints'] ?? const []),
      order: json['order'] is int
          ? json['order']
          : (int.tryParse('${json['order']}') ?? 0),
      readTimeMinutes: json['readTimeMinutes'] is int
          ? json['readTimeMinutes']
          : (int.tryParse('${json['readTimeMinutes']}') ?? 5),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'examId': examId,
    'paper': paper,
    'section': section,
    'category': category,
    'unitNumber': unitNumber,
    'unitTitle': unitTitle,
    'chapterTitle': chapterTitle,
    'topic': topic,
    'title': title,
    'titleNepali': titleNepali,
    'summary': summary,
    'content': content,
    'keyPoints': keyPoints,
    'order': order,
    'readTimeMinutes': readTimeMinutes,
  };
}

