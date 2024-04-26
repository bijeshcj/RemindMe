import 'package:remind_me/database/database_service.dart';
import 'package:remind_me/models/todo.dart';
import 'package:sqflite/sqflite.dart';
class TodoDB{
  final tabelName = 'todos';

  Future<void> createTable(Database database) async{
    await database.execute(""" 
    CREATE TABLE IF NOT EXISTS $tabelName (
    "id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "create_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as int,
    "update_at" INTEGER,
    "todo_type" TEXT,
    PRIMARY KEY("id" AUTOINCREMENT)
    """);
  }

  Future<int> create({required String title,required String description}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tabelName (title,description,created_at) VALUES (?,?,?)''',[title,description,DateTime.now().microsecondsSinceEpoch]
    );
  }

  Future<List<ToDo>> fetchAll() async{
    final database = await DatabaseService().database;
    final todos = await database.rawQuery(
      '''SELECT * from $tabelName ORDER BY COALESCE(updated_at,created_at) '''
    );
    return todos.map((todo) => ToDo.fromSqfliteDatabase(todo)).toList();
  }

  Future<ToDo> fetchById(int id) async{
    final database = await DatabaseService().database;
    final todo = await database.rawQuery(
        '''SELECT * from $tabelName WHERE id = ?''',[id]
    );
    return ToDo.fromSqfliteDatabase(todo.first);
  }

  Future<int> update({required int id,String? title}) async{
    final database = await DatabaseService().database;
    return await database.update(tabelName, {if (title != null) 'title': title,
    'updated_at':DateTime.now().microsecondsSinceEpoch},
      where: 'id=?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id]
    );
  }

  Future<void> delete(int id) async{
    final database = await DatabaseService().database;
    await database.rawDelete(''' DELETE FROM $tabelName where id = ? ''',[id]);
  }

}