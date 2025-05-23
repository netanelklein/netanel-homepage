import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CvSection extends StatelessWidget {
  const CvSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: FadeInUp(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Text(
                  'Curriculum Vitae',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 20),
                
                Text(
                  'Download my CV to learn more about my experience and qualifications.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 30),
                
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Download CV
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('Download CV'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}