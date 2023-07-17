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

/// The PreviewPDF class represents an event to preview a PDF with a given ID.
class PreviewPDF extends BillsEvent {
  final String id;

  const PreviewPDF(this.id);
}

class GenerateBillDocuments extends BillsEvent {
  final String id;

  const GenerateBillDocuments(this.id);
}

class GenerateBill extends BillsEvent {
  final String id;

  const GenerateBill(this.id);
}

class GeneratePrice extends BillsEvent {
  final String id;

  const GeneratePrice(this.id);
}

class GenerateConfirmation extends BillsEvent {
  final String id;

  const GenerateConfirmation(this.id);
}

class GenerateAgreement extends BillsEvent {
  final String id;

  const GenerateAgreement(this.id);
}

class GenerateExplanatoryNote extends BillsEvent {
  final String id;

  const GenerateExplanatoryNote(this.id);
}

class GenerateAllBillsDocuments extends BillsEvent {
  final List<String> ids;

  const GenerateAllBillsDocuments(this.ids);
}
