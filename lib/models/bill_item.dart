import 'package:gen_pdf/database/column.dart';
import 'package:gen_pdf/database/reference.dart';
import 'package:gen_pdf/database/table.dart';
import 'package:gen_pdf/database/table_interface.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:uuid/uuid.dart';

class BillItem extends Table<BillItem> implements TableInterface<BillItem> {
  String id;
  String billId;
  String description;
  int quantity;
  String? prs;
  double unitPrice;
  double total;

  BillItem({
    this.id = "",
    this.billId = "",
    this.description = "",
    this.quantity = 0,
    this.prs = "",
    this.unitPrice = 0,
    this.total = 0,
  });

  factory BillItem.newByMap(Map<String, dynamic> values) {
    return BillItem(
      id: const Uuid().v4(),
      billId: values["billId"] ?? "",
      description: values["description"],
      quantity: int.parse(values["quantity"]),
      prs: values["prs"],
      unitPrice: double.parse(values["unitPrice"]),
      total: values["total"],
    );
  }

  BillItem.create({
    required this.billId,
    required this.id,
    required this.description,
    required this.quantity,
    required this.prs,
    required this.unitPrice,
    required this.total,
  });

  @override
  BillItem copyWith({
    String? billId,
    String? description,
    int? quantity,
    String? prs,
    double? unitPrice,
    double? total,
  }) {
    return BillItem.create(
      id: id,
      billId: billId ?? this.billId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      prs: prs ?? this.prs ?? "",
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
    );
  }

  @override
  BillItem fromMap(Map<String, dynamic> map) {
    return BillItem.create(
      id: map['id'],
      billId: map["billId"],
      description: map['description'],
      quantity: map['quantity'],
      prs: map['prs'] ?? "",
      unitPrice: map['unitPrice'],
      total: map['total'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "billId": billId,
      "description": description,
      "quantity": quantity,
      "prs": prs,
      "unitPrice": unitPrice,
      "total": total,
    };
  }

  @override
  List<Column> get columns => [
        Column(name: "id", columnType: SQLiteDataType.text, primaryKey: true),
        Column(name: "billId", columnType: SQLiteDataType.text),
        Column(
            name: "description",
            columnType: SQLiteDataType.text,
            notNull: true),
        Column(
            name: "quantity",
            columnType: SQLiteDataType.integer,
            notNull: true),
        Column(name: "prs", columnType: SQLiteDataType.text),
        Column(
            name: "unitPrice", columnType: SQLiteDataType.real, notNull: true),
        Column(name: "total", columnType: SQLiteDataType.real, notNull: true),
      ];

  @override
  List<Reference> get references => [
        Reference(table: Bill.tableName_, column: 'billId', remoteColumn: 'id'),
      ];

  @override
  String get tableName => "bill_items";
}
