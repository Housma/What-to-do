class Task{
  late final int id;
  late final String title;
  late final String description;

  Task ({int id = 0 , String title = "" , String description = "" }) {

    this.id = id;
    this.title = title;
    this.description = description;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
  Map<String, dynamic> insertMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description}';
  }
  Task.fromMap(Map<String, dynamic> map): id = map['id'],title = map['title'],description = map['description'];
}