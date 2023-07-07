import 'package:gen_pdf/database/column.dart';
import 'package:gen_pdf/database/reference.dart';
import 'package:gen_pdf/database/table.dart';
import 'package:gen_pdf/database/table_interface.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:uuid/uuid.dart';

class BillItem extends Table<BillItem> implements TableInterface<BillItem> {
  String id;
  String billId;
  String numeration;
  String description;
  int quantity;
  String prs;
  double unitPrice;
  double total;

  BillItem({
    this.id = "",
    this.billId = "",
    this.numeration = "",
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
      numeration: values["numeration"],
      description: values["description"],
      quantity: (values["quantity"] as num).toInt(),
      prs: values["prs"],
      unitPrice: (values["unitPrice"] as num).toDouble(),
      total: (values["total"] as num).toDouble(),
    );
  }

  BillItem.create({
    required this.billId,
    required this.id,
    required this.numeration,
    required this.description,
    required this.quantity,
    required this.prs,
    required this.unitPrice,
    required this.total,
  });

  @override
  BillItem copyWith({
    String? numeration,
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
      numeration: numeration ?? this.numeration,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      prs: prs ?? this.prs,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
    );
  }

  @override
  BillItem fromMap(Map<String, dynamic> map) {
    return BillItem.create(
      id: map['id'],
      billId: map["billId"],
      numeration: map['numeration'],
      description: map['description'],
      quantity: map['quantity'],
      prs: map['prs'],
      unitPrice: map['unitPrice'],
      total: map['total'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "billId": billId,
      "numeration": numeration,
      "description": description,
      "quantity": quantity,
      "prs": prs,
      "unitPrice": unitPrice,
      "total": total,
    };
  }

  @override
  List<Column> get columns => [
        Column(name: "id", columnType: SQLiteDataType.text),
        Column(name: "billId", columnType: SQLiteDataType.text),
        Column(name: "numeration", columnType: SQLiteDataType.text),
        Column(name: "description", columnType: SQLiteDataType.text),
        Column(name: "quantity", columnType: SQLiteDataType.integer),
        Column(name: "prs", columnType: SQLiteDataType.text),
        Column(name: "unitPrice", columnType: SQLiteDataType.real),
        Column(name: "total", columnType: SQLiteDataType.real),
      ];

  @override
  List<Reference> get references => [
        Reference(table: Bill.tableName_, column: 'billId', remoteColumn: 'id'),
      ];

  @override
  String get tableName => "bill_items";
}
