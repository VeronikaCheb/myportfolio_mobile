
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/experience.dart';
import '../services/api_client.dart';
import '../widgets/left_drawer.dart';
import 'experience_detail_screen.dart';

class ExperienceListScreen extends StatefulWidget {
  const ExperienceListScreen({super.key});

  @override
  State<ExperienceListScreen> createState() =>
      _ExperienceListScreenState();
}

class _ExperienceListScreenState
    extends State<ExperienceListScreen> {
  late Future<List<Experience>> _experiencesFuture;

  @override
  void initState() {
    super.initState();
    _experiencesFuture =
        context.read<ApiClient>().getExperiences();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getExperiences();

    setState(() {
      _experiencesFuture = future;
    });

    try {
      await future;
    } catch (_) {
      // FutureBuilder displays the error.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiences'),
        backgroundColor: const Color(0xFF00674F),
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Experience>>(
        future: _experiencesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: _reload,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final experiences = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: _reload,
            child: experiences.isEmpty
                ? ListView(
                    physics:
                        const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: 150),
                      Center(
                        child: Text('No experiences found.'),
                      ),
                    ],
                  )
                : ListView.builder(
                    physics:
                        const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    itemCount: experiences.length,
                    itemBuilder: (context, index) {
                      final experience = experiences[index];

                      return Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.work,
                            color: Color(0xFF00674F),
                          ),
                          title: Text(experience.title),
                          subtitle: Text(
                            '${experience.category}\n'
                            '${experience.description}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ExperienceDetailScreen(
                                  experience: experience,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
