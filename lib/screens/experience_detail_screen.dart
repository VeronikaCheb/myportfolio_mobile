
import 'package:flutter/material.dart';
import '../models/experience.dart';

class ExperienceDetailScreen extends StatelessWidget {
  final Experience experience;

  const ExperienceDetailScreen({
    super.key,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(experience.title),
        backgroundColor: const Color(0xFF00674F),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (experience.thumbnail?.isNotEmpty == true)
              Image.network(
                experience.thumbnail!,
                errorBuilder: (_, error, stack) =>
                    const Icon(Icons.broken_image),
              ),
            const SizedBox(height: 16),
            Text(
              experience.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text('Category: ${experience.category}'),
            const SizedBox(height: 12),
            Text(experience.description),
            const SizedBox(height: 12),
            Text(
              experience.endedAt == null
                  ? 'Status: Ongoing'
                  : 'Ended: ${experience.endedAt}',
            ),
          ],
        ),
      ),
    );
  }
}
