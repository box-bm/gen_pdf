import 'package:gen_pdf/database/downgrade/v2.dart';
import 'package:gen_pdf/database/table.dart';
import 'package:gen_pdf/database/upgrade/v2.dart';
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
    var factory = databaseFactoryFfi;
    var database = await factory.openDatabase(await getDatabaseLocation(),
        options: OpenDatabaseOptions(version: 2));
    this.database = database;
    return database;
  }

  Future<Database> createDatabase() async {
    var factory = databaseFactoryFfi;
    var database = await factory.openDatabase(await getDatabaseLocation(),
        options: OpenDatabaseOptions(
          version: 2,
          onCreate: (db, version) {
            createTables(db);
          },
          onDowngrade: (db, oldVersion, newVersion) async {
            if (oldVersion == 2 && newVersion == 1) {
              await db.execute(downgradeV2);
            }
          },
          onUpgrade: (db, oldVersion, newVersion) async {
            if (oldVersion == 1 && newVersion == 2) {
              await db.execute(upgradeV2);
            }
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
