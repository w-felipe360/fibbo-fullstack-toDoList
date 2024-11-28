class ToDo {
  String id;
  String title;
  String? description;
  bool isDone;
  String priority;

  ToDo({
    required this.id,
    required this.title,
    this.description,
    this.isDone = false,
    required this.priority,
  });

  // FireStore
  factory ToDo.fromMap(Map<String, dynamic> data, String documentId) {
    return ToDo(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'],
      isDone: data['isDone'] ?? false,
      priority: data['priority'] ?? 'Média',
    );
  }
  // SharedPreferences
  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      isDone: json['isDone'] ?? false,
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'priority': priority,
    };
  }

}
