import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
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
                  // Navigation
                  SliverToBoxAdapter(
                    child: AppNavigation(
                      onSectionTap: _scrollToSection,
                      themeProvider: widget.themeProvider,
                      isDesktop: sizingInformation.isDesktop,
                    ),
                  ),
                  
                  // Hero Section
                  SliverToBoxAdapter(
                    child: ScrollControllerWidget(
                      key: _heroKey,
                      child: HeroSection(),
                    ),
                  ),
                  
                  // About Section
                  SliverToBoxAdapter(
                    child: ScrollControllerWidget(
                      key: _aboutKey,
                      child: AboutSection(),
                    ),
                  ),
                  
                  // Projects Section
                  SliverToBoxAdapter(
                    child: ScrollControllerWidget(
                      key: _projectsKey,
                      child: ProjectsSection(),
                    ),
                  ),
                  
                  // Skills Section
                  SliverToBoxAdapter(
                    child: ScrollControllerWidget(
                      key: _skillsKey,
                      child: SkillsSection(),
                    ),
                  ),
                  
                  // CV Section
                  SliverToBoxAdapter(
                    child: ScrollControllerWidget(
                      key: _cvKey,
                      child: CvSection(),
                    ),
                  ),
                  
                  // Contact Section
                  SliverToBoxAdapter(
                    child: ScrollControllerWidget(
                      key: _contactKey,
                      child: ContactSection(),
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