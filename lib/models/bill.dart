import 'package:gen_pdf/database/column.dart';
import 'package:gen_pdf/database/reference.dart';
import 'package:gen_pdf/database/table.dart';
import 'package:gen_pdf/database/table_interface.dart';
import 'package:gen_pdf/models/bill_item.dart';
import 'package:uuid/uuid.dart';

class Bill extends Table<Bill> implements TableInterface<Bill> {
  String id;
  DateTime? date;
  String billNumber;
  String exporterName;
  String exporterAddress;
  String consignerName;
  String consignerAddress;
  String consignerNIT;
  String containerNumber;
  String bl;
  List<BillItem> items;
  double total;

  Bill({
    this.id = "",
    this.date,
    this.billNumber = "",
    this.exporterName = "",
    this.exporterAddress = "",
    this.consignerName = "",
    this.consignerAddress = "",
    this.consignerNIT = "",
    this.containerNumber = "",
    this.bl = "",
    this.items = const [],
    this.total = 0,
  });

  factory Bill.newByMap(Map<String, dynamic> values) {
    return Bill(
      id: const Uuid().v4(),
      date: DateTime.now(),
      billNumber: values['billNumber'],
      exporterName: values['exporterName'],
      exporterAddress: values['exporterAddress'],
      consignerName: values['consignerName'],
      consignerAddress: values['consignerAddress'],
      consignerNIT: values['consignerNIT'],
      containerNumber: values['containerNumber'],
      bl: values['bl'],
      total: values['total'],
    );
  }

  Bill.create({
    required this.id,
    this.items = const [],
    required this.date,
    required this.billNumber,
    required this.exporterName,
    required this.exporterAddress,
    required this.consignerName,
    required this.consignerAddress,
    required this.consignerNIT,
    required this.containerNumber,
    required this.bl,
    this.total = 0,
  });

  @override
  Bill copyWith({
    DateTime? date,
    String? billNumber,
    String? exporterName,
    String? exporterAddress,
    String? consignerName,
    String? consignerAddress,
    String? consignerNIT,
    String? containerNumber,
    String? bl,
    List<BillItem>? items,
    double? total,
  }) {
    return Bill.create(
      id: id,
      items: items ?? this.items,
      date: date ?? this.date,
      billNumber: billNumber ?? this.billNumber,
      exporterName: exporterName ?? this.exporterName,
      exporterAddress: exporterAddress ?? this.exporterAddress,
      consignerName: consignerName ?? this.consignerName,
      consignerAddress: consignerAddress ?? this.consignerAddress,
      consignerNIT: consignerNIT ?? this.consignerNIT,
      containerNumber: containerNumber ?? this.containerNumber,
      bl: bl ?? this.bl,
      total: total ?? this.total,
    );
  }

  @override
  Bill fromMap(Map<String, dynamic> map) {
    return Bill.create(
      id: map['id'],
      date: DateTime.tryParse(map['date'] ?? DateTime.now().toIso8601String()),
      billNumber: map['billNumber'],
      exporterName: map['exporterName'],
      exporterAddress: map['exporterAddress'],
      consignerName: map['consignerName'],
      consignerAddress: map['consignerAddress'],
      consignerNIT: map['consignerNIT'],
      containerNumber: map['containerNumber'],
      bl: map['bl'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": (date ?? DateTime.now()).toIso8601String(),
      "billNumber": billNumber,
      "exporterName": exporterName,
      "exporterAddress": exporterAddress,
      "consignerName": consignerName,
      "consignerAddress": consignerAddress,
      "consignerNIT": consignerNIT,
      "containerNumber": containerNumber,
      "bl": bl,
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
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
        Column(
          name: 'exporterName',
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
        Column(
          name: 'exporterAddress',
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
        Column(
          name: 'consignerName',
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
        Column(
          name: 'consignerAddress',
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
        Column(
          name: 'consignerNIT',
          columnType: SQLiteDataType.text,
        ),
        Column(
          name: 'containerNumber',
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
        Column(
          name: 'bl',
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
  List<Reference> get references => [];
}
