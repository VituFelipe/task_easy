import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'task_form_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskEasy'),
        actions: [
          DropdownButton<String>(
            value: Provider.of<TaskProvider>(context).filterStatus,
            items: ['Todos', 'Pendente', 'Concluída'].map((status) => DropdownMenuItem(value: status, child: Text(status))).toList(),
            onChanged: (value) => Provider.of<TaskProvider>(context, listen: false).setFilter(value!),
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          provider.loadTasks();
          return provider.tasks.isEmpty
              ? Center(child: Text('Nenhuma tarefa cadastrada'))
              : ListView.builder(
                  itemCount: provider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = provider.tasks[index];
                    return ListTile(
                      title: Text(task.title),
                      subtitle: Text(
                          'Responsável: ${task.assignee}\nVencimento: ${DateFormat('dd/MM/yyyy').format(task.dueDate)}\nStatus: ${task.status}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => TaskFormScreen(task: task)),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id!);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskFormScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}