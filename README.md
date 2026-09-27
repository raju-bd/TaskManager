# Task Manager — Provider State Management Demo

A small Flutter app built to demonstrate `Provider` state management:
`ChangeNotifier`, `ChangeNotifierProvider`, `Consumer`, `context.watch()`,
and `context.read()`. No `setState()` is used anywhere for task data.

## Features

- View all tasks in a scrollable list
- Add a task (title + optional description) via a dialog
- Mark a task complete/incomplete with a checkbox
- Delete a task (with a confirm step)
- Live stats: total / completed / pending, always in sync with the list
- Friendly empty-state when there are no tasks yet

## Project structure

```
lib/
  main.dart                     # App entry point, wraps app in ChangeNotifierProvider
  models/
    task.dart                   # Task data class
  providers/
    task_provider.dart          # TaskProvider (ChangeNotifier) — all task logic lives here
  screens/
    home_screen.dart            # Main screen: stats + list + FAB
  widgets/
    task_tile.dart              # Single task row (checkbox + delete)
    task_stats.dart             # Total/Completed/Pending strip
    add_task_dialog.dart        # "Add Task" form dialog
```

## How Provider is used

- **`TaskProvider extends ChangeNotifier`** holds the task list privately
  and calls `notifyListeners()` after every add/toggle/delete.
- **`ChangeNotifierProvider`** in `main.dart` creates the single
  `TaskProvider` instance for the app.
- **`context.watch<TaskProvider>()`** is used in `HomeScreen.build()` and
  inside a `Consumer<TaskProvider>` in `TaskStats`, so the UI rebuilds
  automatically whenever state changes.
- **`context.read<TaskProvider>()`** is used inside callbacks (checkbox
  toggle, delete, add task submit) to perform actions without
  subscribing to rebuilds.

## Getting started

```bash
flutter pub get
flutter run
```

## Git history

The project was built incrementally, commit by commit:

1. Initial project setup
2. Add Task model
3. Add TaskProvider (ChangeNotifier)
4. Add task list and stats widgets
5. Add AddTaskDialog and HomeScreen
6. Wire up ChangeNotifierProvider in main.dart
