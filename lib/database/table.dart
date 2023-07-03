import 'package:gen_pdf/database/column.dart';
import 'package:gen_pdf/database/database_provider.dart';
import 'package:gen_pdf/database/reference.dart';
import 'package:sqflite/sqflite.dart';

class Table<T> {
  final DatabaseProvider databaseProvider = DatabaseProvider();

  String get tableName => "";
  List<Column> get columns => [];
  List<Reference> get references => [];

  String get primaryKey => columns.first.name;
  String createTableString() {
    String createStr = '';
    createStr = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      ${columns.map((e) {
      return '${e.name} ${e.stringColumnType} ${e.notNullString}';
    }).join(', ')}
      ''';

    if (references.isNotEmpty) {
      createStr += ''', 
      ${references.map((e) {
        return '${e.referenceString} ';
      }).join(', ')}      
      ''';
    }
    return '$createStr)';
  }

  Future<Database> getDB() async => await databaseProvider.db;

  Future<List<T>> getAll() async {
    var db = await getDB();
    List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (index) {
      return fromMap(maps[index]);
    });
  }

  Future<T> getByID(dynamic id) async {
    var db = await getDB();
    var pk = columns.firstWhere((element) => element.primaryKey).name;
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: "$pk = ?",
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      throw Exception("Object does'n find");
    }

    return fromMap(maps[0]);
  }

  Future<int> insert() async {
    var db = await getDB();

    var result = await db.insert(
      tableName,
      toMap(),
    );

    return result;
  }

  Future<int> update(dynamic id) async {
    var db = await getDB();
    var pk = columns.firstWhere((element) => element.primaryKey).name;

    var result = await db.update(
      tableName,
      toMap(),
      where: "$pk = ?",
      whereArgs: [id],
    );
    return result;
  }

  Future<int> delete(dynamic id) async {
    var db = await getDB();
    var pk = columns.firstWhere((element) => element.primaryKey).name;

    var result = await db.delete(
      tableName,
      where: "$pk = ?",
      whereArgs: [id],
    );
    return result;
  }

  T copyWith() {
    throw UnimplementedError();
  }

  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }

  T fromMap(Map<String, dynamic> map) {
    throw UnimplementedError();
  }
}
