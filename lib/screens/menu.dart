
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myportfolio_mobile/widgets/left_drawer.dart';
import 'package:myportfolio_mobile/widgets/auth_guard.dart';
import 'package:myportfolio_mobile/screens/project_form.dart';
import 'package:myportfolio_mobile/screens/experience_form.dart';
import 'package:myportfolio_mobile/screens/experience_list_screen.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2606816516";
  final String nama = "Veronika Chebotareva";
  final String kelas = "PBP A";

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    final List<ItemHomepage> items = [
      ItemHomepage(
        "View Projects",
        Icons.folder,
        const Color(0xFFFFA000),
      ),
      ItemHomepage(
        "Add Project",
        Icons.add_circle,
        const Color(0xFF00674F),
      ),
      ItemHomepage(
        "View Experiences",
        Icons.work_outline,
        const Color(0xFFFFA000),
      ),
      ItemHomepage(
        "Add Experience",
        Icons.work,
        const Color(0xFF00674F),
      ),
      ItemHomepage(
        isLoggedIn ? "Logout" : "Login",
        isLoggedIn ? Icons.logout : Icons.login,
        const Color(0xFF800000),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF00674F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                'Welcome to MyPortfolio Mobile!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            GridView.count(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              shrinkWrap: true,
              childAspectRatio:
                  MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 2.5),
              children: items.map((ItemHomepage item) {
                return ItemCard(item);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                content,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          if (item.name == "View Experiences") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ExperienceListScreen(),
              ),
            );
          } else if (item.name == "Add Experience") {
            final loggedIn = await ensureLoggedIn(context);

            if (!loggedIn || !context.mounted) return;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ExperienceFormPage(),
              ),
            );
          } else if (item.name == "Add Project") {
            final loggedIn = await ensureLoggedIn(context);

            if (!loggedIn || !context.mounted) return;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProjectFormPage(),
              ),
            );
          } else if (item.name == "Login") {
            final loggedIn = await ensureLoggedIn(context);

            if (loggedIn && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logged in successfully!"),
                ),
              );
            }
          } else if (item.name == "Logout") {
            await context.read<AuthState>().logout();

            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Logged out successfully!"),
              ),
            );
          } else if (item.name == "View Projects") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Projects are not connected yet."),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const SizedBox(height: 6),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
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
