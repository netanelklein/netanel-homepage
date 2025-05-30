import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/repositories/portfolio_repository.dart';
import '../../../data/services/api_service.dart';
import '../../../data/models/project.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
                  'Projects',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 60),
              if (portfolioRepo.loadingState == LoadingState.loading)
                _buildLoadingSkeleton(context)
              else if (portfolioRepo.loadingState == LoadingState.error)
                _buildErrorState(context)
              else if (portfolioRepo.portfolioData?.projects.isEmpty ?? true)
                _buildEmptyState(context)
              else
                _buildProjectsGrid(
                    context, portfolioRepo.portfolioData!.projects),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingSkeleton(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDesktop =
            sizingInformation.deviceScreenType == DeviceScreenType.desktop;
        final crossAxisCount = isDesktop
            ? 3
            : (sizingInformation.deviceScreenType == DeviceScreenType.tablet
                ? 2
                : 1);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.2,
          ),
          itemCount: 6,
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context) {
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
            'Failed to load projects',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Please check your connection and try again',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<PortfolioRepository>().refresh();
            },
            child: const Text('Retry'),
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
            Icons.work_outline,
            size: 64,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            'No Projects Yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Projects will appear here once they are added.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, List<Project> projects) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // Sort by priority and take top 6 projects
        final sortedProjects = [...projects]
          ..sort((a, b) => b.priority.compareTo(a.priority));
        final displayProjects = sortedProjects.take(6).toList();

        final isDesktop =
            sizingInformation.deviceScreenType == DeviceScreenType.desktop;
        final crossAxisCount = isDesktop
            ? 3
            : (sizingInformation.deviceScreenType == DeviceScreenType.tablet
                ? 2
                : 1);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.2,
          ),
          itemCount: displayProjects.length,
          itemBuilder: (context, index) {
            final project = displayProjects[index];
            return _buildProjectCard(context, project);
          },
        );
      },
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project) {
    return FadeInUp(
      delay: Duration(milliseconds: 100 * (project.priority % 6)),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and status
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    project.icon,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(project.status)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            project.statusLabel.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: _getStatusColor(project.status),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  project.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // Technologies
            if (project.technologies.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: project.technologies
                      .take(4)
                      .map((tech) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tech,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                          ))
                      .toList(),
                ),
              ),

            // Action buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Builder(
                builder: (context) {
                  // Find GitHub and Demo links
                  final githubLink = project.links
                      .where((link) => link.type.toLowerCase() == 'github')
                      .firstOrNull;
                  final demoLink = project.links
                      .where((link) => link.type.toLowerCase() == 'demo')
                      .firstOrNull;

                  return Row(
                    children: [
                      if (githubLink != null)
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              _launchURL(githubLink.url);
                            },
                            icon: const Icon(Icons.code, size: 16),
                            label: const Text('Code'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                      if (githubLink != null && demoLink != null)
                        const SizedBox(width: 8),
                      if (demoLink != null)
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _launchURL(demoLink.url);
                            },
                            icon: const Icon(Icons.launch, size: 16),
                            label: const Text('Demo'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.completed:
        return Colors.green;
      case ProjectStatus.inProgress:
        return Colors.orange;
      case ProjectStatus.maintained:
        return Colors.blue;
      case ProjectStatus.archived:
        return Colors.grey;
    }
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
