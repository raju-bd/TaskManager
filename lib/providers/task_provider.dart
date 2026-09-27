import 'package:flutter/foundation.dart';
import '../models/task.dart';

// This is the heart of the app's state management. Every screen
// and widget that cares about tasks listens to this class instead
// of holding its own local state — that's what lets us update the
// task list, the checkbox, and the stats section all at once from
// a single source of truth, with zero setState() calls for task
// data anywhere in the UI layer.
class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  // Expose an unmodifiable view so nothing outside this class can
  // sneak in a mutation without going through notifyListeners().
  List<Task> get tasks => List.unmodifiable(_tasks);

  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((task) => task.isCompleted).length;
  int get pendingTasks => totalTasks - completedTasks;

  bool get hasTasks => _tasks.isNotEmpty;

  // Adds a new task to the top of the list so it's immediately
  // visible without the user having to scroll.
  void addTask(String title, String description) {
    final newTask = Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title.trim(),
      description: description.trim(),
    );
    _tasks.insert(0, newTask);
    notifyListeners();
  }

  // Flips a task between completed and incomplete. We look it up
  // by id rather than passing the whole object around, so callers
  // (like a Checkbox's onChanged) only need to know the id.
  void toggleTaskCompletion(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index == -1) return; // task no longer exists, nothing to do

    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
