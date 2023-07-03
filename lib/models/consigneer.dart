import 'package:gen_pdf/database/column.dart';
import 'package:gen_pdf/database/reference.dart';
import 'package:gen_pdf/database/table_interface.dart';
import 'package:gen_pdf/models/person.dart';

class Consigneer extends Person implements TableInterface<Consigneer> {
  late String nit;

  Consigneer({
    super.id = "",
    super.name = "",
    super.address = "",
  });

  Consigneer.create({
    required super.id,
    required super.name,
    required super.address,
    required this.nit,
  });

  @override
  List<Column> get columns => [
        Column(
            name: 'id',
            columnType: SQLiteDataType.text,
            primaryKey: true,
            notNull: true),
        Column(name: 'name', columnType: SQLiteDataType.text, notNull: true),
        Column(name: 'address', columnType: SQLiteDataType.text, notNull: true),
        Column(name: 'nit', columnType: SQLiteDataType.text, notNull: true)
      ];

  @override
  Consigneer copyWith({
    String? name,
    String? address,
    String? nit,
  }) {
    return Consigneer.create(
      id: id,
      name: name ?? this.name,
      address: address ?? this.address,
      nit: nit ?? this.nit,
    );
  }

  @override
  Consigneer fromMap(Map<String, dynamic> map) {
    return Consigneer.create(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      nit: map['nit'],
    );
  }

  @override
  List<Reference> get references => [];

  @override
  String get tableName => "consigneers";
  static String tableName_ = "consigneers";

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "nit": nit,
    };
  }
}
