import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/providers/theme_provider.dart';

class AppNavigation extends StatefulWidget {
  final Function(String) onSectionTap;
  final ThemeProvider themeProvider;
  final bool isDesktop;

  const AppNavigation({
    super.key,
    required this.onSectionTap,
    required this.themeProvider,
    required this.isDesktop,
  });

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
//  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<NavigationItem> _navItems = [
    NavigationItem('Home', 'hero', Icons.home),
    NavigationItem('About', 'about', Icons.person),
    NavigationItem('Projects', 'projects', Icons.work),
    NavigationItem('Skills', 'skills', Icons.code),
    NavigationItem('CV', 'cv', Icons.description),
    NavigationItem('Contact', 'contact', Icons.email),
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.isDesktop) {
      return _buildDesktopNavigation();
    } else {
      return _buildMobileNavigation();
    }
  }

  Widget _buildDesktopNavigation() {
    return FadeInDown(
      duration: const Duration(milliseconds: 800),
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo/Name
            FadeInLeft(
              delay: const Duration(milliseconds: 200),
              child: Text(
                'Netanel Klein',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            
            // Navigation items
            Row(
              children: [
                ..._navItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  
                  return FadeInDown(
                    delay: Duration(milliseconds: 300 + (index * 100)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextButton(
                        onPressed: () => widget.onSectionTap(item.route),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                
                const SizedBox(width: 20),
                
                // Theme toggle
                FadeInRight(
                  delay: const Duration(milliseconds: 800),
                  child: IconButton(
                    onPressed: widget.themeProvider.toggleTheme,
                    icon: Icon(
                      widget.themeProvider.isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                    ),
                    tooltip: 'Toggle theme',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavigation() {
    return FadeInDown(
      duration: const Duration(milliseconds: 800),
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo/Name
            FadeInLeft(
              delay: const Duration(milliseconds: 200),
              child: Text(
                'NK',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            
            Row(
              children: [
                // Theme toggle
                IconButton(
                  onPressed: widget.themeProvider.toggleTheme,
                  icon: Icon(
                    widget.themeProvider.isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                ),
                
                // Hamburger menu
                FadeInRight(
                  delay: const Duration(milliseconds: 400),
                  child: IconButton(
                    onPressed: () => _showMobileMenu(context),
                    icon: const Icon(Icons.menu),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 30),
            
            // Navigation items
            Expanded(
              child: ListView.builder(
                itemCount: _navItems.length,
                itemBuilder: (context, index) {
                  final item = _navItems[index];
                  return FadeInUp(
                    delay: Duration(milliseconds: index * 100),
                    child: ListTile(
                      leading: Icon(item.icon),
                      title: Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        widget.onSectionTap(item.route);
                      },
                    ),
                  );
                },
              ),
            ),
            
            // Social links
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      _launchURL('https://github.com/netanelklein');
                    },
                    icon: const FaIcon(FontAwesomeIcons.github),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      _launchURL('https://linkedin.com/in/netanelklein');
                    },
                    icon: const FaIcon(FontAwesomeIcons.linkedin),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // URL launcher helper method
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}

class NavigationItem {
  final String title;
  final String route;
  final IconData icon;

  NavigationItem(this.title, this.route, this.icon);
}
