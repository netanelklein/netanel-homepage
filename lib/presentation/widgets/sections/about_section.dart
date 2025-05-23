import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
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
                _buildDesktopLayout(context)
              else
                _buildMobileLayout(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
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
            child: _buildContent(context),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
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
          child: _buildContent(context),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Engineering the Future',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 20),
        
        Text(
          'I\'m an Electrical Engineering student with a passion for bridging the gap between hardware and software. Currently working as a DevOps Engineer, I bring experience in full-stack development and a deep understanding of systems from the ground up.',
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
}
