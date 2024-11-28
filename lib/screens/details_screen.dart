import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String? description;
  final String priority;

  const DetailsScreen({
    super.key,
    required this.title,
    this.description,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Tarefa'),
        backgroundColor: const Color(0xFF5F52EE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Título:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Descrição:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description != null && description!.isNotEmpty
                  ? description!
                  : 'Sem descrição',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Prioridade:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              priority,
              style: TextStyle(
                fontSize: 16,
                color: priority == 'Alta'
                    ? Colors.red
                    : (priority == 'Média' ? Colors.orange : Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
