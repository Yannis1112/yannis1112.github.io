import 'package:flutter/material.dart';
import 'package:portfolio/screens/projects/living_dex.dart';
import 'package:portfolio/screens/projects/orienteering.dart';
import 'package:portfolio/screens/projects/tasty_recipes.dart';
import 'package:portfolio/screens/widgets/menu.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/project_page.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 500,
                child: ProjectCarousel(),
              ),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  left: _animation.value,
                  top: 0,
                  bottom: 0,
                  child: child!,
                );
              },
              child: Menu(),
            ),
          ],
        ),
      ),
    );
  }
}

class Project {
  final Widget image;  // Change 'image' pour un Widget, pour pouvoir passer une Row avec plusieurs images
  final String title;
  final Widget page;

  Project({required this.image, required this.title, required this.page});
}

class ProjectCarousel extends StatefulWidget {
  const ProjectCarousel({super.key});

  @override
  _ProjectCarouselState createState() => _ProjectCarouselState();
}

class _ProjectCarouselState extends State<ProjectCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentIndex = 0;

  final List<Project> projects = [
    Project(
      image: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/living_auth.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/living_home.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/living_dex.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      title: 'Living Dex',
      page: LivingDex(),
    ),
    Project(
      image: Image.asset(
        'assets/orienteering_home.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: 500,
      ),
      title: 'Orienteering',
      page: Orienteering(),
    ),
    Project(
      image: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/tasty_home.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/tasty_add_recipe.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/tasty_profil.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      title: 'Tasty Recipes',
      page: TastyRecipes(),
    ),
  ];

  void _nextPage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % projects.length;
      _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  void _previousPage() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + projects.length) % projects.length;
      _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: projects.length,
          onPageChanged: (index) => setState(() => _currentIndex = index),
          itemBuilder: (context, index) {
            final project = projects[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => project.page),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      project.image,  // Affiche le widget image passé ici
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          color: Colors.black54,
                          child: Text(
                            project.title,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Positioned(
          left: 10,
          top: 0,
          bottom: 0,
          child: Center(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: _previousPage,
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 0,
          bottom: 0,
          child: Center(
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: _nextPage,
            ),
          ),
        ),
      ],
    );
  }
}

