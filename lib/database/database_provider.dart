import 'package:gen_pdf/database/table.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/models/bill_item.dart';
import 'package:gen_pdf/models/consigner.dart';
import 'package:gen_pdf/models/exporter.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

List<Table> tables = [Exporter(), Consigner(), Bill(), BillItem()];

class DatabaseProvider {
  static final dbProvider = DatabaseProvider();
  static const String databaseName = 'systempdf.db';

  Database? database;

  Future<String> getDatabaseLocation() async {
    return p.join('.', databaseName);
  }

  Future<Database> get db async {
    if (database != null) {
      return database!;
    }
    database = await createDatabase();
    return database!;
  }

  Future<void> dropDatabase() async {
    await deleteDatabase(await getDatabaseLocation());
  }

  Future<void> deleteData() async {}

  Future<Database> opendb() async {
    var database = await openDatabase(
      await getDatabaseLocation(),
      version: 1,
    );
    this.database = database;
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

    this.database = database;
    return database;
  }

  Future<void> createTables(Database db) async {
    for (Table table in tables) {
      await db.execute(table.createTableString());
    }
  }
}
