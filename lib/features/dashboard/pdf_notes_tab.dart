import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfNotesTab extends StatelessWidget {
  final VoidCallback? onGoToExams;

  const PdfNotesTab({super.key, this.onGoToExams});

  static const String driveFolderUrl =
      'https://drive.google.com/drive/folders/1zbd4yY2ujCmefNsRmlZJraOitd3T1_O1?usp=sharing';

  Future<void> _openDriveFolder(BuildContext context) async {
    final uri = Uri.parse(driveFolderUrl);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        await launchUrl(uri);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open link: $e'),
            backgroundColor: Colors.black87,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _copyDriveLink(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: driveFolderUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Google Drive PDF folder link copied to clipboard!'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.black87,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 840;

    return Container(
      color: const Color(0xFFF9FAFB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── TOP APP HEADER ──────────────────────────────────────────────
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 28,
              vertical: isMobile ? 12 : 16,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1.0)),
            ),
            child: Row(
              children: [
                if (onGoToExams != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
                      tooltip: 'Back to Overview',
                      onPressed: onGoToExams,
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFD1D5DB)),
                  ),
                  child: const Icon(Icons.picture_as_pdf_rounded, size: 22, color: Colors.black),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PDF Notes & Resources',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isMobile ? 15 : 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Official Syllabus PDF Handouts, Acts, Reference Books & Past Solutions',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isMobile ? 11 : 12.5,
                          color: const Color(0xFF4B5563),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _openDriveFolder(context),
                  icon: const Icon(Icons.open_in_new_rounded, size: 16, color: Colors.white),
                  label: Text(isMobile ? 'Open Drive' : 'Open in Google Drive'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 12 : 18,
                      vertical: isMobile ? 10 : 12,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),

          // ─── MAIN CONTENT SCROLL VIEW ────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 14 : 32,
                vertical: isMobile ? 16 : 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1040),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ─── HERO CALLOUT CARD ────────────────────────────────
                      _buildHeroDriveCard(context, isMobile),

                      const SizedBox(height: 28),

                      // ─── SECTION TITLE: WHAT'S INSIDE ─────────────────────
                      const Row(
                        children: [
                          Icon(Icons.folder_open_rounded, size: 20, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            'Drive Folder Contents & Syllabus Organization',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'The cloud drive contains categorized folders aligned directly with Rastriya Banijya Bank Senior Assistant (IT) Level 5 examination papers:',
                        style: TextStyle(fontSize: 13, color: Color(0xFF4B5563), height: 1.4),
                      ),

                      const SizedBox(height: 16),

                      // ─── DIRECTORY CARDS GRID ─────────────────────────────
                      _buildFolderGrid(context, isMobile),

                      const SizedBox(height: 28),

                      // ─── HOW TO USE & TIPS BOX ────────────────────────────
                      _buildTipsBox(isMobile),

                      const SizedBox(height: 36),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // HERO GOOGLE DRIVE CARD
  // ───────────────────────────────────────────────────────────────────────────
  Widget _buildHeroDriveCard(BuildContext context, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 18 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: isMobile ? 48 : 56,
                height: isMobile ? 48 : 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFD1D5DB)),
                ),
                child: const Icon(
                  Icons.cloud_download_rounded,
                  size: 28,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'OFFICIAL CLOUD REPOSITORY',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'RBB IT Level 5 Complete PDF Study Library',
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'All syllabus-focused PDF notes, full banking acts (नेपाल राष्ट्र बैंक ऐन, BAFIA, बैंकिङ्ग कसूर), IT architecture handouts, past question compilations, and handwritten subjective solution notes are synced and accessible in this shared Google Drive.',
                      style: TextStyle(
                        fontSize: isMobile ? 12.5 : 14,
                        color: const Color(0xFF4B5563),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          const Divider(color: Color(0xFFE5E7EB), height: 1),
          const SizedBox(height: 18),

          // URL Display & Action Buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                const Icon(Icons.link_rounded, size: 18, color: Color(0xFF6B7280)),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    driveFolderUrl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy_rounded, size: 17, color: Colors.black),
                  tooltip: 'Copy Link',
                  onPressed: () => _copyDriveLink(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () => _openDriveFolder(context),
                icon: const Icon(Icons.folder_special_rounded, size: 18, color: Colors.white),
                label: const Text('Open Google Drive Folder'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  textStyle: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _copyDriveLink(context),
                icon: const Icon(Icons.copy_all_rounded, size: 18, color: Colors.black),
                label: const Text('Copy Drive Link'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black, width: 1.2),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  textStyle: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // FOLDER DIRECTORY GRID
  // ───────────────────────────────────────────────────────────────────────────
  Widget _buildFolderGrid(BuildContext context, bool isMobile) {
    final folders = [
      (
        'Paper 1: Banking & Financial System',
        'बैंकिङ्ग प्रणाली तथा ऐन नियम',
        Icons.account_balance_rounded,
        [
          'Commercial Banking Operations & Functions',
          'NRB Unified Directives (एकीकृत निर्देशन)',
          'BAFIA 2073, NRB Act 2058 & Banking Offence Act',
          'Anti-Money Laundering (AML/CFT) Act 2064',
          'Capital Adequacy (CAR), CRR, SLR, CD Ratio',
        ],
      ),
      (
        'Paper 1: Accounting, Mgmt & Service',
        'लेखा, व्यवस्थापन र ग्राहक सेवा',
        Icons.manage_accounts_rounded,
        [
          'Principles of Accounting, Trial Balance & Ledger',
          'Financial Statement Analysis, NFRS Guidelines',
          'General Management, Motivation, Leadership',
          'Human Resource Management (HRM) in Banks',
          'Office Operations, RTI Act & Public Service Rules',
        ],
      ),
      (
        'Paper 2: Computer Systems & Architecture',
        'कम्प्युटर आर्किटेक्चर र हार्डवेयर',
        Icons.memory_rounded,
        [
          'CPU Architecture, ALU, Control Unit, Microprocessors',
          'Memory Hierarchy (Cache, RAM, ROM, Virtual Memory)',
          'Instruction Pipelining & Addressing Modes',
          'I/O Interfacing, Interrupts & Bus Architectures',
          'Data Representation & Logic Gate Design',
        ],
      ),
      (
        'Paper 2: Operating Systems & Linux',
        'अपरेटिङ सिस्टम तथा लिनक्स',
        Icons.terminal_rounded,
        [
          'Process Management, CPU Scheduling & Threads',
          'Concurrency, Deadlock Avoidance (Banker\'s Algorithm)',
          'Memory Management & Paging / Segmentation',
          'Linux Kernel, File Permissions, Bash Shell Scripting',
          'System Administration & Virtualization (VM / Containers)',
        ],
      ),
      (
        'Paper 2: DBMS & Software Engineering',
        'डेटाबेस प्रणाली र सफ्टवेयर',
        Icons.storage_rounded,
        [
          'Relational Database Concepts & ER Modeling',
          'SQL Queries (DDL, DML, DCL, Joins, Subqueries)',
          'Database Normalization (1NF to BCNF)',
          'Transaction Management, Concurrency & ACID',
          'SDLC Models, Agile, Object-Oriented Programming (OOP)',
        ],
      ),
      (
        'Paper 2: Networking & Cyber Resilience',
        'कम्प्युटर नेटवर्क तथा साइबर सुरक्षा',
        Icons.security_rounded,
        [
          'OSI & TCP/IP Model Layers & Protocols',
          'IPv4 / IPv6 Subnetting & CIDR Calculation',
          'Cryptography: AES, RSA, Digital Signatures, PKI',
          'NRB IT Guidelines & Cyber Resilience 2023',
          'Firewalls, IDS/IPS, VPN, Zero-Trust Architecture',
        ],
      ),
      (
        'Past Examination Papers & Model Answers',
        'विगतका प्रश्नपत्र तथा नमुना उत्तर',
        Icons.history_edu_rounded,
        [
          'RBB Senior Assistant IT Level 5 Past Papers (2076-2081)',
          'Loksewa Official Exam Answer Writing Templates',
          'Marks Weightage Strategy & Time Management Sheets',
          'Subjective 5-mark & 10-mark Structured Handouts',
        ],
      ),
      (
        'Reference Books & Act Compilations',
        'सन्दर्भ पुस्तक तथा ऐनहरूको संग्रह',
        Icons.auto_stories_rounded,
        [
          'Complete Acts & By-Laws (PDF Format in Nepali)',
          'Computer Science Standard Reference Textbooks',
          'Banking Terminology & Abbreviations Glossary',
          'Quick Revision Flash Summaries & Cheat Sheets',
        ],
      ),
    ];

    final crossAxisCount = isMobile ? 1 : 2;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        mainAxisExtent: 220,
      ),
      itemCount: folders.length,
      itemBuilder: (context, index) {
        final f = folders[index];
        final title = f.$1;
        final titleNepali = f.$2;
        final icon = f.$3;
        final bullets = f.$4;

        return InkWell(
          onTap: () => _openDriveFolder(context),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(icon, size: 18, color: Colors.black),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            titleNepali,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_outward_rounded, size: 16, color: Color(0xFF9CA3AF)),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(color: Color(0xFFF3F4F6), height: 1),
                const SizedBox(height: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: bullets.take(3).map((b) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '•  ',
                            style: TextStyle(fontSize: 11, color: Colors.black, height: 1.4),
                          ),
                          Expanded(
                            child: Text(
                              b,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,
                                color: Color(0xFF374151),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // HELPFUL TIPS & INSTRUCTIONS
  // ───────────────────────────────────────────────────────────────────────────
  Widget _buildTipsBox(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 22),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.tips_and_updates_rounded, size: 19, color: Colors.black),
              SizedBox(width: 8),
              Text(
                'How to Best Utilize the Google Drive PDF Repository',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildTipRow(
            '1. Offline Reading & Printing',
            'Download key acts and syllabus notes directly to your laptop or phone for offline study without data connection.',
          ),
          const SizedBox(height: 8),
          _buildTipRow(
            '2. Full-Text Search in PDFs',
            'Open PDFs in Google Drive viewer or Adobe Acrobat and press Ctrl+F (Cmd+F) to search for specific legal sections or technical terms.',
          ),
          const SizedBox(height: 8),
          _buildTipRow(
            '3. Star & Shortcut to Your Drive',
            'Click the "Add shortcut to Drive" or "Star" icon in Google Drive so this repository is always one click away from your personal Google account.',
          ),
        ],
      ),
    );
  }

  Widget _buildTipRow(String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle_outline_rounded, size: 16, color: Colors.black87),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 12.5, color: Color(0xFF374151), height: 1.45),
              children: [
                TextSpan(
                  text: '$title: ',
                  style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
                ),
                TextSpan(text: desc),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
