import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Container(
          height: sizingInformation.isDesktop ? 700 : 600,
          padding: EdgeInsets.symmetric(
            horizontal: sizingInformation.isDesktop ? 80 : 20,
          ),
          child: Stack(
            children: [
              // Background circuit pattern (subtle)
              Positioned.fill(
                child: CustomPaint(
                  painter: CircuitPatternPainter(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  ),
                ),
              ),
              
              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile image placeholder
                    FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: Container(
                        width: sizingInformation.isDesktop ? 150 : 120,
                        height: sizingInformation.isDesktop ? 150 : 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Name
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        'Netanel Klein',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: sizingInformation.isDesktop ? 48 : 36,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Title/Role
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        'Electrical Engineering Student | DevOps Engineer | Full-Stack Developer',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: sizingInformation.isDesktop ? 24 : 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Tagline with typing animation effect
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        'Building systems from circuits to clouds',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontStyle: FontStyle.italic,
                          fontSize: sizingInformation.isDesktop ? 20 : 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    const SizedBox(height: 50),
                    
                    // Action buttons
                    FadeInUp(
                      delay: const Duration(milliseconds: 800),
                      duration: const Duration(milliseconds: 800),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 15,
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Scroll to projects
                            },
                            icon: const Icon(Icons.work),
                            label: const Text('View Projects'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Scroll to contact
                            },
                            icon: const Icon(Icons.email),
                            label: const Text('Contact Me'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Social links
                    FadeInUp(
                      delay: const Duration(milliseconds: 1000),
                      duration: const Duration(milliseconds: 800),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              // TODO: Open GitHub
                            },
                            icon: const FaIcon(FontAwesomeIcons.github),
                            iconSize: 30,
                            tooltip: 'GitHub',
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            onPressed: () {
                              // TODO: Open LinkedIn
                            },
                            icon: const FaIcon(FontAwesomeIcons.linkedin),
                            iconSize: 30,
                            tooltip: 'LinkedIn',
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
      },
    );
  }
}

// Custom painter for subtle circuit pattern background
class CircuitPatternPainter extends CustomPainter {
  final Color color;

  CircuitPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw subtle circuit-like patterns
    final path = Path();
    
    // Horizontal lines
    for (double y = 0; y < size.height; y += 100) {
      path.moveTo(0, y);
      path.lineTo(size.width, y);
    }
    
    // Vertical lines
    for (double x = 0; x < size.width; x += 150) {
      path.moveTo(x, 0);
      path.lineTo(x, size.height);
    }
    
    // Small circles at intersections
    for (double x = 0; x < size.width; x += 150) {
      for (double y = 0; y < size.height; y += 100) {
        canvas.drawCircle(Offset(x, y), 3, paint);
      }
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}