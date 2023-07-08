import 'package:gen_pdf/models/bill.dart';

class BillRepository {
  Future<Bill> createBill(Map<String, dynamic> values) async {
    Bill bill = Bill.newByMap(values);
    await bill.insert();
    return bill;
  }

  Future<Bill> updateBill(Map<String, dynamic> values) async {
    Bill updatedBill = Bill().fromMap(values);
    updatedBill.update(values['id']);
    return updatedBill;
  }

  Future deleteBill(String id) async {
    await Bill().delete(id);
  }

  Future<List<Bill>> getBills() async {
    Bill bill = Bill();
    return await bill.getAll();
  }

  Future<Bill> getByID(String id) async {
    return await Bill().getByID(id);
  }
}
