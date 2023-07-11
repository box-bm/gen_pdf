part of 'bills_bloc.dart';

abstract class BillsEvent extends Equatable {
  const BillsEvent();

  @override
  List<Object> get props => [];
}

class CreateBill extends BillsEvent {
  final Map<String, dynamic> values;

  const CreateBill(this.values);
}

class EditBill extends BillsEvent {
  final Map<String, dynamic> values;

  const EditBill(this.values);
}

class DeleteBill extends BillsEvent {
  final String id;

  const DeleteBill(this.id);
}

class DeleteBills extends BillsEvent {
  final List<String> ids;

  const DeleteBills(this.ids);
}

class GetAllBills extends BillsEvent {
  const GetAllBills();
}

class Filter extends BillsEvent {
  final String value;

  const Filter(this.value);
}

class FindNewBillNumber extends BillsEvent {
  final DateTime? date;
  final String? id;

  const FindNewBillNumber(this.date, this.id);
}

class PrintBill extends BillsEvent {
  final String id;

  const PrintBill(this.id);
}

class PreviewPDF extends BillsEvent {
  final String id;

  const PreviewPDF(this.id);
}

class PrintBills extends BillsEvent {
  final List<String> ids;

  const PrintBills(this.ids);
}
