import 'package:flutter/material.dart';
import '../home_page.dart';
import '../projects_page.dart';
import '../skills_page.dart';
import 'package:url_launcher/url_launcher.dart';
// TODO: peut-être ajouter une page contact
class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.blueGrey[900],
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              "assets/icons/coureur.png",
              width: 24,
              height: 24,
            ),
            title: Text("Accueil", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/icons/pistolet_roue.png",
              width: 24,
              height: 24,
            ),
            title: Text("Compétences", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SkillsPage()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/icons/volant.png",
              width: 24,
              height: 24,
            ),
            title: Text("Projets", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProjectsPage()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/icons/champion.png",
              width: 24,
              height: 24,
            ),
            title: Text("CV", style: TextStyle(color: Colors.white)),
            onTap: () async {
              final url = "assets/CV_Yannis_Philippot.pdf";
              final uri = Uri.parse(url);
              if(!await launchUrl(uri)) {
                throw 'Impossible de lancer $uri';
              }
            },
          ),
        ],
      ),
    );
  }
}