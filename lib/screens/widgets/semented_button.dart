import 'package:flutter/material.dart';

class SegmentedButtonWidget extends StatefulWidget {
  final Function(int) onCategoryChanged;

  const SegmentedButtonWidget({super.key, required this.onCategoryChanged});

  @override
  SegmentedButtonWidgetState createState() => SegmentedButtonWidgetState();
}

class SegmentedButtonWidgetState extends State<SegmentedButtonWidget> {
  int _selectedIndex = 0;
  final List<String> _options = [
    'Langages',
    'Frameworks',
    'Interfaces',
    'Bases de données',
    'Outils',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      // Réduction de l'espace
      child: SizedBox(
        width: double.infinity, // Permet de prendre toute la largeur disponible
        child: SegmentedButton<int>(
          selectedIcon: Image.asset(
            "assets/icons/drapeau.png",
            width: 24,
            height: 24,
          ),
          segments: List.generate(
            _options.length,
            (index) =>
                ButtonSegment(value: index, label: Text(_options[index])),
          ),
          selected: {_selectedIndex},
          onSelectionChanged: (newSelection) {
            setState(() {
              _selectedIndex = newSelection.first;
              widget.onCategoryChanged(_selectedIndex);
            });
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Theme.of(context).colorScheme.primaryContainer;
              }
              return Theme.of(context).colorScheme.surfaceContainerHighest;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Theme.of(context).colorScheme.onPrimaryContainer;
              }
              return Theme.of(context).colorScheme.onSecondaryContainer;
            }),
          ),
        ),
      ),
    );
  }
}
