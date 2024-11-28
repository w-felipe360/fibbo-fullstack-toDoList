import 'package:flutter/material.dart';
import '../model/todo.dart';

class HomeModalAdd extends StatefulWidget {
  final Function(ToDo) onAddTask;

  const HomeModalAdd({super.key, required this.onAddTask});

  @override
  State<HomeModalAdd> createState() => _HomeModalAddState();
}

class _HomeModalAddState extends State<HomeModalAdd> {
  final _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  String? _selectedPriority = 'Baixa';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Adicionar Tarefa',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _taskNameController,
              decoration: const InputDecoration(
                labelText: 'Nome da Tarefa',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'O nome da tarefa é obrigatório.';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _taskDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição da Tarefa (Opcional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Prioridade',
                border: OutlineInputBorder(),
              ),
              value: _selectedPriority,
              items: const [
                DropdownMenuItem(
                  value: 'Alta',
                  child: Text('Alta'),
                ),
                DropdownMenuItem(
                  value: 'Média',
                  child: Text('Média'),
                ),
                DropdownMenuItem(
                  value: 'Baixa',
                  child: Text('Baixa'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'A prioridade é obrigatória.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newTask = ToDo(
                    id: DateTime.now().toString(),
                    title: _taskNameController.text,
                    description: _taskDescriptionController.text,
                    isDone: false,
                    priority: _selectedPriority ?? 'Baixa',
                  );
                  widget.onAddTask(newTask);
                  Navigator.pop(context);
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }
}
