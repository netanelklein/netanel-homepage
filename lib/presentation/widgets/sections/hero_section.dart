import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../common/artistic_background.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return ArtisticBackground(
          isHeroSection: true,
          child: Container(
            height: sizingInformation.isDesktop ? 700 : 600,
            padding: EdgeInsets.symmetric(
              horizontal: sizingInformation.isDesktop ? 80 : 20,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile image placeholder with artistic border
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
                            const Color(0xFF64B5F6), // Light blue accent
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                          BoxShadow(
                            color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
                            blurRadius: 40,
                            spreadRadius: 10,
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
                  
                  // Name with enhanced styling
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 800),
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ).createShader(bounds),
                      child: Text(
                        'Netanel Klein',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: sizingInformation.isDesktop ? 48 : 36,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Title/Role with artistic styling
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                        ),
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      ),
                      child: Text(
                        'Electrical Engineering Student | DevOps Engineer | Full-Stack Developer',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: sizingInformation.isDesktop ? 20 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // UPDATED TAGLINE with circuit and cocktail icons
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.15),
                          ],
                        ),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Circuit icon (representing engineering/tech)
                          Icon(
                            Icons.memory,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Crafting solutions from circuits to cocktails',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontStyle: FontStyle.italic,
                                fontSize: sizingInformation.isDesktop ? 22 : 18,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Cocktail icon (representing mixology hobby)
                          Icon(
                            Icons.local_bar,
                            size: 20,
                            color: Colors.amber.shade600,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 50),
                  
                  // Enhanced action buttons
                  FadeInUp(
                    delay: const Duration(milliseconds: 800),
                    duration: const Duration(milliseconds: 800),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 15,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildArtisticButton(
                          context,
                          'View Projects',
                          Icons.work,
                          true,
                          () {
                            // TODO: Scroll to projects
                          },
                        ),
                        _buildArtisticButton(
                          context,
                          'Contact Me',
                          Icons.email,
                          false,
                          () {
                            // TODO: Scroll to contact
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Enhanced social links
                  FadeInUp(
                    delay: const Duration(milliseconds: 1000),
                    duration: const Duration(milliseconds: 800),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialIcon(
                          context,
                          FontAwesomeIcons.github,
                          'GitHub',
                          () {
                            // TODO: Open GitHub - will link to netanelklein
                          },
                        ),
                        const SizedBox(width: 30),
                        _buildSocialIcon(
                          context,
                          FontAwesomeIcons.linkedin,
                          'LinkedIn',
                          () {
                            // TODO: Open LinkedIn
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildArtisticButton(
    BuildContext context,
    String text,
    IconData icon,
    bool isPrimary,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: isPrimary 
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)
                : Colors.transparent,
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: isPrimary
          ? ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon),
              label: Text(text),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )
          : OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon),
              label: Text(text),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
            ),
    );
  }

  Widget _buildSocialIcon(
    BuildContext context,
    IconData icon,
    String tooltip,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
          ],
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: FaIcon(icon),
        iconSize: 24,
        tooltip: tooltip,
        padding: const EdgeInsets.all(15),
      ),
    );
  }
}
