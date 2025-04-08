import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Orienteering extends StatefulWidget {
  const Orienteering({super.key});

  @override
  _OrienteeringState createState() => _OrienteeringState();
}

class _OrienteeringState extends State<Orienteering> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Orienteering'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image en haut avec largeur presque entière
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/orienteering_home.png',
                            width: MediaQuery.of(context).size.width * 0.9,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SelectableText(
                        "🎯 Orienteering est un projet que j’ai développé avec 3 autres personnes dans le cadre de mes études. Il s’agit d’un système complet pour créer, gérer et suivre des courses d’orientation et des événements interactifs comme la Fête de la science 🧪🎉. Le projet repose sur deux applications – mobile et web, toutes deux développées en Flutter 🛠️📱💻.\n\n"
                            "🧑‍💼 Application web (interface administrateur) \n\n"
                            "C’est la partie que j’ai entièrement développée. Elle permet aux organisateurs de gérer tous les aspects d'une course d'orientation ou d’un événement :\n\n"
                            "🗺️ Création de parcours personnalisés :\n"
                            "• Ajout de balises avec des détails précis :\n"
                            "• 📍 Nom\n"
                            "• 🌐 Coordonnées GPS\n"
                            "• 🏛️ Lieu\n"
                            "• 🎬 Animation déclenchée \n"
                            "• ❓ Question + ✅❌ Réponses possibles \n"
                            "• 🎚️ Coefficient de difficulté\n\n"
                            "🧑‍🤝‍🧑 Gestion des participants :\n"
                            "• Attribution de badges NFC 🪪 pour identifier chaque participant\n"
                            "• Suivi des passages aux balises en temps réel ⏱️\n\n"
                            "⏳ Paramétrage du temps :\n"
                            "• Temps global pour un événement\n"
                            "• Temps individuel pour une course d’orientation \n\n"
                            "🛰️ Suivi en direct :\n"
                            "Grâce à l’interface web, les organisateurs peuvent visualiser en temps réel la progression des participants tout au long du parcours, balise par balise. Cela permet une gestion dynamique et réactive de l’événement 📊🚀",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            const url = 'https://iutbg-gitlab.iutbourg.univ-lyon1.fr/sae-but31/2024-25-mobile/course-orientation/-/tree/dev/web?ref_type=heads';
                            launchUrl(Uri.parse(url));
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 56),
                          ),
                          child: const Text('Lien Gitlab'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
