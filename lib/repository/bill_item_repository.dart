import 'package:gen_pdf/models/bill_item.dart';

class BillItemRepository {
  Future<BillItem> createBillItem(Map<String, dynamic> values) async {
    BillItem bill = BillItem.newByMap(values);
    await bill.insert();
    return bill;
  }

  Future createBillItems(List<Map<String, dynamic>> values) async {
    var billitem = BillItem();
    var db = await billitem.databaseProvider.db;
    var batch = db.batch();

    for (var item in values) {
      BillItem bill = BillItem.newByMap(item);
      batch.insert(billitem.tableName, bill.toMap());
    }

    await batch.commit();
  }

  Future<BillItem> updateBillItem(Map<String, dynamic> values) async {
    BillItem updatedBillItem = BillItem().fromMap(values);
    updatedBillItem.update(values['id']);
    return updatedBillItem;
  }

  Future deleteBillItem(String id) async {
    await BillItem().delete(id);
  }

  Future<List<BillItem>> getBillItems() async {
    BillItem bill = BillItem();
    return await bill.getAll();
  }
}
