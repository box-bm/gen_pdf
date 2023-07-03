import 'package:gen_pdf/database/column.dart';
import 'package:gen_pdf/database/reference.dart';
import 'package:gen_pdf/database/table.dart';
import 'package:gen_pdf/database/table_interface.dart';
import 'package:gen_pdf/models/bill.dart';

class BillItem extends Table<BillItem> implements TableInterface<BillItem> {
  late String id;
  late String billId;
  late int numeration;
  late String description;
  late int quantity;
  late String prs;
  late double unitPrice;
  late double total;

  BillItem();

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
    int? numeration,
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
        Column(name: "billID", columnType: SQLiteDataType.text),
        Column(name: "numeration", columnType: SQLiteDataType.text),
        Column(name: "description", columnType: SQLiteDataType.text),
        Column(name: "quantity", columnType: SQLiteDataType.text),
        Column(name: "prs", columnType: SQLiteDataType.text),
        Column(name: "unitPrice", columnType: SQLiteDataType.text),
        Column(name: "total", columnType: SQLiteDataType.text),
      ];

  @override
  List<Reference> get references => [
        Reference(table: Bill.tableName_, column: 'billID', remoteColumn: 'id'),
      ];

  @override
  String get tableName => "bill_items";
}
