import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:task_easy/providers/task_provider.dart';
import 'package:task_easy/screens/task_list_screen.dart';

void main() {
  testWidgets('TaskListScreen displays no tasks message', (WidgetTester tester) async {
    // Configura o Provider
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TaskProvider(),
        child: MaterialApp(
          home: TaskListScreen(),
        ),
      ),
    );

    // Verifica se a mensagem "Nenhuma tarefa cadastrada" aparece
    expect(find.text('Nenhuma tarefa cadastrada'), findsOneWidget);


  });
}