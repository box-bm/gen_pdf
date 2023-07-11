part of 'bills_bloc.dart';

abstract class BillsState extends Equatable {
  final String searchValue;
  final List<Bill> bills;
  const BillsState({required this.searchValue, this.bills = const []});

  @override
  List<Object> get props => [];
}

class BillsInitial extends BillsState {
  const BillsInitial({super.bills, super.searchValue = ""});
}

class BillSaved extends BillsState {
  const BillSaved({super.bills, required super.searchValue});
}

class BillsLoaded extends BillsState {
  const BillsLoaded({super.bills, required super.searchValue});
}

class LoadingBills extends BillsState {
  const LoadingBills({super.bills, required super.searchValue});
}

class ErrorLoadingBills extends BillsState {
  const ErrorLoadingBills({super.bills, required super.searchValue});
}

class DeletingBill extends BillsState {
  const DeletingBill({required super.searchValue});
}

class DeletedBill extends BillsState {
  const DeletedBill({required super.searchValue});
}

class PrintReady extends BillsState {
  final Document document;
  final String id;
  const PrintReady(this.document, this.id,
      {required super.searchValue, super.bills});
}

class FindedNewBillNumber extends BillsState {
  final int? newBillNumber;
  final DateTime? dateTime;
  const FindedNewBillNumber(this.newBillNumber, this.dateTime,
      {super.bills, super.searchValue = ""});
}
