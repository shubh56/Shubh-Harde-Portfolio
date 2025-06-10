import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:shubh_harde_portfolio/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:emailjs/emailjs.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _hoveredIndex = -1;
  final ScrollController _scrollController = ScrollController();
  bool _showScrollIndicator = true;
  bool _isScrolled = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    EmailJS.init(const Options(
      publicKey: "0xBWJj1ayoRfzGdF3",
    ));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Hide scroll indicator when scrolled
    if (_scrollController.offset > 0 && _showScrollIndicator) {
      setState(() => _showScrollIndicator = false);
    } else if (_scrollController.offset <= 0 && !_showScrollIndicator) {
      setState(() => _showScrollIndicator = true);
    }

    // Update scroll state for app bar
    final screenHeight = MediaQuery.of(context).size.height;
    if (_scrollController.offset > screenHeight * 0.8 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= screenHeight * 0.8 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  final List<String> skills = [
    'Flutter',
    'Dart',
    'Firebase',
    'Python',
    'TensorFlow',
    'AWS',
    'SQL',
    'Git',
    'Pandas',
    'Numpy',
    'Matplotlib',
    'Seaborn',
    'Scikit-learn',
    'Flask',
    'Docker',
    'Kubernetes',
  ];

  Widget _buildDrawerItem(String text, int index) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: ListTile(
        onTap: () {
          Navigator.pop(context); // Close drawer
          if (text == 'Resume') {
            Navigator.pushNamed(context, 'Resume');
          } else if (text == 'Projects') {
            Navigator.pushNamed(context, 'Projects');
          }
        },
        title: Text(
          text,
          style: TextStyle(
            color: _isScrolled ? kBlack : kPrimary,
            fontSize: 18,
            fontWeight: isHovered ? FontWeight.w600 : FontWeight.w400,
            letterSpacing: 1,
            fontFamily: 'Saira',
          ),
        ),
        trailing: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 2,
          width: isHovered ? 40 : 0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                _isScrolled
                    ? const Color.fromRGBO(0, 0, 0, 128)
                    : const Color.fromRGBO(0, 255, 0, 128),
                _isScrolled ? kBlack : kPrimary,
                _isScrolled
                    ? const Color.fromRGBO(0, 0, 0, 128)
                    : const Color.fromRGBO(0, 255, 0, 128),
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: _isScrolled ? kPrimary : kBlack,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: _isScrolled
                      ? const Color.fromRGBO(0, 0, 0, 77)
                      : const Color.fromRGBO(0, 255, 0, 77),
                  width: 1,
                ),
              ),
            ),
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isScrolled ? kBlack : kPrimary,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isScrolled
                          ? const Color.fromRGBO(0, 0, 0, 77)
                          : const Color.fromRGBO(0, 255, 0, 77),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/ProfilePicture.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          _buildDrawerItem('Resume', 0),
          _buildDrawerItem('Projects', 1),
          _buildDrawerItem('Articles', 2),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    // Calculate responsive font sizes
    final titleFontSize = isMobile ? 48.0 : (isTablet ? 72.0 : 96.0);
    final subtitleFontSize = isMobile ? 20.0 : (isTablet ? 24.0 : 32.0);
    final navItemFontSize = isMobile ? 16.0 : 18.0;

    return Scaffold(
      backgroundColor: kBlack,
      extendBodyBehindAppBar: true,
      drawer: isMobile ? _buildDrawer() : null,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isMobile ? 80 : 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isMobile ? 80 : 100,
          decoration: BoxDecoration(
            color: _isScrolled ? kPrimary : Colors.transparent,
            boxShadow: _isScrolled
                ? [
                    BoxShadow(
                      color: const Color.fromRGBO(0, 255, 0, 77),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ]
                : null,
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
              toolbarHeight: isMobile ? 80 : 100,
              leading: isMobile
                  ? Builder(
                      builder: (context) => IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: _isScrolled ? kBlack : kPrimary,
                          size: 32,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    )
                  : null,
              title: Container(
                margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isMobile) ...[
                      SizedBox(
                        width: isTablet ? 120 : 160,
                        child: _buildNavItem('Resume', 0, navItemFontSize),
                      ),
                      Container(
                        height: 24,
                        width: 1,
                        margin: EdgeInsets.symmetric(
                            horizontal: isTablet ? 16 : 24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color.fromRGBO(0, 0, 0, 0),
                              _isScrolled
                                  ? const Color.fromRGBO(0, 0, 0, 77)
                                  : const Color.fromRGBO(0, 255, 0, 77),
                              const Color.fromRGBO(0, 0, 0, 0),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: isTablet ? 120 : 160,
                        child: _buildNavItem('Projects', 1, navItemFontSize),
                      ),
                      Container(
                        height: 24,
                        width: 1,
                        margin: EdgeInsets.symmetric(
                            horizontal: isTablet ? 16 : 24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color.fromRGBO(0, 0, 0, 0),
                              _isScrolled
                                  ? const Color.fromRGBO(0, 0, 0, 77)
                                  : const Color.fromRGBO(0, 255, 0, 77),
                              const Color.fromRGBO(0, 0, 0, 0),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: isTablet ? 120 : 160,
                        child: _buildNavItem('Articles', 2, navItemFontSize),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      // Background
                      Positioned.fill(
                        child: Container(
                          color: kBlack,
                        ),
                      ),
                      // Main content
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Shubh Harde',
                              style: TextStyle(
                                color: kPrimary,
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                letterSpacing: isMobile ? 1 : 2,
                                fontFamily: 'BebasNeue',
                                shadows: [
                                  Shadow(
                                    color: const Color.fromRGBO(0, 255, 0, 0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 2,
                              width: 200,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    const Color.fromRGBO(0, 255, 0, 0),
                                    const Color.fromRGBO(0, 255, 0, 0.5),
                                    kPrimary,
                                    const Color.fromRGBO(0, 255, 0, 0.5),
                                    const Color.fromRGBO(0, 255, 0, 0),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            SizedBox(height: isMobile ? 12 : 16),
                            AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'Flutter Developer',
                                  textStyle: TextStyle(
                                    color: const Color.fromRGBO(0, 255, 0, 0.7),
                                    fontSize: subtitleFontSize,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: isMobile ? 2 : 4,
                                    fontFamily: 'Saira',
                                  ),
                                  speed: const Duration(milliseconds: 50),
                                ),
                                TypewriterAnimatedText(
                                  'Data Analyst',
                                  textStyle: TextStyle(
                                    color: const Color.fromRGBO(0, 255, 0, 0.7),
                                    fontSize: subtitleFontSize,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: isMobile ? 2 : 4,
                                    fontFamily: 'Saira',
                                  ),
                                  speed: const Duration(milliseconds: 50),
                                ),
                                TypewriterAnimatedText(
                                  'ML Developer',
                                  textStyle: TextStyle(
                                    color: const Color.fromRGBO(0, 255, 0, 0.7),
                                    fontSize: subtitleFontSize,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: isMobile ? 2 : 4,
                                    fontFamily: 'Saira',
                                  ),
                                  speed: const Duration(milliseconds: 50),
                                ),
                                TypewriterAnimatedText(
                                  'Cloud Engineer',
                                  textStyle: TextStyle(
                                    color: const Color.fromRGBO(0, 255, 0, 0.7),
                                    fontSize: subtitleFontSize,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: isMobile ? 2 : 4,
                                    fontFamily: 'Saira',
                                  ),
                                  speed: const Duration(milliseconds: 50),
                                ),
                                TypewriterAnimatedText(
                                  'Sports Analyst',
                                  textStyle: TextStyle(
                                    color: const Color.fromRGBO(0, 255, 0, 0.7),
                                    fontSize: subtitleFontSize,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: isMobile ? 2 : 4,
                                    fontFamily: 'Saira',
                                  ),
                                  speed: const Duration(milliseconds: 50),
                                ),
                              ],
                              totalRepeatCount: 50,
                              pause: const Duration(milliseconds: 800),
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                            ),
                          ],
                        ),
                      ),
                      // Scroll Indicator
                      if (_showScrollIndicator)
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 40,
                          child: Column(
                            children: [
                              Text(
                                'Scroll',
                                style: TextStyle(
                                  color: const Color.fromRGBO(0, 255, 0, 0.5),
                                  fontSize: 14,
                                  fontFamily: 'Saira',
                                ),
                              ),
                              const SizedBox(height: 8),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: const Color.fromRGBO(0, 255, 0, 0.5),
                                size: 32,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                // About Me Section
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : (isTablet ? 48 : 96),
                    vertical: 64,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'About Me',
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
                                    const Color.fromRGBO(0, 255, 0, 0.5),
                                    kPrimary,
                                    const Color.fromRGBO(0, 255, 0, 0.5),
                                    const Color.fromRGBO(0, 255, 0, 0),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              '''I'm Shubh Harde — a football fanatic turned analyst, driven by data and powered by code. Ever since the 2011 Champions League Final, I've been obsessed with the beautiful game — not just watching it, but understanding it. That passion led me to pursue a Bachelor's in Artificial Intelligence & Data Science, where I honed my skills in programming, data analytics, and machine learning. Now, I'm blending that technical expertise with tactical insights to decode football in ways that matter — whether it's identifying player replacements, building statistical models, or scraping performance data from the ground up. I'm currently headed to Sweden to pursue my Master's in Sports Technology at KTH Royal Institute of Technology, aiming to bring cutting-edge sports analysis to clubs back home in India and beyond.
I don't just love football — I live it, study it, and build with it.''',
                              style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 0.8),
                                fontSize: isMobile ? 16 : (isTablet ? 18 : 20),
                                height: 1.6,
                                fontFamily: 'Saira',
                              ),
                            ),
                          ),
                          if (!isMobile) ...[
                            const SizedBox(width: 32),
                            Container(
                              width: isTablet ? 160 : 200,
                              height: isTablet ? 160 : 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: kPrimary,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromRGBO(0, 255, 0, 0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/ProfilePicture.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                // Skills Section
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : (isTablet ? 48 : 96),
                    vertical: 64,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Skills',
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
                                    const Color.fromRGBO(0, 255, 0, 0.5),
                                    kPrimary,
                                    const Color.fromRGBO(0, 255, 0, 0.5),
                                    const Color.fromRGBO(0, 255, 0, 0),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 16,
                          runSpacing: 16,
                          children: skills.map((skill) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromRGBO(0, 255, 0, 0.3),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                skill,
                                style: TextStyle(
                                  color: kPrimary,
                                  fontSize: isMobile ? 14 : 16,
                                  fontFamily: 'Saira',
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                // Social Media Section
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : (isTablet ? 48 : 96),
                    vertical: 64,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Connect With Me',
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
                                    const Color.fromRGBO(0, 255, 0, 0.5),
                                    kPrimary,
                                    const Color.fromRGBO(0, 255, 0, 0.5),
                                    const Color.fromRGBO(0, 255, 0, 0),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialLink(
                              icon: FontAwesomeIcons.github,
                              url: 'https://github.com/shubh56',
                              label: 'GitHub',
                            ),
                            const SizedBox(width: 32),
                            _buildSocialLink(
                              icon: FontAwesomeIcons.xTwitter,
                              url: 'http://x.com/HardeShubh',
                              label: 'X',
                            ),
                            const SizedBox(width: 32),
                            _buildSocialLink(
                              icon: FontAwesomeIcons.linkedin,
                              url: 'www.linkedin.com/in/shubhharde',
                              label: 'LinkedIn',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Contact Form Section
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : (isTablet ? 48 : 96),
                    vertical: 64,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Get in Touch',
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
                      const SizedBox(height: 32),
                      Center(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: isMobile
                                ? double.infinity
                                : (isTablet ? 600 : 800),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    color: kPrimary,
                                    fontFamily: 'Saira',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: TextStyle(
                                      color:
                                          const Color.fromRGBO(0, 255, 0, 179),
                                      fontFamily: 'Saira',
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            const Color.fromRGBO(0, 255, 0, 77),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: kPrimary,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorStyle: const TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Saira',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    color: kPrimary,
                                    fontFamily: 'Saira',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      color:
                                          const Color.fromRGBO(0, 255, 0, 179),
                                      fontFamily: 'Saira',
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            const Color.fromRGBO(0, 255, 0, 77),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: kPrimary,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorStyle: const TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Saira',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _messageController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your message';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    color: kPrimary,
                                    fontFamily: 'Saira',
                                  ),
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    labelText: 'Message',
                                    labelStyle: TextStyle(
                                      color:
                                          const Color.fromRGBO(0, 255, 0, 179),
                                      fontFamily: 'Saira',
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            const Color.fromRGBO(0, 255, 0, 77),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: kPrimary,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorStyle: const TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Saira',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: _sendEmail,
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
                                  ),
                                  child: Text(
                                    'Send Message',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Saira',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLink({
    required IconData icon,
    required String url,
    required String label,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final Uri uri =
              Uri.parse(url.startsWith('http') ? url : 'https://$url');
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(0, 255, 0, 0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                icon,
                color: kPrimary,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: kPrimary,
                  fontSize: 14,
                  fontFamily: 'Saira',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String text, int index, double fontSize) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                if (text == 'Resume') {
                  Navigator.pushNamed(context, 'Resume');
                } else if (text == 'Projects') {
                  Navigator.pushNamed(context, 'Projects');
                }
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                minimumSize: MaterialStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: _isScrolled ? kBlack : kPrimary,
                  fontSize: fontSize,
                  fontWeight: isHovered ? FontWeight.w600 : FontWeight.w400,
                  letterSpacing: 1,
                  fontFamily: 'Saira',
                ),
              ),
            ),
            const SizedBox(height: 4),
            LayoutBuilder(
              builder: (context, constraints) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 2,
                  width: isHovered ? constraints.maxWidth : 0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        _isScrolled
                            ? const Color.fromRGBO(0, 0, 0, 128)
                            : const Color.fromRGBO(0, 255, 0, 128),
                        _isScrolled ? kBlack : kPrimary,
                        _isScrolled
                            ? const Color.fromRGBO(0, 0, 0, 128)
                            : const Color.fromRGBO(0, 255, 0, 128),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;
    const serviceId = "service_533vjdv";
    const templateId = "template_glyq8gi";
    const userId = "0xBWJj1ayoRfzGdF3"; // This is typically your Public Key

    final response = await http.post(
      Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
      headers: {
        'Content-Type': 'application/json',
        'origin': 'http://localhost', // Required for web apps
      },
      body: jsonEncode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          "from_name": _nameController.text,
          "from_email": _emailController.text,
          "message": _messageController.text,
        },
      }),
    );

    debugPrint('EmailJS Response: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      print(_nameController.text);
      print(_emailController.text);
      print(_messageController.text);

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Success!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      throw Exception('Failed to send email: ${response.body}');
    }
  }
}
