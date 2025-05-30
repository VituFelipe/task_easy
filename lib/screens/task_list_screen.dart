import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path; // Import com alias para evitar conflito
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart';
import '../services/database_service.dart';
import 'task_form_screen.dart';

// Enum para as opções do menu
enum MenuOption { clearAll, exportTasks, toggleTheme }

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  late AnimationController _animationController; // Controlador para o FAB

  @override
  void initState() {
    super.initState();
    // Inicializar o AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat(reverse: true);
    // Carregar tarefas
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose(); // Descartar o AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskEasy'),
        actions: [
          DropdownButton<String>(
            value: Provider.of<TaskProvider>(context).filterStatus,
            items: ['Todos', 'Pendente', 'Concluída']
                .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                .toList(),
            onChanged: (value) => Provider.of<TaskProvider>(context, listen: false).setFilter(value!),
          ),
          PopupMenuButton<MenuOption>(
            icon: const Icon(Icons.person), // Ícone explícito
            onSelected: (MenuOption option) async {
              switch (option) {
                case MenuOption.clearAll:
                  _confirmClearAll(context);
                  break;
                case MenuOption.exportTasks:
                  try {
                    final json = await DatabaseService().exportTasksToJson();
                    final dir = await getApplicationDocumentsDirectory();
                    final file = File(path.join(dir.path, 'tasks_export_${DateTime.now().millisecondsSinceEpoch}.json'));
                    await file.writeAsString(json);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tarefas exportadas para ${file.path}')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro ao exportar tarefas: $e')),
                    );
                  }
                  break;
                case MenuOption.toggleTheme:
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tema alterado')),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOption>>[
              const PopupMenuItem<MenuOption>(
                value: MenuOption.clearAll,
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Limpar todas as tarefas'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<MenuOption>(
                value: MenuOption.exportTasks,
                child: Row(
                  children: [
                    Icon(Icons.file_download, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Exportar tarefas'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<MenuOption>(
                value: MenuOption.toggleTheme,
                child: Row(
                  children: [
                    Icon(Icons.brightness_6, color: Colors.purple),
                    SizedBox(width: 8),
                    Text('Alternar tema'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar por título ou responsável',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          Provider.of<TaskProvider>(context, listen: false).setSearchQuery('');
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                Provider.of<TaskProvider>(context, listen: false).setSearchQuery(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, provider, child) {
                final tasks = provider.tasks ?? [];
                return tasks.isEmpty
                    ? const Center(child: Text('Nenhuma tarefa cadastrada'))
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: ListTile(
                              title: Text(
                                task.title,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: [
                                    TextSpan(text: 'Responsável: ${task.assignee}\n'),
                                    TextSpan(text: 'Vencimento: ${DateFormat('dd/MM/yyyy').format(task.dueDate)}\n'),
                                    TextSpan(
                                      text: 'Status: ${task.status}',
                                      style: TextStyle(
                                        color: task.status == 'Concluída' ? Colors.green : Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              leading: Icon(
                                task.status == 'Concluída' ? Icons.check_circle : Icons.pending,
                                color: task.status == 'Concluída' ? Colors.green : Colors.orange,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => TaskFormScreen(task: task)),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: Tween(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskFormScreen())),
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  void _confirmClearAll(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text('Limpar todas as tarefas'),
          ],
        ),
        content: const Text('Tem certeza de que deseja excluir todas as tarefas? Esta ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).clearAllTasks();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Todas as tarefas foram excluídas')),
              );
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}