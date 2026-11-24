import 'package:flutter/material.dart';

import '../sections/about_section.dart';
import '../sections/contact_section.dart';
import '../sections/hero_section.dart';
import '../sections/marquee_strip.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../utils/links.dart';
import '../widgets/nav_bar.dart';
import '../widgets/whatsapp_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scroll = ScrollController();
  final _homeKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();
  bool _showTop = false;

  late final List<NavItem> _navItems = [
    NavItem('Home', _homeKey),
    NavItem('About', _aboutKey),
    NavItem('Skills', _skillsKey),
    NavItem('Work', _projectsKey),
    NavItem('Contact', _contactKey),
  ];

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      final show = _scroll.offset > 600;
      if (show != _showTop) setState(() => _showTop = show);
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 900), curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      endDrawer: NavDrawer(items: _navItems, onTap: _scrollTo),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scroll,
            child: Column(
              children: [
                const SizedBox(height: 76),
                HeroSection(key: _homeKey, onViewWork: () => _scrollTo(_projectsKey)),
                const MarqueeStrip(),
                AboutSection(key: _aboutKey),
                SkillsSection(key: _skillsKey),
                ProjectsSection(key: _projectsKey),
                ContactSection(key: _contactKey),
                const Footer(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(items: _navItems, onTap: _scrollTo, onHire: () => _scrollTo(_contactKey)),
          ),
          Positioned(
            left: 24,
            bottom: 24,
            child: Tooltip(
              message: 'Chat on WhatsApp',
              child: FloatingActionButton(
                heroTag: 'whatsapp',
                backgroundColor: const Color(0xFF25D366),
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                onPressed: () => openLink(PortfolioData.whatsapp),
                child: const WhatsAppIcon(size: 30),
              ),
            ),
          ),
          Positioned(
            right: 24,
            bottom: 24,
            child: AnimatedScale(
              scale: _showTop ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              child: FloatingActionButton.small(
                heroTag: 'top',
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.background,
                onPressed: () => _scroll.animateTo(0, duration: const Duration(milliseconds: 900), curve: Curves.easeInOutCubic),
                child: const Icon(Icons.arrow_upward_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
