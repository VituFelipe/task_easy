import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:task_easy/models/task.dart';
import 'package:task_easy/providers/task_provider.dart';
import 'package:task_easy/screens/task_list_screen.dart';

void main() {
  testWidgets('TaskListScreen exports tasks to JSON', (WidgetTester tester) async {
    final taskProvider = TaskProvider();
    await taskProvider.addTask(Task(
      title: 'Test Task',
      assignee: 'Test User',
      dueDate: DateTime.now(),
      status: 'Pendente',
    ));

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => taskProvider),
        ],
        child: const MaterialApp(
          home: TaskListScreen(),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Exportar tarefas'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Tarefas exportadas'), findsOneWidget);
  });
}