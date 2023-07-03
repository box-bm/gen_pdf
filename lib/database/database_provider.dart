import 'package:flutter/foundation.dart';
import 'package:gen_pdf/database/table.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/models/bill_item.dart';
import 'package:gen_pdf/models/consigneer.dart';
import 'package:gen_pdf/models/exporter.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

List<Table> tables = [Exporter(), Consigneer(), Bill(), BillItem()];

class DatabaseProvider {
  static const String _databaseName = 'systempdf.db';

  Database? _database;

  Future<String> getDatabaseLocation() async {
    if (kDebugMode) {
      return join('./', _databaseName);
    }
    return join(await getDatabasesPath(), _databaseName);
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }
    _database = await createDatabase();
    return _database!;
  }

  Future<void> dropDatabase() async {
    await deleteDatabase(await getDatabaseLocation());
  }

  Future<Database> opendb() async {
    var database = await openDatabase(
      await getDatabaseLocation(),
      version: 1,
    );
    _database = database;
    return database;
  }

  Future<Database> createDatabase() async {
    var factory = databaseFactoryFfi;
    var database = await factory.openDatabase(await getDatabaseLocation(),
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) {
            createTables(db);
          },
        ));

    _database = database;
    return database;
  }

  Future<void> createTables(Database db) async {
    for (Table table in tables) {
      await db.execute(table.createTableString());
    }
  }
}
