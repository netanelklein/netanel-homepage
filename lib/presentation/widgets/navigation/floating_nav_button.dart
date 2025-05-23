import 'package:flutter/material.dart';

class FloatingNavButton extends StatefulWidget {
  final Function(String) onSectionTap;

  const FloatingNavButton({
    super.key,
    required this.onSectionTap,
  });

  @override
  State<FloatingNavButton> createState() => _FloatingNavButtonState();
}

class _FloatingNavButtonState extends State<FloatingNavButton>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<NavItem> _navItems = [
    NavItem('Home', 'hero', Icons.home),
    NavItem('About', 'about', Icons.person),
    NavItem('Projects', 'projects', Icons.work),
    NavItem('Skills', 'skills', Icons.code),
    NavItem('CV', 'cv', Icons.description),
    NavItem('Contact', 'contact', Icons.email),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Navigation items
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _navItems.asMap().entries.map((entry) {
                  final item = entry.value;
                  
                  return Transform.scale(
                    scale: _animation.value,
                    child: Transform.translate(
                      offset: Offset(0, (1 - _animation.value) * 50),
                      child: Opacity(
                        opacity: _animation.value,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Label
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.15),
                                      blurRadius: 8,
                                      offset: const Offset(-2, 2),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                                  ),
                                ),
                                child: Text(
                                  item.title,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              
                              const SizedBox(width: 12),
                              
                              // Button
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: FloatingActionButton.small(
                                  onPressed: () {
                                    widget.onSectionTap(item.route);
                                    _toggleExpanded(); // Close menu after selection
                                  },
                                  heroTag: item.route,
                                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                  elevation: 0,
                                  child: Icon(
                                    item.icon,
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          
          const SizedBox(height: 16),
          
          // Main toggle button
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: _toggleExpanded,
              backgroundColor: Theme.of(context).colorScheme.primary,
              elevation: 0,
              child: AnimatedRotation(
                turns: _isExpanded ? 0.125 : 0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  _isExpanded ? Icons.close : Icons.navigation,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class NavItem {
  final String title;
  final String route;
  final IconData icon;

  NavItem(this.title, this.route, this.icon);
}
