import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:ui' as ui;
import '../../core/providers/theme_provider.dart';
import '../widgets/navigation/app_navigation.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/cv_section.dart';
import '../widgets/common/scroll_controller_widget.dart';

class HomePage extends StatefulWidget {
  final ThemeProvider themeProvider;

  const HomePage({
    super.key,
    required this.themeProvider,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _cvKey = GlobalKey();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  double get _navbarOpacity {
    // Calculate opacity based on scroll position
    // More solid at top, gradual transition when scrolling
    const maxOffset = 300.0; // Longer transition distance
    const maxOpacity = 0.98; // Very solid at top
    const minOpacity = 0.75; // Still visible when scrolling

    if (_scrollOffset <= 0) return maxOpacity;
    if (_scrollOffset >= maxOffset) return minOpacity;

    final ratio = _scrollOffset / maxOffset;
    // Use smoother easing for gradual transition
    final easedRatio = ratio * ratio; // Ease-in curve
    return maxOpacity - (easedRatio * (maxOpacity - minOpacity));
  }

  double get _navbarBlur {
    // Calculate blur based on scroll position
    // Start with no blur at top for clean appearance
    // Very gradual blur increase to minimize visual boundary
    const maxOffset = 300.0; // Much longer transition for gradual effect
    const maxBlur = 4.0; // Very subtle maximum blur

    if (_scrollOffset <= 50) return 0.0; // No blur for first 50px of scroll
    if (_scrollOffset >= maxOffset) return maxBlur;

    final adjustedOffset = _scrollOffset - 50; // Start blur after 50px
    final adjustedMaxOffset = maxOffset - 50;

    // Use easing curve for even smoother transition
    final ratio = (adjustedOffset / adjustedMaxOffset);
    final easedRatio = 1 - (1 - ratio) * (1 - ratio); // Ease-out curve

    return easedRatio * maxBlur;
  }

  void _scrollToSection(String section) {
    GlobalKey? targetKey;

    switch (section) {
      case 'hero':
        targetKey = _heroKey;
        break;
      case 'about':
        targetKey = _aboutKey;
        break;
      case 'projects':
        targetKey = _projectsKey;
        break;
      case 'skills':
        targetKey = _skillsKey;
        break;
      case 'contact':
        targetKey = _contactKey;
        break;
      case 'cv':
        targetKey = _cvKey;
        break;
    }

    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          body: Stack(
            children: [
              // Background gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: widget.themeProvider.isDarkMode
                        ? [
                            const Color(0xFF121212),
                            const Color(0xFF1E1E1E),
                            const Color(0xFF2D2D2D),
                          ]
                        : [
                            Colors.white,
                            Colors.blue.shade50,
                            Colors.indigo.shade50,
                          ],
                  ),
                ),
              ),

              // Main content
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // Navigation - Fixed at top
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    snap: false,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: ClipRect(
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(
                          sigmaX: _navbarBlur,
                          sigmaY: _navbarBlur,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withValues(alpha: _navbarOpacity),
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withValues(alpha: _navbarOpacity),
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withValues(alpha: _navbarOpacity * 0.95),
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withValues(alpha: _navbarOpacity * 0.85),
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withValues(alpha: _navbarOpacity * 0.6),
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withValues(alpha: _navbarOpacity * 0.3),
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withValues(alpha: _navbarOpacity * 0.1),
                                Colors.transparent,
                              ],
                              stops: const [
                                0.0,
                                0.6,
                                0.7,
                                0.8,
                                0.87,
                                0.93,
                                0.97,
                                1.0
                              ],
                            ),
                          ),
                          child: AppNavigation(
                            onSectionTap: _scrollToSection,
                            themeProvider: widget.themeProvider,
                            isDesktop: sizingInformation.isDesktop,
                          ),
                        ),
                      ),
                    ),
                    expandedHeight: sizingInformation.isDesktop ? 120 : 110,
                    collapsedHeight: sizingInformation.isDesktop ? 120 : 110,
                  ),

                  // Hero Section
                  SliverToBoxAdapter(
                    child: ScrollControllerWidget(
                      key: _heroKey,
                      child: const HeroSection(),
                    ),
                  ),

                  // About Section
                  SliverToBoxAdapter(
                    child: ScrollControllerWidget(
                      key: _aboutKey,
                      child: const AboutSection(),
                    ),
                  ),

                  // Projects Section
                  SliverToBoxAdapter(
                    child: ScrollControllerWidget(
                      key: _projectsKey,
                      child: const ProjectsSection(),
                    ),
                  ),

                  // Skills Section
                  SliverToBoxAdapter(
                    child: ScrollControllerWidget(
                      key: _skillsKey,
                      child: const SkillsSection(),
                    ),
                  ),

                  // CV Section
                  SliverToBoxAdapter(
                    child: ScrollControllerWidget(
                      key: _cvKey,
                      child: const CvSection(),
                    ),
                  ),

                  // Contact Section
                  SliverToBoxAdapter(
                    child: ScrollControllerWidget(
                      key: _contactKey,
                      child: const ContactSection(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
