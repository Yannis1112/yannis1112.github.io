import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LivingDex extends StatefulWidget {
  const LivingDex({super.key});

  @override
  _LivingDexState createState() => _LivingDexState();
}

class _LivingDexState extends State<LivingDex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Living Dex'),
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
                        child : Row(
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
                      ),
                      const SizedBox(height: 16),
                      SelectableText(
                        "🔥 Living Dex – Votre Pokédex Shiny dédié à la 1ère génération ! 🔥\n"
                            "Living Dex est une application conçue pour les chasseurs de Shiny, permettant de suivre facilement sa collection de Pokémon Shiny de la première génération. 🎮✨\n\n"
                            "📌 Fonctionnalités principales :\n"
                            "✅ Ajoutez les Pokémon Shiny que vous avez capturés\n"
                            "✅ Consultez la liste complète des Pokémon de la 1ère génération\n"
                            "✅ Accédez à votre profil personnalisé avec vos captures et le nombre total de Shiny obtenus\n\n"
                            "💻 Deux versions disponibles :\n"
                            "📱 Kotlin (Room)\n"
                            "📱 Flutter (Firebase)\n\n"
                            "L’objectif ? Faciliter le suivi des captures Shiny et offrir une interface simple et efficace aux collectionneurs de la première génération. 💾📊 \n\n"
                            "#Android #Kotlin #Flutter #Firebase #RoomDB #LivingDex #Pokémon #ShinyHunting",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            const url = 'https://gitlab.com/ClementPannecoucke/livingdex_flutter/-/tree/dev?ref_type=heads';
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