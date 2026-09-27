import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

// One row in the task list. This widget itself doesn't hold any
// state — it just renders a Task and reads the provider (via
// context.read) whenever the user taps something, so the actual
// mutation happens in one place.
class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) {
            // context.read() is used here (not watch) because we're
            // inside a callback, not the build method — we just want
            // to fire the action, not subscribe to rebuilds.
            context.read<TaskProvider>().toggleTaskCompletion(task.id);
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            color: task.isCompleted ? Colors.grey : null,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: task.description.isEmpty
            ? null
            : Text(
                task.description,
                style: TextStyle(
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                  color: task.isCompleted ? Colors.grey : Colors.black87,
                ),
              ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          tooltip: 'Delete task',
          onPressed: () => _confirmDelete(context),
        ),
      ),
    );
  }

  // A quick confirmation dialog so a stray tap doesn't wipe out a
  // task the user actually wanted to keep.
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete task?'),
        content: Text('"${task.title}" will be removed permanently.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<TaskProvider>().deleteTask(task.id);
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
