import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/todo.dart';

class StorageService {
  SharedPreferences? sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<List<ToDo>> getTodoList() async {
    final String? jsonString = sharedPreferences?.getString('todo_list');
    if (jsonString != null) {
      final List<dynamic> jsonDecoded = json.decode(jsonString);
      return jsonDecoded.map((e) => ToDo.fromJson(e)).toList();
    } else {
      return await _loadTodosFromFirestore();
    }
  }
  Future<List<ToDo>> _loadTodosFromFirestore() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('todos').get();
    return snapshot.docs.map((doc) {
      return ToDo.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
  Future<void> saveToDoList(List<ToDo> todos) async {
    final List<Map<String, dynamic>> todoMaps = todos.map((todo) => todo.toMap()).toList();
    final String jsonString = json.encode(todoMaps);
    await sharedPreferences!.setString('todo_list', jsonString);
    for (var todo in todos) {
      await FirebaseFirestore.instance.collection('todos').doc(todo.id).set(todo.toMap());
    }
  }
  Future<void> removeToDo(String todoId, List<ToDo> todos) async {
      todos.removeWhere((todo) => todo.id == todoId);
      await FirebaseFirestore.instance.collection('todos').doc(todoId).delete();
      await saveToDoList(todos);
  }
}
