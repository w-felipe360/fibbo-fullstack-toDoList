import 'package:flutter/material.dart';
import '../screens/details_screen.dart';
import '../screens/edit_modal.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final VoidCallback onDelete;
  final Function(String, String?, String) onEdit;
  final VoidCallback onToggleDone;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: const Color(0xFF5F52EE),
          ),
          onPressed: onToggleDone,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 16,
            color: todo.isDone ? const Color(0xFFB0B0B0) : const Color(0xFF3A3A3A),
            decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
            decorationColor: todo.isDone ? const Color(0xFFB0B0B0) : Colors.transparent,
            decorationThickness: 2,
          ),
        ),
        trailing: Wrap(
          spacing: 8,
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: const Color(0xFFDA4040),
                  borderRadius: BorderRadius.circular(5)),
              child: IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete),
                color: Colors.white,
                iconSize: 18,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: const Color(0xFF5F52EE),
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                onPressed: () => _openEditModal(context),
                icon: const Icon(Icons.edit),
                color: Colors.white,
                iconSize: 18,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                title: todo.title,
                description: todo.description,
                priority: todo.priority,
              ),
            ),
          );
        },
      ),
    );
  }

  void _openEditModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return EditModal(
          initialTitle: todo.title,
          initialDescription: todo.description,
          initialPriority: todo.priority,
          onSave: (newTitle, newDescription, newPriority) {
            onEdit(newTitle, newDescription, newPriority);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
