import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/database_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task>? _tasks;
  String _filterStatus = 'Todos';
  String _searchQuery = '';

  List<Task> get tasks {
    var filteredTasks = _tasks ?? [];
    if (_filterStatus != 'Todos') {
      filteredTasks = filteredTasks.where((task) => task.status == _filterStatus).toList();
    }
    if (_searchQuery.isNotEmpty) {
      filteredTasks = filteredTasks
          .where((task) =>
              task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              task.assignee.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return filteredTasks;
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

  Future<void> clearAllTasks() async {
    await DatabaseService().clearAllTasks();
    await loadTasks();
  }

  void setFilter(String status) {
    _filterStatus = status;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}