import 'package:gen_pdf/database/column.dart';
import 'package:gen_pdf/database/reference.dart';
import 'package:gen_pdf/database/table_interface.dart';
import 'package:gen_pdf/models/person.dart';
import 'package:uuid/uuid.dart';

class Exporter extends Person<Exporter> implements TableInterface<Exporter> {
  Exporter({super.id = "", super.name = "", super.address = ""});

  factory Exporter.newByMap(Map<String, dynamic> values) {
    return Exporter(
      id: const Uuid().v4(),
      name: values['name'],
      address: values['address'],
    );
  }

  Exporter.create({
    required super.id,
    required super.name,
    required super.address,
  });

  @override
  List<Column> get columns => [
        Column(
          name: 'id',
          columnType: SQLiteDataType.text,
          primaryKey: true,
          notNull: true,
        ),
        Column(
          name: 'name',
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
        Column(
          name: 'address',
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
      ];

  @override
  Exporter copyWith({
    String? name,
    String? address,
  }) {
    return Exporter.create(
      id: id,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  @override
  Exporter fromMap(Map<String, dynamic> map) {
    return Exporter.create(
      id: map['id'],
      name: map['name'],
      address: map['address'],
    );
  }

  @override
  List<Reference> get references => [];

  @override
  String get tableName => "exporters";

  static String tableName_ = "exporters";

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "address": address,
    };
  }
}
