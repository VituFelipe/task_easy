import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'task_form_screen.dart';

// Enum para as opções do menu
enum MenuOption { clearAll, exportTasks, toggleTheme }

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskEasy'),
        actions: [
          DropdownButton<String>(
            value: Provider.of<TaskProvider>(context).filterStatus,
            items: ['Todos', 'Pendente', 'Concluída']
                .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                .toList(),
            onChanged: (value) => Provider.of<TaskProvider>(context, listen: false).setFilter(value!),
          ),
          PopupMenuButton<MenuOption>(
            onSelected: (MenuOption option) {
              switch (option) {
                case MenuOption.clearAll:
                  _confirmClearAll(context);
                  break;
                case MenuOption.exportTasks:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Exportação de tarefas não implementada')),
                  );
                  break;
                case MenuOption.toggleTheme:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Alternância de tema não implementada')),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOption>>[
              PopupMenuItem<MenuOption>(
                value: MenuOption.clearAll,
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Limpar todas as tarefas'),
                  ],
                ),  
              ),
              PopupMenuItem<MenuOption>(
                value: MenuOption.exportTasks,
                child:Row(
                  children: [
                    Icon(Icons.download, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Exportar tarefas'),
                  ],
                ),
              ),
              PopupMenuItem<MenuOption>(
                value: MenuOption.toggleTheme,
                child: Text('Alternar tema'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar por título ou responsável',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                Provider.of<TaskProvider>(context, listen: false).setSearchQuery(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, provider, child) {
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskFormScreen())),
        child: Icon(Icons.add),
      ),
    );
  }

  void _confirmClearAll(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpar todas as tarefas'),
        content: Text('Tem certeza de que deseja excluir todas as tarefas? Esta ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).clearAllTasks();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Todas as tarefas foram excluídas')),
              );
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    );
  }
}