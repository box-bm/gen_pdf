import 'package:gen_pdf/database/column.dart';
import 'package:gen_pdf/database/reference.dart';

abstract class TableInterface<T> {
  String get tableName;
  List<Column> get columns;
  List<Reference> get references;
  Map<String, dynamic> toMap();
  T fromMap(Map<String, dynamic> map);
  T copyWith();
}
