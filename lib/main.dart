import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Adiciona o parâmetro key ao construtor pra chave do widget

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        title: 'TaskEasy',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TaskListScreen(),
      ),
    );
  }
}