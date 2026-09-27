import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

// Small stats strip shown above the task list. Uses a Consumer
// (rather than context.watch in build) just to show the other
// common way of listening to a provider — it rebuilds only this
// widget subtree whenever TaskProvider calls notifyListeners().
class TaskStats extends StatelessWidget {
  const TaskStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Container(
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatItem(label: 'Total', value: taskProvider.totalTasks),
              _divider(),
              _StatItem(label: 'Completed', value: taskProvider.completedTasks),
              _divider(),
              _StatItem(label: 'Pending', value: taskProvider.pendingTasks),
            ],
          ),
        );
      },
    );
  }

  Widget _divider() => Container(width: 1, height: 32, color: Colors.black12);
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}
