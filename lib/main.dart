import 'package:flutter/material.dart';

// Entry point of the app. We'll wire up Provider in a later commit —
// for now this just gets a basic MaterialApp on screen so we have
// something runnable to build on top of.
void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(child: Text('Task Manager — coming together...')),
      ),
    );
  }
}
