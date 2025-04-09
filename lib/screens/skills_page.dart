import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/screens/widgets/menu.dart';
import 'package:portfolio/screens/widgets/semented_button.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _selectedCategory = 0;

  final Map<int, List<Map<String, dynamic>>> _skillsData = {
    0: [
      {'name': 'HTML', 'progress': 0.7},
      {'name': 'CSS', 'progress': 0.4},
      {'name': 'Java', 'progress': 0.8},
      {'name': 'Kotlin', 'progress': 0.8},
      {'name': 'JavaScript', 'progress': 0.65},
      {'name': 'TypeScript', 'progress': 0.65},
      {'name': 'C++', 'progress': 0.6},
      {'name': 'PHP', 'progress': 0.5},
      {'name': 'Dart', 'progress': 0.9},
      {'name': 'Git', 'progress': 0.75},
    ],
    1: [
      {'name': 'Node.js', 'progress': 0.75},
      {'name': 'Cake PHP', 'progress': 0.3},
      {'name': 'Flutter', 'progress': 0.85},
    ],
    2: [
      {'name': 'Visual Studio Code', 'progress': 0.75},
      {'name': 'Android Studio', 'progress': 0.9},
      {'name': 'QT Creator', 'progress': 0.65},
      {'name': 'Intellij', 'progress': 0.8},
    ],
    3: [
      {'name': 'MySQL', 'progress': 0.8},
      {'name': 'MongoDB', 'progress': 0.45},
      {'name': 'Neo4j', 'progress': 0.6},
      {'name': 'PostgreSQL', 'progress': 0.7},
      {'name': 'Firebase', 'progress': 0.8},
      {'name': 'Room', 'progress': 0.5},
    ],
    4: [
      {'name': 'Trello', 'progress': 0.95},
      {'name': 'Jira', 'progress': 0.6},
    ],
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: -250, end: 0).animate(_controller);
  }

  void toggleMenu() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _controller,
          ),
          onPressed: toggleMenu,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/skill_page.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 32),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      child: const Text(
                        "Compétences",
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SegmentedButtonWidget(
                          onCategoryChanged: (index) {
                            setState(() {
                              _selectedCategory = index;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        _buildSkillsCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  left: _animation.value,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 250,
                    color: Colors.black, // TODO: Change the color
                    child: child!,
                  ),
                );
              },
              child: const Menu(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsCard() {
    return Card(
      color: Colors.black.withOpacity(0.6),
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 40,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: _skillsData[_selectedCategory]!.map((skill) {
            return Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: skill['progress'],
                        strokeWidth: 16,
                        backgroundColor: Colors.grey[800],
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondaryContainer),
                      ),
                      Center(
                        child: Text(
                          '${(skill['progress'] * 100).toInt()}%',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  skill['name'],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
