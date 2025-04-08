import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TastyRecipes extends StatefulWidget {
  const TastyRecipes({super.key});

  @override
  _TastyRecipesState createState() => _TastyRecipesState();
}

class _TastyRecipesState extends State<TastyRecipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Tasty Recipes'),
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
                      Center(
                        child : Row(
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
                      ),
                      const SizedBox(height: 16),
                      SelectableText(
                        "Tasty Recipes est une application mobile développée en Flutter avec Firebase, qui réinvente le partage et la découverte de recettes. 🌍✨\n\n"
                            "👨‍🍳 Fonctionnalités clés :\n"
                            "✅ Ajoutez vos propres recettes et partagez-les avec la communauté \n"
                            "✅ Un système de validation administrateur pour garantir des contenus de qualité \n"
                            "✅ Recherchez facilement des recettes selon vos envies \n"
                            "✅ Filtrez les recettes selon différents régimes alimentaires (végétarien, halal, sans gluten…) \n"
                            "✅ L'administrateur peut ajouter des régimes alimentaires pour convenir à chacun \n"
                            "✅ Notez et commentez les recettes pour échanger avec d’autres passionnés de cuisine \n\n"
                            "#Flutter #Firebase #DéveloppementMobile #Cuisine #Recettes #TastyRecipes",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            const url = 'https://github.com/Yannis1112/Tasty-Recipes';
                            launchUrl(Uri.parse(url));
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 56),
                          ),
                          child: const Text('Lien Github'),
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