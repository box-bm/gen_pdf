enum SQLiteDataType {
  text,
  integer,
  real,
  currency,
  date,
}

class Column {
  String name;
  SQLiteDataType columnType;
  bool primaryKey;
  bool notNull;

  Column(
      {required this.name,
      required this.columnType,
      this.primaryKey = false,
      this.notNull = false});

  String get stringColumnType {
    String returnType = "";
    switch (columnType) {
      case SQLiteDataType.date:
        returnType = "TEXT";
        break;
      case SQLiteDataType.text:
        returnType = "TEXT";
        break;
      case SQLiteDataType.integer:
        returnType = "INTEGER";
        break;
      case SQLiteDataType.real:
        returnType = "REAL";
        break;
      case SQLiteDataType.currency:
        returnType = "REAL";
        break;
    }
    if (primaryKey) {
      returnType += " PRIMARY KEY NOT NULL";
    }
    return returnType;
  }

  String get notNullString {
    return (notNull) ? ' NOT NULL ' : ' ';
  }

  Object value(Object value) {
    switch (columnType) {
      case SQLiteDataType.date:
        return DateTime.parse(value as String);
      case SQLiteDataType.text:
        return (value as String);
      case SQLiteDataType.integer:
        return (value as int);
      case SQLiteDataType.real:
        return (value as double);
      case SQLiteDataType.currency:
        return (value as double);
    }
  }
}
