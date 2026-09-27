import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_stats.dart';
import '../widgets/task_tile.dart';
import '../widgets/add_task_dialog.dart';

// Main (and only) screen of the app. Brings together the stats
// strip, the scrollable task list, and the FAB for adding new
// tasks. Everything task-related here is read through
// context.watch<TaskProvider>() so this widget rebuilds whenever
// the list changes — no local state to manage.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch() subscribes this build method to changes, which is
    // exactly what we want at the top of the screen — when a task
    // is added or removed, this rebuilds and ListView.builder picks
    // up the new list automatically.
    final taskProvider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const TaskStats(),
          const SizedBox(height: 4),
          Expanded(
            child: taskProvider.hasTasks
                ? ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) {
                      final task = taskProvider.tasks[index];
                      // Keying by task id keeps Flutter's element tree
                      // stable across add/delete/reorder operations.
                      return TaskTile(key: ValueKey(task.id), task: task);
                    },
                  )
                : const _EmptyState(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const AddTaskDialog(),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
    );
  }
}

// Friendly placeholder for the "nothing here yet" state, so the
// screen doesn't just look broken when the list is empty.
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.checklist_rtl, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            'No tasks yet',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          Text(
            'Tap "Add Task" to create your first one',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
