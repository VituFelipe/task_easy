class Task {
  int? id;
  String title;
  String description;
  String assignee;
  DateTime dueDate;
  String status;

// os campos pra tarefa, e o tomap e frommap pra converserte nobanco de dados

  Task({
    this.id,
    required this.title,
    this.description = '',
    required this.assignee,
    required this.dueDate,
    this.status = 'Pendente',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'assignee': assignee,
      'dueDate': dueDate.toIso8601String(),
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      assignee: map['assignee'],
      dueDate: DateTime.parse(map['dueDate']),
      status: map['status'],
    );
  }
}