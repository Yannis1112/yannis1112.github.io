import 'dart:math';

import 'package:flutter/material.dart';

class CircuitPage extends StatelessWidget {
  const CircuitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircuitWidget());
  }
}

class CircuitWidget extends StatefulWidget {
  const CircuitWidget({super.key});

  @override
  _CircuitWidgetState createState() => _CircuitWidgetState();
}

class _CircuitWidgetState extends State<CircuitWidget> {
  final List<Offset> points = [
    Offset(130, 272),
    Offset(160, 240),
    Offset(190, 210),
    Offset(217, 108),
    Offset(250, 130),
    Offset(290, 145),
    Offset(326, 163),
    Offset(360, 175),
    Offset(403, 185),
    Offset(390, 230),
    Offset(381, 272),
    Offset(365, 290),
    Offset(348, 305),
    Offset(300, 310),
    Offset(250, 315),
    Offset(230, 350),
    Offset(196, 381),
    Offset(160, 420),
    Offset(130, 457),
    Offset(110, 480),
    Offset(87, 490),
  ];

  final List<String> stopDescriptions = [
    "Bonjour ! Je m'appelle Yannis Philippot. \n"
        "Je suis actuellement étudiant en BUT Informatique à l'IUT Lyon 1, sur le site de Bourg-en-Bresse.",
    "Mon parcours scolaire : \n\n"
        "• 2015 - 2019 : Collège Saint-Charles, à Feillens \n ➔ Brevet Mention Très Bien \n"
    "• 2019 - 2022 : Lycée Ozanam, à Mâcon \n ➔ BAC général, spécialités Mathématiques et NSI, avec Mention Assez Bien \n"
        "• 2022 - 2025 : IUT Lyon 1, à Bourg-en-Bresse \n ➔ BUT Informatique, spécialité Développement Mobile",
    "En dehors de l’informatique, je consacre mon temps libre à plusieurs activités qui me permettent de m’évader et de me détendre. \n\n"
        "🥾 J’aime partir en randonnée, profiter de la nature et découvrir de nouveaux paysages.\n"
        "🍔 Je m’intéresse également à la cuisine, plus particulièrement à la Street Food.\n"
        "🏎 Passionné par le sport automobile, je suis de près les compétitions et les innovations dans ce domaine. \n"
    "🎮 Enfin, je suis amateur de jeux vidéo, c’est un bon moyen pour moi de me divertir tout en stimulant ma réflexion.\n",
    "Je souhaite m’orienter vers le domaine du développement d'applications. Mon objectif est de concevoir des applications intuitives, performantes et utiles, en alliant à la fois design, expérience utilisateur et fonctionnalités techniques solides.\n"
        "Dans les mois à venir, je veux continuer à progresser sur les technologies que je connais et en apprendre de nouvelles, tout en découvrant les bonnes pratiques de développement à travers des expériences en entreprise. \n"
        "À long terme, je me vois évoluer en tant que développeur d'applications au sein d’une équipe dynamique, sur des projets innovants.",
    "Mes contacts : \n\n"
        "Mail : yannis.philippot@gmail.com\n"
        "Linkedin : www.linkedin.com/in/yannis-philippot\n"
        "Github : https://github.com/Yannis1112\n",
  ];

  final List<int> stopPoints = [0, 3, 8, 14, 20];
  int currentStopIndex = 0;
  int currentPointIndex = 0;
  bool isMoving = false;

  void moveToNextStop() {
    if (isMoving) return;
    isMoving = true;

    int targetStopIndex = (currentStopIndex + 1) % stopPoints.length;
    int targetIndex = stopPoints[targetStopIndex];

    Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: 200));

      setState(() {
        currentPointIndex = (currentPointIndex + 1) % points.length;
      });

      if (currentPointIndex == targetIndex) {
        setState(() {
          currentStopIndex = targetStopIndex;
        });
        isMoving = false;
        return false;
      }

      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
        flex: 1,
        child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: CircuitPainter(points),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                left: points[currentPointIndex].dx - 10,
                top: points[currentPointIndex].dy - 10,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset("assets/icons/casque.png", color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 100,
                right: 250,
                child: ElevatedButton(
                  onPressed: moveToNextStop,
                  child: Text('Suivant'),
                ),
              ),
            ],
          );
        }
        ),
        ),

        // Partie droite : Texte explicatif
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.75),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(24),
              child: Center(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(0.1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: SelectableText(
                    stopDescriptions[currentStopIndex],
                    key: ValueKey<int>(currentStopIndex),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CircuitPainter extends CustomPainter {
  final List<Offset> points;

  CircuitPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    // Peinture du circuit principal (plus épais)
    final Paint circuitPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Ligne de départ (blanche)
    final Paint startLinePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5;

    // Drapeau (damier noir et blanc simple)
    final double flagSize = 12;

    // Dessiner le circuit
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], circuitPaint);
    }
    canvas.drawLine(points.last, points.first, circuitPaint);

    // Ligne de départ
    final Offset start = points[0];
    final Offset next = points[1];
    final dx = next.dx - start.dx;
    final dy = next.dy - start.dy;
    final length = sqrt(dx * dx + dy * dy);
    final nx = -dy / length;
    final ny = dx / length;
    final startOffset1 = start + Offset(nx * 20, ny * 20);
    final startOffset2 = start - Offset(nx * 20, ny * 20);
    canvas.drawLine(startOffset1, startOffset2, startLinePaint);

    // Drapeau en damier (simple carré blanc & noir)
    final flagTopLeft = start + Offset(nx * 25, ny * 25);
    final _ = Rect.fromLTWH(flagTopLeft.dx, flagTopLeft.dy, flagSize, flagSize);

    final Paint black = Paint()..color = Colors.black;
    final Paint white = Paint()..color = Colors.white;

    // Damier 2x2 (tu peux augmenter à 4x4 si tu veux un vrai damier)
    final double cell = flagSize / 2;
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 4; j++) {
        final rect = Rect.fromLTWH(
          flagTopLeft.dx + i * cell,
          flagTopLeft.dy + j * cell,
          cell,
          cell,
        );
        canvas.drawRect(rect, (i + j) % 2 == 0 ? black : white);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}



