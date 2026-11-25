
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/menu.dart';
import '../screens/project_form.dart';
import '../screens/experience_form.dart';
import '../screens/experience_list_screen.dart';
import '../services/auth_state.dart';
import 'auth_guard.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF00674F),
            ),
            child: Text(
              'My Portfolio',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => MyHomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('View Experiences'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const ExperienceListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Experience'),
            onTap: () async {
              if (await ensureLoggedIn(context) &&
                  context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const ExperienceFormPage(),
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('Add Project'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProjectFormPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              isLoggedIn ? Icons.logout : Icons.login,
            ),
            title: Text(isLoggedIn ? 'Logout' : 'Login'),
            onTap: () async {
              if (isLoggedIn) {
                await context.read<AuthState>().logout();
              } else {
                await ensureLoggedIn(context);
              }

              if (context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
