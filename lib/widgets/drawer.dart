import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final Function(String) onFilterStatusChanged;

  const DrawerWidget({Key? key, required this.onFilterStatusChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: const Text('Todos'),
            onTap: () {
              onFilterStatusChanged('Todos');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Pendente'),
            onTap: () {
              onFilterStatusChanged('Pendente');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Concluído'),
            onTap: () {
              onFilterStatusChanged('Concluído');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
