import 'package:gen_pdf/database/column.dart';
import 'package:gen_pdf/database/reference.dart';
import 'package:gen_pdf/database/table.dart';
import 'package:gen_pdf/database/table_interface.dart';
import 'package:gen_pdf/models/bill_item.dart';
import 'package:gen_pdf/models/consigneer.dart';
import 'package:gen_pdf/models/exporter.dart';

class Bill extends Table<Bill> implements TableInterface<Bill> {
  late String id;
  late DateTime date;
  late int billNumber;
  late String exporterID;
  late Exporter? exporter;
  late String consigneerID;
  late Consigneer? consigneer;
  late int containerNumber;
  late String bl;
  late String termsAndConditions;
  late List<BillItem> items;
  late double total;

  Bill();

  Bill.create({
    required this.id,
    required this.items,
    required this.date,
    required this.billNumber,
    required this.exporterID,
    this.exporter,
    required this.consigneerID,
    this.consigneer,
    required this.containerNumber,
    required this.bl,
    required this.termsAndConditions,
    this.total = 0,
  });

  @override
  Bill copyWith({
    DateTime? date,
    int? billNumber,
    Exporter? exporter,
    Consigneer? consigneer,
    int? containerNumber,
    String? bl,
    String? termsAndConditions,
    List<BillItem>? items,
    double? total,
  }) {
    return Bill.create(
      id: id,
      items: items ?? this.items,
      date: date ?? this.date,
      billNumber: billNumber ?? this.billNumber,
      consigneerID: consigneer?.id ?? consigneerID,
      exporterID: exporter?.id ?? exporterID,
      exporter: exporter ?? this.exporter,
      consigneer: consigneer ?? this.consigneer,
      containerNumber: containerNumber ?? this.containerNumber,
      bl: bl ?? this.bl,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      total: total ?? this.total,
    );
  }

  @override
  Bill fromMap(Map<String, dynamic> map) {
    return Bill.create(
      id: map['id'],
      items: [],
      date: map['date'],
      billNumber: map['billNumber'],
      consigneerID: map['consigneerID'],
      exporterID: map['exporterID'],
      containerNumber: map['containerNumber'],
      bl: map['bl'],
      termsAndConditions: map['termsAndConditions'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date,
      "billNumber": billNumber,
      "consigneerID": consigneerID,
      "exporterID": exporterID,
      "containerNumber": containerNumber,
      "bl": bl,
      "termsAndConditions": termsAndConditions,
      "total": total,
    };
  }

  @override
  String get tableName => "bills";

  static String tableName_ = "bills";

  @override
  List<Column> get columns => [
        Column(
          name: 'id',
          columnType: SQLiteDataType.text,
          primaryKey: true,
          notNull: true,
        ),
        Column(
          name: 'date',
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
        Column(
          name: 'billNumber',
          columnType: SQLiteDataType.integer,
          notNull: true,
        ),
        Column(
          name: 'exporterID',
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
        Column(
          name: 'consigneerID',
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
        Column(
          name: 'containerNumber',
          columnType: SQLiteDataType.integer,
          notNull: true,
        ),
        Column(
          name: 'bl',
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
        Column(
          name: 'termsAndConditions',
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
        Column(
          name: 'total',
          columnType: SQLiteDataType.real,
          notNull: true,
        ),
      ];

  @override
  List<Reference> get references => [
        Reference(
            table: Consigneer.tableName_,
            column: "consigneerID",
            remoteColumn: "id"),
        Reference(
            table: Exporter.tableName_,
            column: "exporterID",
            remoteColumn: "id")
      ];
}
