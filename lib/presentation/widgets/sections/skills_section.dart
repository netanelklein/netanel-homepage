import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/portfolio_repository.dart';
import '../../../data/services/api_service.dart';
import '../../../data/models/skill.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioRepository>(
      builder: (context, portfolioRepo, child) {
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
              if (portfolioRepo.loadingState == LoadingState.loading)
                _buildLoadingSkeleton(context)
              else if (portfolioRepo.loadingState == LoadingState.error)
                _buildErrorState(context, portfolioRepo)
              else if (portfolioRepo.portfolioData?.skillCategories.isEmpty ??
                  true)
                _buildEmptyState(context)
              else
                _buildSkillsGrid(
                    context, portfolioRepo.portfolioData!.skillCategories),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkillsGrid(
      BuildContext context, List<SkillCategory> skillCategories) {
    // Sort categories by display order
    final sortedCategories = List<SkillCategory>.from(skillCategories)
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDesktop =
            sizingInformation.deviceScreenType == DeviceScreenType.desktop;
        final crossAxisCount = isDesktop ? 2 : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: isDesktop ? 1.2 : 0.8,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: sortedCategories.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              delay: Duration(milliseconds: 100 * index),
              child: _buildSkillCategoryCard(context, sortedCategories[index]),
            );
          },
        );
      },
    );
  }

  Widget _buildSkillCategoryCard(BuildContext context, SkillCategory category) {
    return Card(
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header
            Row(
              children: [
                if (category.iconName != null) ...[
                  Icon(
                    _getIconFromName(category.iconName!),
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    category.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Category description
            Text(
              category.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  ),
            ),

            const SizedBox(height: 20),

            // Skills grid
            Expanded(
              child: _buildSkillsList(context, category.skills),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsList(BuildContext context, List<Skill> skills) {
    // Sort skills by level (expert first) and highlighted status
    final sortedSkills = List<Skill>.from(skills)
      ..sort((a, b) {
        if (a.isHighlighted && !b.isHighlighted) return -1;
        if (!a.isHighlighted && b.isHighlighted) return 1;
        return b.levelPercentage.compareTo(a.levelPercentage);
      });

    return SingleChildScrollView(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: sortedSkills
            .map((skill) => _buildSkillChip(context, skill))
            .toList(),
      ),
    );
  }

  Widget _buildSkillChip(BuildContext context, Skill skill) {
    final levelColor = _getLevelColor(context, skill.level);

    return Tooltip(
      message:
          '${skill.name}\n${skill.levelLabel} (${skill.yearsOfExperience} years)',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: skill.isHighlighted
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
              : Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: skill.isHighlighted
                ? Theme.of(context).colorScheme.primary
                : levelColor.withValues(alpha: 0.3),
            width: skill.isHighlighted ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Skill level indicator
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: levelColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),

            // Skill name
            Text(
              skill.name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: skill.isHighlighted
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: skill.isHighlighted
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingSkeleton(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDesktop =
            sizingInformation.deviceScreenType == DeviceScreenType.desktop;
        final crossAxisCount = isDesktop ? 2 : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: isDesktop ? 1.2 : 0.8,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: 4, // Show 4 skeleton cards
          itemBuilder: (context, index) {
            return Card(
              elevation: 8,
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category title skeleton
                    Container(
                      height: 24,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Description skeleton
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Skills skeleton
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(6, (skillIndex) {
                          return Container(
                            height: 28,
                            width: 60 + (skillIndex * 10), // Varying widths
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildErrorState(
      BuildContext context, PortfolioRepository portfolioRepo) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load skills',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Please check your connection and try again',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => portfolioRepo.refresh(),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.code_off,
            size: 64,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'No skills available',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Skills will be displayed here when available',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.4),
                ),
          ),
        ],
      ),
    );
  }

  IconData _getIconFromName(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'code':
        return Icons.code;
      case 'devices':
        return Icons.devices;
      case 'cloud':
        return Icons.cloud;
      case 'storage':
        return Icons.storage;
      case 'security':
        return Icons.security;
      case 'language':
        return Icons.language;
      case 'psychology':
        return Icons.psychology;
      case 'build':
        return Icons.build;
      default:
        return Icons.star;
    }
  }

  Color _getLevelColor(BuildContext context, SkillLevel level) {
    switch (level) {
      case SkillLevel.beginner:
        return Colors.orange;
      case SkillLevel.intermediate:
        return Colors.blue;
      case SkillLevel.advanced:
        return Colors.green;
      case SkillLevel.expert:
        return Theme.of(context).colorScheme.primary;
    }
  }
}
