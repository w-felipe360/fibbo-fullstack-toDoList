import '../model/todo.dart';

class ToDoFilter {
  final Map<String, int> priorityOrder = {
    'Alta': 1,
    'Média': 2,
    'Baixa': 3,
  };

  List<ToDo> filterTodos(
      List<ToDo> todos,
      String? priorityFilter,
      String searchKeyword,
      String filterStatus
      ) {
    return todos
        .where((todo) {
      return _matchesPriority(todo, priorityFilter) &&
          _matchesSearch(todo, searchKeyword) &&
          _matchesStatus(todo, filterStatus);
    })
        .toList()
      ..sort((a, b) => priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!));
  }

  bool _matchesPriority(ToDo todo, String? priorityFilter) {
    if (priorityFilter == null) return true;
    return todo.priority == priorityFilter;
  }

  bool _matchesSearch(ToDo todo, String searchKeyword) {
    return todo.title.toLowerCase().contains(searchKeyword.toLowerCase());
  }

  bool _matchesStatus(ToDo todo, String filterStatus) {
    if (filterStatus == 'Todos') return true;
    if (filterStatus == 'Pendente') return !todo.isDone;
    if (filterStatus == 'Concluído') return todo.isDone;
    return false;
  }
}
