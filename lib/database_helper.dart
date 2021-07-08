import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/task.dart';
import 'models/todo.dart';


class DatabaseHelper {

  Future<Database> database() async {
    final database = openDatabase(

      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,   title TEXT, description TEXT)',);
        await db.execute('CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT,   name TEXT, isDone INTEGER, taskId INTEGER)',);
      },
      version: 1,
    );
    return database;
  }

  Future<int> insertTask(Task task) async {
    int taskId = 0;

    Database _db = await database();
    await _db.insert('tasks', task.insertMap(), conflictAlgorithm: ConflictAlgorithm.replace).then((value) {
      taskId = value;
    });
    return taskId;
  }

  Future<void> updateTaskDesc(Task task) async {
    // Get a reference to the database.
    final db = await database();

    // Update the given Dog.
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
  Future<int> insertTodo(Todo todo) async {
    int taskId = 0;

    Database _db = await database();
    await _db.insert('todo', todo.insertMap(), conflictAlgorithm: ConflictAlgorithm.replace).then((value) {
      taskId = value;
    });
    return taskId;
  }
  // A method that retrieves all the dogs from the dogs table.
  Future<List<Task>> tasks() async {
    // Get a reference to the database.
    final db = await database();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
      );
    });
  }
  // A method that retrieves all the dogs from the dogs table.
  Future<Task> taskById(int id) async {


    // Get a reference to the database.
    final db = await database();

    String where_cond = "id = ${id}";

    var result  = await db.query('tasks' , where: where_cond);
    Map map = result.first;
    Task task = Task(id: map["id"],title: map["title"],description: map["description"]);
    return task;
  }
  Future<Todo> todoById(int id) async {


    // Get a reference to the database.
    final db = await database();

    String where_cond = "id = ${id}";

    var result  = await db.query('todo' , where: where_cond);
    Map map = result.first;
    Todo todo = Todo(id: map["id"],name:map["name"],taskId: map["taskId"],isDone: map["isDone"]);
    return todo;
  }
  // A method that retrieves all the dogs from the dogs table.
  Future<List<Todo>> todos(int id) async {
    // Get a reference to the database.
    final db = await database();
    String where_cond = "taskId = ${id}";
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('todo',where: where_cond);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        name: maps[i]['name'],
        taskId: maps[i]['taskId'],
        isDone: maps[i]['isDone'],
      );
    });
  }
  Future<void> updateTodo(Todo todo) async {
    // Get a reference to the database.
    final db = await database();

    // Update the given Dog.
    await db.update(
      'todo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }
  Future<void> deleteTask(int id) async {
    // Get a reference to the database.
    final db = await database();

    // Remove the Dog from the database.
    await db.delete(
      'tasks',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

}