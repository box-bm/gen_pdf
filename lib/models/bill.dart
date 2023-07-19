import 'package:gen_pdf/database/column.dart';
import 'package:gen_pdf/database/reference.dart';
import 'package:gen_pdf/database/table.dart';
import 'package:gen_pdf/database/table_interface.dart';
import 'package:gen_pdf/models/bill_item.dart';
import 'package:uuid/uuid.dart';

class Bill extends Table<Bill> implements TableInterface<Bill> {
  String id;
  DateTime? date;
  int number;
  String billNumber;
  String exporterID;
  String exporterName;
  String exporterAddress;
  String consignerID;
  String consignerName;
  String consignerAddress;
  String? consignerNIT;
  String containerNumber;
  String? termsAndConditions;
  String bl;
  List<BillItem> items;
  double total;

  Bill({
    this.id = "",
    this.date,
    this.number = 0,
    this.billNumber = "",
    this.exporterID = "",
    this.exporterName = "",
    this.exporterAddress = "",
    this.consignerID = "",
    this.consignerName = "",
    this.consignerAddress = "",
    this.consignerNIT,
    this.containerNumber = "",
    this.termsAndConditions,
    this.bl = "",
    this.items = const [],
    this.total = 0,
  });

  factory Bill.newByMap(Map<String, dynamic> values) {
    return Bill(
      id: const Uuid().v4(),
      date: values['date'],
      number: int.parse(values['number'].toString()),
      billNumber: values['billNumber'],
      exporterID: values['exporterID'],
      exporterName: values['exporterName'],
      exporterAddress: values['exporterAddress'],
      consignerID: values['consignerID'],
      consignerName: values['consignerName'],
      consignerAddress: values['consignerAddress'],
      consignerNIT: values['consignerNIT'],
      containerNumber: values['containerNumber'],
      termsAndConditions: values['termsAndConditions'],
      bl: values['bl'],
      total: values['total'],
    );
  }

  Bill.create({
    required this.id,
    required this.date,
    required this.number,
    required this.billNumber,
    required this.exporterID,
    required this.exporterName,
    required this.exporterAddress,
    required this.consignerID,
    required this.consignerName,
    required this.consignerAddress,
    required this.consignerNIT,
    required this.containerNumber,
    this.termsAndConditions,
    required this.bl,
    this.items = const [],
    this.total = 0,
  });

  @override
  Bill copyWith({
    DateTime? date,
    int? number,
    String? billNumber,
    String? exporterID,
    String? exporterName,
    String? exporterAddress,
    String? consignerID,
    String? consignerName,
    String? consignerAddress,
    String? consignerNIT,
    String? containerNumber,
    String? termsAndConditions,
    String? bl,
    List<BillItem>? items,
    double? total,
  }) {
    return Bill.create(
      id: id,
      items: items ?? this.items,
      date: date ?? this.date,
      number: number ?? this.number,
      billNumber: billNumber ?? this.billNumber,
      exporterID: exporterID ?? this.exporterID,
      exporterName: exporterName ?? this.exporterName,
      exporterAddress: exporterAddress ?? this.exporterAddress,
      consignerID: consignerID ?? this.consignerID,
      consignerName: consignerName ?? this.consignerName,
      consignerAddress: consignerAddress ?? this.consignerAddress,
      consignerNIT: consignerNIT ?? this.consignerNIT,
      containerNumber: containerNumber ?? this.containerNumber,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      bl: bl ?? this.bl,
      total: total ?? this.total,
    );
  }

  @override
  Bill fromMap(Map<String, dynamic> map) {
    return Bill.create(
        id: map['id'],
        date: map['date'] is String
            ? DateTime.tryParse(map['date'] ?? DateTime.now().toIso8601String())
            : map['date'],
        number: int.parse(map['number'].toString()),
        billNumber: map['billNumber'],
        exporterID: map['exporterID'],
        exporterName: map['exporterName'],
        exporterAddress: map['exporterAddress'],
        consignerID: map['consignerID'],
        consignerName: map['consignerName'],
        consignerAddress: map['consignerAddress'],
        consignerNIT: map['consignerNIT'],
        containerNumber: map['containerNumber'],
        termsAndConditions: map['termsAndConditions'],
        bl: map['bl'],
        total: double.parse(map['total'].toString()));
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": (date ?? DateTime.now()).toIso8601String(),
      "number": number,
      "billNumber": billNumber,
      "exporterID": exporterID,
      "exporterName": exporterName,
      "exporterAddress": exporterAddress,
      "consignerID": consignerID,
      "consignerName": consignerName,
      "consignerAddress": consignerAddress,
      "consignerNIT": consignerNIT,
      "containerNumber": containerNumber,
      "termsAndConditions": termsAndConditions,
      "bl": bl,
      "total": total,
    };
  }

  Map<String, dynamic> toListAsMap() {
    return {
      "id": id,
      "date": (date ?? DateTime.now()),
      "number": number.toString(),
      "billNumber": billNumber,
      "exporterID": exporterID,
      "exporterName": exporterName,
      "exporterAddress": exporterAddress,
      "consignerID": consignerID,
      "consignerName": consignerName,
      "consignerAddress": consignerAddress,
      "consignerNIT": consignerNIT,
      "containerNumber": containerNumber,
      "termsAndConditions": termsAndConditions,
      "bl": bl,
      "total": total,
      "items": items.map((e) => e.toMap()).toList()
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
          name: 'number',
          columnType: SQLiteDataType.integer,
          notNull: true,
        ),
        Column(
          name: 'billNumber',
          columnType: SQLiteDataType.text,
          notNull: true,
        ),
        Column(
          name: 'exporterID',
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
          name: 'consignerID',
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
          name: 'termsAndConditions',
          columnType: SQLiteDataType.text,
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
