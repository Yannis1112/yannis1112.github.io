import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../home_page.dart';
import '../projects_page.dart';
import '../skills_page.dart';
import 'dart:html' as html;

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
            leading: Icon(Icons.home, color: Colors.white),
            title: Text("Accueil", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage("assets/icons/competence.png"),
              color: Colors.white,
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
            leading: ImageIcon(
              AssetImage("assets/icons/departement-informatique.png"),
              color: Colors.white,
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
            leading: ImageIcon(
              AssetImage("assets/icons/cv.png"),
              color: Colors.white,
            ),
            title: Text("CV", style: TextStyle(color: Colors.white)),
            onTap: () async {
              ByteData data = await rootBundle.load("assets/CV_Yannis_Philippot.pdf");
              Uint8List bytes = data.buffer.asUint8List();

              final blob = html.Blob([bytes], 'application/pdf');
              final url = html.Url.createObjectUrlFromBlob(blob);

              html.window.open(url, '_blank');
            },
          ),
        ],
      ),
    );
  }
}