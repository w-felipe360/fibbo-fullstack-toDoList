import 'package:flutter/material.dart';

class PriorityButtons extends StatelessWidget {
  final String? selectedPriority;
  final Function(String) onSelectPriority;

  const PriorityButtons({
    super.key,
    required this.selectedPriority,
    required this.onSelectPriority,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPriorityButton('Alta', Colors.red),
        _buildPriorityButton('Média', Colors.yellow),
        _buildPriorityButton('Baixa', Colors.green),
      ],
    );
  }

  Widget _buildPriorityButton(String priority, Color color) {
    return ElevatedButton(
      onPressed: () => onSelectPriority(priority),
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedPriority == priority ? color : Colors.grey[300],
      ),
      child: Text(priority),
    );
  }
}
