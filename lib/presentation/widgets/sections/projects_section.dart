import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          FadeInUp(
            child: Text(
              'Projects',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          const SizedBox(height: 60),
          
          ResponsiveBuilder(
            builder: (context, sizingInformation) {
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: sizingInformation.isDesktop ? 3 : 1,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                childAspectRatio: sizingInformation.isDesktop ? 1.2 : 1.5,
                children: [
                  _buildProjectCard(
                    context,
                    'Mottes Tensiograph App',
                    'Agricultural IoT data visualization with real-time soil monitoring',
                    ['React Native', 'IoT', 'Push Notifications'],
                    FontAwesomeIcons.seedling,
                  ),
                  _buildProjectCard(
                    context,
                    'Automated Brewing System',
                    'Raspberry Pi controlled beer brewing with temperature automation',
                    ['Python', 'Raspberry Pi', 'IoT Sensors'],
                    FontAwesomeIcons.computer,
                  ),
                  _buildProjectCard(
                    context,
                    'Smart Home Monitor',
                    'Custom PCB environmental monitoring for multiple rooms',
                    ['ESP32', 'PCB Design', 'IoT'],
                    FontAwesomeIcons.home,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    String title,
    String description,
    List<String> technologies,
    IconData icon,
  ) {
    return FadeInUp(
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 12),
              
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                ),
              ),
              
              const Spacer(),
              
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: technologies.map((tech) => Chip(
                  label: Text(
                    tech,
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}