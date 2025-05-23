import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          FadeInUp(
            child: Text(
              'Skills & Technologies',
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
                crossAxisCount: sizingInformation.isDesktop ? 4 : 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.2,
                children: [
                  _buildSkillCategory(context, 'Engineering', ['Circuit Design', 'IoT', 'PCB Design']),
                  _buildSkillCategory(context, 'DevOps', ['Docker', 'CI/CD', 'Cloud']),
                  _buildSkillCategory(context, 'Frontend', ['Flutter', 'React Native', 'Web']),
                  _buildSkillCategory(context, 'Backend', ['PHP', 'Python', 'APIs']),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(BuildContext context, String title, List<String> skills) {
    return FadeInUp(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              
              const SizedBox(height: 12),
              
              ...skills.map((skill) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text('• $skill'),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
