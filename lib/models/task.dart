// Simple data class for a single to-do item.
//
// Kept deliberately plain — no business logic lives here, that's
// the provider's job. This class is just a container for the
// fields we care about, plus a tiny helper to flip completion
// status without mutating fields directly from outside.
class Task {
  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String description;
  bool isCompleted;

  // Returns a new Task with completion flipped, rather than
  // mutating in place. Not strictly required since we mutate
  // in the provider anyway, but it reads nicer at call sites
  // if we ever want to treat Task as immutable later.
  Task copyWith({String? title, String? description, bool? isCompleted}) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
