import 'package:flutter/material.dart';

class EditModal extends StatefulWidget {
  final String initialTitle;
  final String? initialDescription;
  final String initialPriority;
  final Function(String, String?, String) onSave;

  const EditModal({
    super.key,
    required this.initialTitle,
    this.initialDescription,
    required this.initialPriority,
    required this.onSave,
  });

  @override
  State<EditModal> createState() => _EditModalState();
}

class _EditModalState extends State<EditModal> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String _selectedPriority = 'Média';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController =
        TextEditingController(text: widget.initialDescription ?? '');
    _selectedPriority = widget.initialPriority;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Tarefa'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Nome da Tarefa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição (opcional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Prioridade'),
            DropdownButton<String>(
              value: _selectedPriority,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value!;
                });
              },
              items: ['Alta', 'Média', 'Baixa']
                  .map(
                    (priority) => DropdownMenuItem(
                  value: priority,
                  child: Text(priority),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _titleController.text.isEmpty
              ? null
              : () {
            widget.onSave(
              _titleController.text,
              _descriptionController.text.isEmpty
                  ? null
                  : _descriptionController.text,
              _selectedPriority,
            );
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
