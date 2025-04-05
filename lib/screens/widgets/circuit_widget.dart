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
  @override
  _CircuitWidgetState createState() => _CircuitWidgetState();
}

class _CircuitWidgetState extends State<CircuitWidget> {
  // Points du circuit (plus détaillés)
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
    "Départ : point de départ du circuit.", // Moi
    "Arrêt 1 : zone technique.", // Parcours scolaire
    "Arrêt 2 : point de contrôle.", // Centres d'intérêts
    "Arrêt 3 : ravitaillement.",
    "Arrivée : fin du circuit.", // objectifs
  ];

  // Points où le personnage doit s'arrêter
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
        // Partie gauche : Circuit + bouton
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
                  width: 20, // Largeur ajustée
                  height: 20,
                  child: Image.asset("assets/icons/casque.png", color: Colors.white),
                ),
              ),

              Positioned(
                bottom: 20,
                right: 20,
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
          flex: 1, // Moitié de l'écran
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
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
                          // Légère translation depuis la droite
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    stopDescriptions[currentStopIndex],
                    key: ValueKey<int>(currentStopIndex),
                    // Clé différente pour chaque texte
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



