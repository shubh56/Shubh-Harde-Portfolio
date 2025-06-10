import 'package:flutter/material.dart';
import 'package:shubh_harde_portfolio/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';
import 'package:web/web.dart' as web;
import 'package:flutter/services.dart';

class Resume extends StatefulWidget {
  const Resume({super.key});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  Uint8List? _pdfBytes;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    final pdfData =
        await rootBundle.load('assets/resume/Shubh_Harde_Resume.pdf');
    setState(() {
      _pdfBytes = pdfData.buffer.asUint8List();
    });
  }

  Future<void> downloadPdfWeb(Uint8List pdfBytes, String filename) async {
    final blob = web.Blob([pdfBytes.toJS].toJS);
    final url = web.URL.createObjectURL(blob);
    final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
    anchor.href = url;
    anchor.download = filename;
    anchor.click();
    web.URL.revokeObjectURL(url);
  }

  final List<CareerEvent> careerEvents = [
    CareerEvent(
      title: 'KTH Royal Institute of Technology',
      subtitle: 'Masters in Sports Technology',
      date: '2025- 2027',
      description:
          'Pursuing advanced studies in sports technology and analytics.',
      icon: Icons.school,
      skills: ['Sports Analytics'],
    ),
    CareerEvent(
      title: 'Aeonx Digital',
      subtitle: 'Flutter Development Intern',
      date: '2024',
      description:
          'Improved Flutter skills and learned effective state management',
      icon: Icons.computer,
      skills: ['Flutter', 'Flask', 'Bloc', 'Animations'],
    ),
    CareerEvent(
      title: 'Dwarkadas Jivanlal Sanghvi College Of Engineering',
      subtitle: 'Bachelor\'s in AI & Data Science',
      date: '2022 - 2024',
      description:
          'Focused on programming, data analytics, and machine learning.',
      icon: Icons.computer,
      skills: ['Python', 'Machine Learning', 'Data Analysis', 'ML'],
    ),
    CareerEvent(
      title: 'Site Soch LLP',
      subtitle: 'Web Development Intern',
      date: '2021',
      description: 'Used PHP to refurbish clients\' websites.',
      icon: Icons.computer_outlined,
      skills: ['PHP', 'Gulp.js'],
    ),
    CareerEvent(
      title: 'Shri Bhagubhai Mafatlal Polytechnic',
      subtitle: 'Diploma in Information Technology',
      date: '2019 - 2022',
      description: 'Started journey in technology.',
      icon: Icons.computer_outlined,
      skills: ['C', 'C++', 'DBMS'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: kPrimary,
            size: isMobile ? 24 : 28,
          ),
          onPressed: () => Navigator.pushReplacementNamed(context, '/'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : (isTablet ? 48 : 96),
                vertical: 64,
              ),
              child: Column(
                children: [
                  Text(
                    'Career Journey',
                    style: TextStyle(
                      color: kPrimary,
                      fontSize: isMobile ? 32 : (isTablet ? 48 : 64),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BebasNeue',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 2,
                    width: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color.fromRGBO(0, 255, 0, 0),
                          const Color.fromRGBO(0, 255, 0, 128),
                          kPrimary,
                          const Color.fromRGBO(0, 255, 0, 128),
                          const Color.fromRGBO(0, 255, 0, 0),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
            // Timeline
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : (isTablet ? 32 : 64),
              ),
              child: Column(
                children: careerEvents.asMap().entries.map((entry) {
                  final index = entry.key;
                  final event = entry.value;
                  final isEven = index % 2 == 0;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 48),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side (for even indices)
                        if (isEven && !isMobile) ...[
                          Expanded(
                            flex: 1,
                            child:
                                _buildEventContent(event, isMobile, isTablet),
                          ),
                          const SizedBox(width: 32),
                          _buildTimelineConnector(
                              index == careerEvents.length - 1),
                          const SizedBox(width: 32),
                          Expanded(flex: 1, child: Container()),
                        ],
                        // Right side (for odd indices)
                        if (!isEven && !isMobile) ...[
                          Expanded(flex: 1, child: Container()),
                          const SizedBox(width: 32),
                          _buildTimelineConnector(
                              index == careerEvents.length - 1),
                          const SizedBox(width: 32),
                          Expanded(
                            flex: 1,
                            child:
                                _buildEventContent(event, isMobile, isTablet),
                          ),
                        ],
                        // Mobile view
                        if (isMobile) ...[
                          _buildTimelineConnector(
                              index == careerEvents.length - 1),
                          const SizedBox(width: 16),
                          Expanded(
                            child:
                                _buildEventContent(event, isMobile, isTablet),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),
            // Download Button
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : (isTablet ? 48 : 96),
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_pdfBytes != null) {
                      downloadPdfWeb(_pdfBytes!, 'Shubh_Harde_Resume.pdf');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    foregroundColor: kBlack,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    shadowColor: const Color.fromRGBO(0, 255, 0, 0.3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.download_rounded,
                        color: kBlack,
                        size: isMobile ? 20 : 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Download Resume',
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Saira',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineConnector(bool isLast) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: kPrimary,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(0, 255, 0, 0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimary,
              ),
            ),
          ),
        ),
        if (!isLast)
          Container(
            width: 2,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kPrimary,
                  const Color.fromRGBO(0, 255, 0, 0.3),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEventContent(CareerEvent event, bool isMobile, bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(0, 255, 0, 0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 255, 0, 0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                event.icon,
                color: kPrimary,
                size: isMobile ? 24 : 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: TextStyle(
                        color: kPrimary,
                        fontSize: isMobile ? 20 : (isTablet ? 24 : 28),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Saira',
                      ),
                    ),
                    Text(
                      event.subtitle,
                      style: TextStyle(
                        color: const Color.fromRGBO(0, 255, 0, 0.7),
                        fontSize: isMobile ? 16 : (isTablet ? 18 : 20),
                        fontFamily: 'Saira',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            event.date,
            style: TextStyle(
              color: const Color.fromRGBO(0, 255, 0, 0.5),
              fontSize: isMobile ? 14 : 16,
              fontFamily: 'Saira',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            event.description,
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: isMobile ? 14 : 16,
              height: 1.6,
              fontFamily: 'Saira',
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: event.skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(0, 255, 0, 0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  skill,
                  style: TextStyle(
                    color: kPrimary,
                    fontSize: isMobile ? 12 : 14,
                    fontFamily: 'Saira',
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CareerEvent {
  final String title;
  final String subtitle;
  final String date;
  final String description;
  final IconData icon;
  final List<String> skills;

  CareerEvent({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.description,
    required this.icon,
    required this.skills,
  });
}
