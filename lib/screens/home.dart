import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../services/storage_service.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';
import '../widgets/todo_item.dart';
import 'home_modal_add.dart';
import '../model/todo.dart';
import '../widgets/search_box.dart';
import '../widgets/priority_buttons.dart';
import '../utils/todo_filter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final StorageService storageService = StorageService();
  final ToDoFilter toDoFilter = ToDoFilter();
  List<ToDo> todos = [];
  String? _priorityFilter;
  String _searchKeyword = '';
  String _filterStatus = 'Todos';

  @override
  void initState() {
    super.initState();
    _initializeAndLoadTodos();
  }

  Future<void> _initializeAndLoadTodos() async {
    await storageService.init();
    final loadedTodos = await storageService.getTodoList();
    setState(() {
      todos = loadedTodos;
    });
  }

  void _addNewTask(ToDo newTask) {
    setState(() {
      todos.add(newTask);
    });
    storageService.saveToDoList(todos);
  }

  List<ToDo> get filteredTodos {
    return toDoFilter.filterTodos(
      todos,
      _priorityFilter,
      _searchKeyword,
      _filterStatus,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      appBar: CustomAppBar(onMenuPressed: () {
        Scaffold.of(context).openDrawer();
      }),
      drawer: DrawerWidget(
        onFilterStatusChanged: (status) {
          setState(() {
            _filterStatus = status;
          });
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            SearchBox(
              onChanged: (enteredKeyword) {
                setState(() {
                  _searchKeyword = enteredKeyword;
                });
              },
            ),
            const SizedBox(height: 10),
            PriorityButtons(
              selectedPriority: _priorityFilter,
              onSelectPriority: (priority) {
                setState(() {
                  _priorityFilter =
                      (_priorityFilter == priority) ? null : priority;
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTodos.length,
                itemBuilder: (context, index) {
                  return ToDoItem(
                    todo: filteredTodos[index],
                    onDelete: () async {
                      setState(() {
                        filteredTodos.removeAt(index);
                      });
                      final todoToRemove = filteredTodos[index];
                      await storageService.removeToDo(todoToRemove.id, todos);
                    },
                    onEdit: (String newTitle, String? newDescription,
                        String newPriority) {
                      setState(() {
                        final todoIndex = todos.indexWhere(
                            (todo) => todo.id == filteredTodos[index].id);
                        if (todoIndex != -1) {
                          todos[todoIndex] = ToDo(
                            id: todos[todoIndex].id,
                            title: newTitle,
                            description: newDescription,
                            isDone: todos[todoIndex].isDone,
                            priority: newPriority,
                          );
                          storageService.saveToDoList(todos);
                        }
                      });
                    },
                    onToggleDone: () {
                      setState(() {
                        final todoIndex = todos.indexWhere(
                            (todo) => todo.id == filteredTodos[index].id);
                          todos[todoIndex] = ToDo(
                            id: todos[todoIndex].id,
                            title: todos[todoIndex].title,
                            description: todos[todoIndex].description,
                            isDone: !todos[todoIndex].isDone,
                            priority: todos[todoIndex].priority,
                          );
                          storageService.saveToDoList(todos);
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBarModalBottomSheet(
            context: context,
            builder: (context) => HomeModalAdd(
              onAddTask: _addNewTask,
            ),
          );
        },
        backgroundColor: const Color(0xFF3A3A3A),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
