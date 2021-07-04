class Todo{
  late final int id;
  late final String name;
  late  int isDone;
  late final int taskId;

  Todo ({int id = 0 , String name = "" , int isDone = 0, int taskId = 0 }) {

    this.id = id;
    this.name = name;
    this.isDone = isDone;
    this.taskId = taskId;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isDone': isDone,
      'taskId': taskId,
    };
  }
  Map<String, dynamic> insertMap() {
    return {
      'name': name,
      'isDone': isDone,
      'taskId': taskId,
    };
  }

  @override
  String toString() {
    return 'Task{id: $id, name: $name, isDone: $isDone, taskId: $taskId}';
  }
}