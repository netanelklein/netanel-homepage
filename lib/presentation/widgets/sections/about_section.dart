import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/portfolio_repository.dart';
import '../../../data/services/api_service.dart';
import '../../../data/models/personal_info.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioRepository>(
      builder: (context, portfolioRepo, child) {
        return ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (portfolioRepo.loadingState == LoadingState.loading) {
              return _buildLoadingSkeleton(context, sizingInformation);
            }

            if (portfolioRepo.loadingState == LoadingState.error) {
              return _buildErrorState(context);
            }

            final personalInfo = portfolioRepo.portfolioData?.personalInfo;
            
            if (personalInfo == null) {
              return _buildErrorState(context);
            }

            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: sizingInformation.isDesktop ? 80 : 20,
                vertical: 80,
              ),
              child: Column(
                children: [
                  FadeInUp(
                    child: Text(
                      'About Me',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  if (sizingInformation.isDesktop)
                    _buildDesktopLayout(context, personalInfo)
                  else
                    _buildMobileLayout(context, personalInfo),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context, PersonalInfo personalInfo) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Image
        Expanded(
          flex: 2,
          child: FadeInLeft(
            delay: const Duration(milliseconds: 200),
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  size: 100,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 60),

        // Right side - Content
        Expanded(
          flex: 3,
          child: FadeInRight(
            delay: const Duration(milliseconds: 400),
            child: _buildContent(context, personalInfo),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, PersonalInfo personalInfo) {
    return Column(
      children: [
        FadeInUp(
          delay: const Duration(milliseconds: 200),
          child: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 80,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        FadeInUp(
          delay: const Duration(milliseconds: 400),
          child: _buildContent(context, personalInfo),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, PersonalInfo personalInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          personalInfo.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          personalInfo.summary,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          'Beyond the technical realm, I find joy in crafting the perfect brew, mixing innovative cocktails, and creating music on my electric guitar. These creative pursuits fuel my problem-solving approach and bring a unique perspective to my engineering work.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
              ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildTag(context, '🔧 IoT Development'),
            _buildTag(context, '☁️ Cloud Infrastructure'),
            _buildTag(context, '📱 Mobile Apps'),
            _buildTag(context, '🍺 Brewing Enthusiast'),
            _buildTag(context, '🎸 Musician'),
            _buildTag(context, '🍸 Mixologist'),
          ],
        ),
      ],
    );
  }

  Widget _buildTag(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  Widget _buildLoadingSkeleton(
      BuildContext context, SizingInformation sizingInformation) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: sizingInformation.isDesktop ? 80 : 20,
        vertical: 80,
      ),
      child: Column(
        children: [
          Container(
            width: 200,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 60),
          if (sizingInformation.isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(width: 60),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 250,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...List.generate(
                          4,
                          (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Container(
                                  width: double.infinity,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              )),
                    ],
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                width: double.infinity,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            )),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load About section',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please check your internet connection and try again.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Provider.of<PortfolioRepository>(context, listen: false)
                  .refresh();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
