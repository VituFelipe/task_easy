import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/database_service.dart';

// gerenciar a lista de tarefas, e o set pra tentar implementar filtrar pro status
// tenho que corrigir o codigo ainda

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  String _filterStatus = 'Todos';

  List<Task> get tasks {
    if (_filterStatus == 'Todos') return _tasks;
    return _tasks.where((task) => task.status == _filterStatus).toList();
  }

  String get filterStatus => _filterStatus;

  Future<void> loadTasks() async {
    _tasks = await DatabaseService().getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await DatabaseService().insertTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await DatabaseService().updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await DatabaseService().deleteTask(id);
    await loadTasks();
  }

  void setFilter(String status) {
    _filterStatus = status;
    notifyListeners();
  }
}