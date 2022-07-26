// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_todo_app/models/task_model.dart';

class LocalDatabase {
  final String tableTodo = 'todo';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnDescription = 'description';
  final String columnDatetime = 'dateTime';
  final String columnIconUrl = 'iconUrl';
  final String columnIsDone = 'isDone';

  static final LocalDatabase instance = LocalDatabase._init();
  LocalDatabase._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initializeDb('todos.db');

    return _database!;
  }

  Future<Database> initializeDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableTodo($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT,"
        "$columnDescription TEXT, $columnDatetime TEXT , $columnIconUrl TEXT,$columnIsDone INTEGER"
        ")");
  }

  Future<List<TaskModel>> getTasks() async {
    List<TaskModel> todoList = [];
    final db = await instance.database;

    var result = await db
        .rawQuery("SELECT * FROM $tableTodo ORDER BY $columnDatetime ASC");
    for (var element in result) {
      todoList.add(TaskModel.fromMap(element));
    }
    return todoList;
  }

  Future<int> insert(TaskModel task) async {
    final db = await instance.database;
    var result = await db.insert(tableTodo, task.toMap());
    return result;
  }

  Future<int?> update(TaskModel task) async {
    final db = await instance.database;
    return await db.update(tableTodo, task.toMap(),
        where: '$columnId= ?', whereArgs: [task.id]);
  }

  Future<int?> delete(int id) async {
    final db = await instance.database;
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }
}
