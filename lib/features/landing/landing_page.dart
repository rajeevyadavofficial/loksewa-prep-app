import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionProvider>().loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isNarrow = w < 900;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _NavBar(isNarrow: isNarrow),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _HeroSection(isNarrow: isNarrow),
                  _StatsRow(),
                  _ExamCatalogSection(
                    isNarrow: isNarrow,
                    selectedCategory: _selectedCategory,
                    onCategoryChanged: (c) => setState(() => _selectedCategory = c),
                  ),
                  _FeaturesSection(isNarrow: isNarrow),
                  _PricingSection(isNarrow: isNarrow),
                  _TestimonialsSection(isNarrow: isNarrow),
                  _CTASection(),
                  _Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Pure White Chakra/MUI Top Navigation Bar ─────────────────
class _NavBar extends StatelessWidget {
  final bool isNarrow;
  const _NavBar({required this.isNarrow});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isNarrow ? 20 : 64,
        vertical: 14,
      ),
      child: Row(
        children: [
          _Logo(),
          const Spacer(),
          if (auth.isLoggedIn) ...[
            FilledButton.icon(
              onPressed: () => context.go(AppConstants.routeDashboard),
              icon: const Icon(Icons.dashboard_outlined, size: 17, color: Colors.white),
              label: const Text('Dashboard'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ] else ...[
            OutlinedButton.icon(
              onPressed: () => context.go(AppConstants.routeLogin),
              icon: const Icon(Icons.login_rounded, size: 16, color: AppTheme.primaryColor),
              label: const Text('Sign In'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primaryColor,
                side: const BorderSide(color: AppTheme.divider, width: 1.2),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(width: 10),
            FilledButton.icon(
              onPressed: () => context.go(AppConstants.routeRegister),
              icon: const Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.white),
              label: const Text('Start Free'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.iconRed,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.iconRedLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.iconRed.withOpacity(0.25)),
          ),
          child: const Icon(Icons.menu_book_rounded, color: AppTheme.iconRed, size: 20),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LoksewaHero',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 16.5,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              'Civil Service • Banking • IT • Sansthan',
              style: TextStyle(color: AppTheme.textMuted, fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Pure White Hero Section (Chakra UI / MUI Minimalist) ─────
class _HeroSection extends StatelessWidget {
  final bool isNarrow;
  const _HeroSection({required this.isNarrow});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isNarrow ? 24 : 80,
        vertical: isNarrow ? 48 : 72,
      ),
      child: isNarrow
          ? Column(children: [_HeroText(), const SizedBox(height: 36), _HeroCategoryShowcase()])
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: _HeroText()),
                const SizedBox(width: 48),
                Expanded(flex: 5, child: _HeroCategoryShowcase()),
              ],
            ),
    );
  }
}

class _HeroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.iconRedLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.iconRed.withOpacity(0.3)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_rounded, color: AppTheme.iconRed, size: 15),
              SizedBox(width: 6),
              Text(
                'All-in-One Lok Sewa Aayog & Public Enterprise Platform',
                style: TextStyle(color: AppTheme.iconRedDark, fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'Master Any Lok Sewa\nExam in Nepal',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.textPrimary,
            height: 1.15,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Section Officer (शाखा अधिकृत) • Nayab Subba (नायब सुब्बा) • Kharidar (खरिदार)\n'
          'RBB / NRB / ADBL Banking • Computer Operator & IT Officer • NEA / NTC / EPF Sansthan\n'
          '20-Year Past Questions • Bilingual Model Answers (नेपाली / English) • Timed OMR Mock Tests',
          style: TextStyle(color: AppTheme.textMuted, fontSize: 15, height: 1.7),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () => context.go(AppConstants.routeRegister),
              icon: const Icon(Icons.rocket_launch_outlined, size: 18, color: Colors.white),
              label: const Text('Start Preparing Free'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.iconRed,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                textStyle: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => context.go(AppConstants.routeLogin),
              icon: const Icon(Icons.person_outline_rounded, size: 18, color: AppTheme.primaryColor),
              label: const Text('Candidate Login'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primaryColor,
                side: const BorderSide(color: AppTheme.primaryColor, width: 1.2),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        Wrap(
          spacing: 22,
          runSpacing: 8,
          children: [
            _checkBadge('8+ Official Exam Streams', isRed: true),
            _checkBadge('Bilingual Model Answers', isRed: false),
            _checkBadge('MongoDB Atlas Live Cloud', isRed: true),
          ],
        ),
      ],
    );
  }

  Widget _checkBadge(String text, {required bool isRed}) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.check_circle_outline_rounded,
        color: isRed ? AppTheme.iconRed : AppTheme.primaryColor,
        size: 16,
      ),
      const SizedBox(width: 6),
      Text(text, style: const TextStyle(color: AppTheme.textBody, fontSize: 13, fontWeight: FontWeight.w500)),
    ],
  );
}

class _HeroCategoryShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = [
      (Icons.account_balance_outlined, 'Banking (बैंकिङ सेवा)', 'RBB Level 4/5, NRB Assistant/Officer, ADBL, NBL', true),
      (Icons.gavel_rounded, 'Civil Service (निजामती सेवा)', 'Section Officer, Nayab Subba (NaSu), Kharidar', false),
      (Icons.computer_rounded, 'IT & Technical (प्राविधिक सेवा)', 'Computer Operator, IT Officer, RBB/NRB IT', true),
      (Icons.domain_rounded, 'Public Enterprises (संस्थान सेवा)', 'NEA, Nepal Telecom (NTC), EPF (सञ्चय कोष)', false),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider, width: 1),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.layers_outlined, color: AppTheme.iconRed, size: 20),
              SizedBox(width: 8),
              Text(
                'Supported Lok Sewa Exam Streams',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5, color: AppTheme.textPrimary),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, color: AppTheme.divider),
          ),
          ...categories.map((c) {
            final isRed = c.$4;
            final iconColor = isRed ? AppTheme.iconRed : AppTheme.primaryColor;
            final iconBg = isRed ? AppTheme.iconRedLight : const Color(0xFFF4F4F5);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.divider),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: iconBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(c.$1, color: iconColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.$2, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: AppTheme.textPrimary)),
                          const SizedBox(height: 2),
                          Text(c.$3, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, color: iconColor, size: 18),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Pure White Stats Row with Hairline Borders ───────────────
class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 32),
      child: Wrap(
        spacing: 48,
        runSpacing: 20,
        alignment: WrapAlignment.spaceEvenly,
        children: [
          _stat(Icons.library_books_outlined, '${qp.exams.isNotEmpty ? qp.exams.length : 8}+', 'Lok Sewa Exam Courses', true),
          _stat(Icons.quiz_outlined, '${qp.allQuestions.isNotEmpty ? qp.allQuestions.length : 155}+', 'Verified Past Q&As', false),
          _stat(Icons.history_edu_rounded, '20 Yrs', 'Archive Coverage (2060–2082)', true),
          _stat(Icons.translate_rounded, 'नेपाली + EN', 'Bilingual Study Medium', false),
        ],
      ),
    );
  }

  Widget _stat(IconData icon, String value, String label, bool isRed) => SizedBox(
    width: 210,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isRed ? AppTheme.iconRedLight : const Color(0xFFF4F4F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: isRed ? AppTheme.iconRed : AppTheme.primaryColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 20, fontWeight: FontWeight.w800)),
              Text(label, style: const TextStyle(color: AppTheme.textMuted, fontSize: 11.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── Pure White Exam Catalog Section ──────────────────────────
class _ExamCatalogSection extends StatelessWidget {
  final bool isNarrow;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  const _ExamCatalogSection({
    required this.isNarrow,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  static const categories = ['All', 'Civil Service', 'Banking', 'IT & Technical', 'Sansthan'];

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final allExams = qp.exams;
    final filteredExams = selectedCategory == 'All'
        ? allExams
        : allExams.where((e) => e.category == selectedCategory).toList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isNarrow ? 20 : 80, vertical: 64),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
      ),
      child: Column(
        children: [
          _sectionTitle(
            'Explore Lok Sewa Exam Courses',
            'Select your target post — from Section Officer, Nayab Subba & Kharidar to Banking & Technical services',
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: categories.map((cat) {
              final selected = selectedCategory == cat;
              return FilterChip(
                selected: selected,
                label: Text(
                  cat,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
                selectedColor: AppTheme.primaryColor,
                checkmarkColor: Colors.white,
                backgroundColor: Colors.white,
                side: BorderSide(color: selected ? AppTheme.primaryColor : AppTheme.divider),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                onSelected: (_) => onCategoryChanged(cat),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          if (qp.loading)
            const Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(color: AppTheme.iconRed),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isNarrow ? 1 : (MediaQuery.of(context).size.width > 1250 ? 3 : 2),
                childAspectRatio: isNarrow ? 1.55 : 1.38,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: filteredExams.length,
              itemBuilder: (ctx, i) {
                final exam = filteredExams[i];
                final qCount = qp.countForExam(exam.id);
                return _ExamCourseCard(
                  exam: exam,
                  index: i,
                  questionCount: qCount > 0 ? qCount : exam.questionCount,
                  onTap: exam.isComingSoon
                      ? null
                      : () {
                          qp.selectExam(exam.id);
                          final isLogged = context.read<AuthProvider>().isLoggedIn;
                          context.go(isLogged ? AppConstants.routeDashboard : AppConstants.routeLogin);
                        },
                );
              },
            ),
        ],
      ),
    );
  }
}

class _ExamCourseCard extends StatelessWidget {
  final ExamCourse exam;
  final int index;
  final int questionCount;
  final VoidCallback? onTap;

  const _ExamCourseCard({
    required this.exam,
    required this.index,
    required this.questionCount,
    required this.onTap,
  });

  IconData _catIcon(String cat) {
    switch (cat) {
      case 'Banking': return Icons.account_balance_outlined;
      case 'Civil Service': return Icons.gavel_rounded;
      case 'IT & Technical': return Icons.computer_rounded;
      case 'Sansthan': return Icons.domain_rounded;
      default: return Icons.menu_book_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isComingSoon = exam.isComingSoon;
    final isRed = !isComingSoon && index.isEven;
    final iconColor = isComingSoon
        ? AppTheme.textMuted
        : (isRed ? AppTheme.iconRed : AppTheme.primaryColor);
    final badgeBg = isComingSoon
        ? const Color(0xFFF4F4F5)
        : (isRed ? AppTheme.iconRedLight : const Color(0xFFF4F4F5));

    return Opacity(
      opacity: isComingSoon ? 0.68 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isComingSoon ? AppTheme.divider : AppTheme.iconRed.withOpacity(0.45),
            width: isComingSoon ? 1 : 1.4,
          ),
        ),
        child: InkWell(
          onTap: isComingSoon ? null : onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: badgeBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(_catIcon(exam.category), size: 14, color: iconColor),
                          const SizedBox(width: 6),
                          Text(
                            exam.category,
                            style: TextStyle(color: iconColor, fontWeight: FontWeight.w700, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (isComingSoon)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F4F5),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppTheme.divider),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock_clock_outlined, size: 12, color: AppTheme.textMuted),
                            SizedBox(width: 4),
                            Text(
                              'COMING SOON',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppTheme.textMuted),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.iconRedLight,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppTheme.iconRed.withOpacity(0.3)),
                        ),
                        child: Text(
                          'LIVE • $questionCount Q&As',
                          style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: AppTheme.iconRedDark),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  exam.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15.5,
                    color: isComingSoon ? AppTheme.textMuted : AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  exam.titleNepali,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: isComingSoon ? AppTheme.textMuted : AppTheme.textBody,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${exam.organization} • ${exam.level}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    exam.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: AppTheme.textMuted, height: 1.45),
                  ),
                ),
                const Divider(height: 16, color: AppTheme.divider),
                Row(
                  children: [
                    Icon(
                      isComingSoon ? Icons.schedule_rounded : Icons.menu_book_outlined,
                      size: 15,
                      color: isComingSoon ? AppTheme.textMuted : AppTheme.iconRed,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isComingSoon ? 'Course Launching Soon' : 'Syllabus + Q&A + Mock Test',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: isComingSoon ? AppTheme.textMuted : AppTheme.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      isComingSoon ? Icons.lock_outline_rounded : Icons.arrow_forward_rounded,
                      size: 16,
                      color: isComingSoon ? AppTheme.textMuted : AppTheme.iconRed,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Pure White Features Section ──────────────────────────────
class _FeaturesSection extends StatelessWidget {
  final bool isNarrow;
  const _FeaturesSection({required this.isNarrow});

  static const features = [
    (Icons.library_books_outlined, 'Multi-Exam Question Bank', 'Switch between Civil Service (Section Officer, NaSu, Kharidar), Banking (RBB, NRB, ADBL), IT & Sansthan exams anytime.', true),
    (Icons.timer_outlined, 'Timed OMR Mock Tests', 'Practice 45-minute objective MCQ tests modeled after PSC & Banking preliminary exams with instant score analytics.', false),
    (Icons.description_outlined, 'Official PSC & Banking Syllabi', 'Complete unit-by-unit official curriculum, marks distribution, and exam rules for every post.', true),
    (Icons.edit_note_rounded, 'Lok Sewa Answer Writing Skill', 'Subjective answers structured using the high-scoring 3-tier Lok Sewa format (Introduction → Body/Tables → Conclusion).', false),
    (Icons.translate_rounded, 'Bilingual (नेपाली & English)', 'Read every question and model answer in Nepali, English, or side-by-side according to your exam medium.', true),
    (Icons.cloud_done_outlined, 'Admin Cloud CMS (MongoDB Atlas)', 'Admins can dynamically add new Lok Sewa exams, posts, syllabi, and questions in real time.', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isNarrow ? 24 : 80, vertical: 64),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
      ),
      child: Column(
        children: [
          _sectionTitle('Built for Every Lok Sewa Aspirant', 'Clean, distraction-free study interface with verified past questions'),
          const SizedBox(height: 44),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isNarrow ? 1 : 3,
              childAspectRatio: isNarrow ? 2.6 : 1.45,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: features.length,
            itemBuilder: (ctx, i) {
              final f = features[i];
              final isRed = f.$4;
              return Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isRed ? AppTheme.iconRedLight : const Color(0xFFF4F4F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(f.$1, color: isRed ? AppTheme.iconRed : AppTheme.primaryColor, size: 20),
                    ),
                    const SizedBox(height: 14),
                    Text(f.$2, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppTheme.textPrimary)),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Text(f.$3, style: const TextStyle(color: AppTheme.textMuted, fontSize: 12.5, height: 1.5)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── Pure White Pricing Section ───────────────────────────────
class _PricingSection extends StatelessWidget {
  final bool isNarrow;
  const _PricingSection({required this.isNarrow});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isNarrow ? 24 : 80, vertical: 64),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
      ),
      child: Column(
        children: [
          _sectionTitle('One Subscription, All Lok Sewa Exams', 'Start free and upgrade via eSewa, Khalti, or FonePay when ready'),
          const SizedBox(height: 44),
          isNarrow
              ? Column(children: _planCards(context))
              : ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 860),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _planCards(context).map((c) => c is SizedBox ? c : Expanded(child: c)).toList(),
                  ),
                ),
        ],
      ),
    );
  }

  List<Widget> _planCards(BuildContext context) => [
    _PlanCard(
      plan: SubscriptionPlan.free,
      name: 'Free Starter',
      price: 'नि:शुल्क',
      subtitle: 'Forever free',
      features: const [
        'Enroll in Your Target Lok Sewa Exam',
        'Complete Official Syllabus',
        'Free Preview Model Answers',
        'Practice MCQ Mock Test',
      ],
      cta: 'Get Started Free',
      isPopular: false,
      onTap: () => GoRouter.of(context).go(AppConstants.routeRegister),
    ),
    const SizedBox(width: 24, height: 20),
    _PlanCard(
      plan: SubscriptionPlan.premium,
      name: 'Pro Plan',
      price: 'रू १९९',
      subtitle: 'full exam pass',
      features: const [
        'Full Access to Your Enrolled Exam',
        'Paper I + Paper II + Paper III Unlocked',
        'All Questions Unlocked',
        'Unlimited Timed Mock Tests & Analytics',
      ],
      cta: 'Upgrade to Pro (रू 199)',
      isPopular: true,
      onTap: () => GoRouter.of(context).go(AppConstants.routeSubscription),
    ),
  ];
}

class _PlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final String name, price, subtitle, cta;
  final List<String> features;
  final bool isPopular;
  final VoidCallback onTap;

  const _PlanCard({
    required this.plan, required this.name, required this.price,
    required this.subtitle, required this.features, required this.cta,
    required this.isPopular, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPopular ? AppTheme.iconRed : AppTheme.divider,
          width: isPopular ? 1.8 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(
                  color: isPopular ? AppTheme.iconRed : AppTheme.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              if (isPopular)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.iconRedLight,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Most Popular',
                    style: TextStyle(color: AppTheme.iconRed, fontWeight: FontWeight.w800, fontSize: 10.5),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            price,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
          ),
          Text(subtitle, style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
          const SizedBox(height: 22),
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: 16,
                  color: isPopular ? AppTheme.iconRed : AppTheme.primaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(f, style: const TextStyle(fontSize: 13, color: AppTheme.textBody)),
                ),
              ],
            ),
          )),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: isPopular
                ? FilledButton(
                    onPressed: onTap,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.iconRed,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(cta, style: const TextStyle(fontWeight: FontWeight.w700)),
                  )
                : OutlinedButton(
                    onPressed: onTap,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primaryColor,
                      side: const BorderSide(color: AppTheme.primaryColor, width: 1.2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(cta, style: const TextStyle(fontWeight: FontWeight.w700)),
                  ),
          ),
        ],
      ),
    );
  }
}

// ─── Testimonials Section ─────────────────────────────────────
class _TestimonialsSection extends StatelessWidget {
  final bool isNarrow;
  const _TestimonialsSection({required this.isNarrow});

  static const testimonials = [
    ('Ramesh Shrestha', 'RBB IT Level 5 & NRB Aspirant', 'Having RBB, NRB, and Computer Operator questions in the same platform with Nepali & English tabs saved me months of searching.'),
    ('Sita Adhikari', 'Section Officer & Nayab Subba Candidate', 'The 3-tier Lok Sewa subjective answer format for Cooperative Federalism and Governance helped me structure my written papers cleanly.'),
    ('Bikash Karki', 'Kharidar & ADBL Aspirant', 'The timed MCQ mock tests and instant explanations make daily practice super effective.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isNarrow ? 24 : 80, vertical: 64),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
      ),
      child: Column(
        children: [
          _sectionTitle('Trusted by Lok Sewa Aspirants Across Nepal', 'Preparing for Civil Service, Banking, Technical & Sansthan exams'),
          const SizedBox(height: 40),
          isNarrow
              ? Column(
                  children: testimonials.map((t) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _TestimonialCard(name: t.$1, role: t.$2, text: t.$3),
                  )).toList(),
                )
              : Row(
                  children: testimonials.map((t) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: _TestimonialCard(name: t.$1, role: t.$2, text: t.$3),
                    ),
                  )).toList(),
                ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String name, role, text;
  const _TestimonialCard({required this.name, required this.role, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: List.generate(5, (_) => const Icon(Icons.star_rounded, color: AppTheme.iconRed, size: 16))),
          const SizedBox(height: 14),
          Text('"$text"', style: const TextStyle(fontSize: 13, height: 1.6, color: AppTheme.textBody)),
          const SizedBox(height: 16),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
          Text(role, style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
        ],
      ),
    );
  }
}

// ─── Pure White CTA Section ───────────────────────────────────
class _CTASection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      padding: const EdgeInsets.all(44),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.divider, width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.iconRedLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.flag_outlined, color: AppTheme.iconRed, size: 24),
          ),
          const SizedBox(height: 16),
          const Text(
            'Start Your Lok Sewa Journey Today',
            style: TextStyle(color: AppTheme.textPrimary, fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'Choose your target exam — Civil Service, Banking, IT, or Sansthan — and practice with real past questions.',
            style: TextStyle(color: AppTheme.textMuted, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 26),
          FilledButton.icon(
            onPressed: () => GoRouter.of(context).go(AppConstants.routeRegister),
            icon: const Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
            label: const Text('Create Free Account'),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Pure White Footer ────────────────────────────────────────
class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppTheme.divider, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 28),
      child: Row(
        children: [
          _Logo(),
          const Spacer(),
          const Text(
            '© 2082 BS LoksewaHero • Pure Minimalist UI & MongoDB Atlas Cloud',
            style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

Widget _sectionTitle(String title, String subtitle) {
  return Column(
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: AppTheme.textPrimary,
          letterSpacing: -0.5,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),
      Text(
        subtitle,
        style: const TextStyle(color: AppTheme.textMuted, fontSize: 14.5),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
