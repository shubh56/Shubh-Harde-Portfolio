import 'package:flutter/material.dart';
import 'package:shubh_harde_portfolio/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPlayerReplacementHovered = false;
  bool _isLaborLinkHovered = false;
  bool _isTSPSolverHovered = false;
  bool _isActivityRecognitionHovered = false;
  bool _isFaceVerificationHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered, String project) {
    setState(() {
      if (project == 'player_replacement') {
        _isPlayerReplacementHovered = isHovered;
      } else if (project == 'labor_link') {
        _isLaborLinkHovered = isHovered;
      } else if (project == 'tsp_solver') {
        _isTSPSolverHovered = isHovered;
      } else if (project == 'activity_recognition') {
        _isActivityRecognitionHovered = isHovered;
      } else {
        _isFaceVerificationHovered = isHovered;
      }
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildProjectCard({
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required List<String> techTags,
    required String projectUrl,
    required bool isHovered,
    required String projectId,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    return MouseRegion(
      onEnter: (_) => _onHover(true, projectId),
      onExit: (_) => _onHover(false, projectId),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: isHovered ? 1.05 : 1.0,
        child: GestureDetector(
          onTap: () => _launchURL(projectUrl),
          child: Container(
            width: isMobile ? double.infinity : 600,
            height: 650,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    isHovered ? kPrimary : const Color.fromRGBO(0, 255, 0, 0.3),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isHovered
                      ? const Color.fromRGBO(0, 255, 0, 0.2)
                      : const Color.fromRGBO(0, 255, 0, 0.1),
                  blurRadius: isHovered ? 20 : 10,
                  spreadRadius: isHovered ? 5 : 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 255, 0, 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: kPrimary,
                        size: isMobile ? 32 : 40,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: kPrimary,
                              fontSize: isMobile ? 24 : (isTablet ? 32 : 40),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Saira',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            subtitle,
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
                const SizedBox(height: 32),
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 0.8),
                      fontSize: isMobile ? 14 : 16,
                      height: 1.6,
                      fontFamily: 'Saira',
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: techTags.map((tag) => _buildTechTag(tag)).toList(),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(0, 255, 0, 0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View Project',
                            style: TextStyle(
                              color: kBlack,
                              fontSize: isMobile ? 14 : 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Saira',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: kBlack,
                            size: isMobile ? 16 : 20,
                          ),
                        ],
                      ),
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

  Widget _buildTechTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(0, 255, 0, 0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: kPrimary,
          fontSize: 14,
          fontFamily: 'Saira',
        ),
      ),
    );
  }

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
                    'Projects',
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
            // Projects Grid
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : (isTablet ? 48 : 96),
              ),
              child: Center(
                child: Wrap(
                  spacing: 32,
                  runSpacing: 32,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildProjectCard(
                      title: 'Player Replacement Finder',
                      subtitle: 'Football Analytics Project',
                      description:
                          'A sophisticated tool that helps football clubs identify potential player replacements based on statistical analysis and performance metrics. This project combines advanced data analytics with football expertise to provide actionable insights for player recruitment.',
                      icon: Icons.sports_soccer_rounded,
                      techTags: [
                        'Python',
                        'Machine Learning',
                        'Data Analysis',
                        'Football Analytics',
                        'Statistical Modeling'
                      ],
                      projectUrl: 'https://player-replacement.web.app/',
                      isHovered: _isPlayerReplacementHovered,
                      projectId: 'player_replacement',
                    ),
                    _buildProjectCard(
                      title: 'Labor Link',
                      subtitle: 'Blue Collar Job Marketplace',
                      description:
                          'A Flutter-based application designed to bridge the gap between blue-collar workers and potential customers. The platform facilitates easy job discovery and connection, helping workers find employment opportunities while enabling customers to find reliable service providers for their needs.',
                      icon: Icons.work_rounded,
                      techTags: [
                        'Flutter',
                        'Dart',
                        'Mobile Development',
                        'UI/UX Design',
                        'Firebase'
                      ],
                      projectUrl: 'https://github.com/shubh56/Labor-Link',
                      isHovered: _isLaborLinkHovered,
                      projectId: 'labor_link',
                    ),
                    _buildProjectCard(
                      title: 'TSP Solver',
                      subtitle: 'Hybrid ACO-Q-Learning Approach',
                      description:
                          'An innovative solution to the Traveling Salesman Problem using a novel hybrid approach combining Ant Colony Optimization and Q-Learning. This project demonstrates the effectiveness of combining swarm intelligence with reinforcement learning to solve complex optimization problems.',
                      icon: Icons.route_rounded,
                      techTags: [
                        'Python',
                        'Machine Learning',
                        'Reinforcement Learning',
                        'Optimization',
                        'ACO',
                        'Q-Learning'
                      ],
                      projectUrl:
                          'https://colab.research.google.com/drive/1dvDOlhkIKfUOb_b4qB9ybKVZd_vGSjP0?usp=sharing',
                      isHovered: _isTSPSolverHovered,
                      projectId: 'tsp_solver',
                    ),
                    _buildProjectCard(
                      title: 'Activity Recognition',
                      subtitle: 'Deep Learning with CNNs',
                      description:
                          'A deep learning project that uses Convolutional Neural Networks (CNNs) to recognize and classify human activities in images. The model demonstrates advanced computer vision techniques and achieves high accuracy in identifying various activities from static images.',
                      icon: Icons.visibility_rounded,
                      techTags: [
                        'Python',
                        'Deep Learning',
                        'CNN',
                        'Computer Vision',
                        'TensorFlow',
                        'Image Processing'
                      ],
                      projectUrl:
                          'https://colab.research.google.com/drive/1q3EFizti4RxVHNbQqvcgrYRWK8DNel5p?usp=sharing',
                      isHovered: _isActivityRecognitionHovered,
                      projectId: 'activity_recognition',
                    ),
                    _buildProjectCard(
                      title: 'Face Verification',
                      subtitle: 'Computer Vision API',
                      description:
                          'A robust web service API for facial feature similarity verification between images. Built using Flask and OpenCV, it implements advanced computer vision techniques including Haar cascade classifiers and SIFT algorithm for accurate facial feature matching and verification.',
                      icon: Icons.face_rounded,
                      techTags: [
                        'Python',
                        'OpenCV',
                        'Flask',
                        'Computer Vision',
                        'API Development',
                        'SIFT Algorithm'
                      ],
                      projectUrl: 'https://github.com/shubh56/FaceVerification',
                      isHovered: _isFaceVerificationHovered,
                      projectId: 'face_verification',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
