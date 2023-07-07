import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/repository/bill_item_repository.dart';
import 'package:gen_pdf/repository/bill_repository.dart';

part 'bills_event.dart';
part 'bills_state.dart';

class BillsBloc extends Bloc<BillsEvent, BillsState> {
  BillRepository billRepository = BillRepository();
  BillItemRepository billItemRepository = BillItemRepository();

  BillsBloc() : super(const BillsInitial()) {
    on<Filter>((event, emit) {
      emit(BillsLoaded(searchValue: event.value));
      add(const GetAllBills());
    });
    on<GetAllBills>((event, emit) async {
      emit(LoadingBills(searchValue: state.searchValue));
      var bills = await billRepository.getBills();

      if (state.searchValue.isNotEmpty) {
        var searchCriteria = state.searchValue.toLowerCase();
        bills = bills
            .where((element) =>
                element.billNumber.toLowerCase().contains(searchCriteria) ||
                element.bl.toLowerCase().contains(searchCriteria) ||
                element.consignerAddress
                    .toLowerCase()
                    .contains(searchCriteria) ||
                element.consignerNIT.toLowerCase().contains(searchCriteria) ||
                element.consignerName.toLowerCase().contains(searchCriteria) ||
                element.containerNumber
                    .toLowerCase()
                    .contains(searchCriteria) ||
                element.exporterAddress
                    .toLowerCase()
                    .contains(searchCriteria) ||
                element.exporterName.toLowerCase().contains(searchCriteria))
            .toList();
      }
      emit(BillsLoaded(bills: bills, searchValue: state.searchValue));
    });
    on<CreateBill>((event, emit) async {
      var values = {...event.values};
      var billItems = (values['items'] as List<dynamic>? ?? []);

      double total = billItems.isEmpty
          ? 0
          : billItems
              .map((e) => e['total'])
              .toList()
              .reduce((value, element) => value + element);
      values.addAll({'total': total});

      var bill = await billRepository.createBill(values);

      for (var item in values['items'] as List<Map<String, dynamic>>) {
        item['billId'] = bill.id;
      }
      await billItemRepository.createBillItems(values['items']);

      emit(BillSaved(searchValue: state.searchValue));
      add(const GetAllBills());
    });
    on<EditBill>((event, emit) async {
      add(DeleteBill(event.values['id']));
      add(CreateBill(event.values));

      emit(BillSaved(searchValue: state.searchValue));
      add(const GetAllBills());
    });
    on<DeleteBill>((event, emit) async {
      await billRepository.deleteBill(event.id);
      await billItemRepository.deleteBillItemsByBillID(event.id);
      emit(DeletingBill(searchValue: state.searchValue));
      add(const GetAllBills());
    });
    on<DeleteBills>((event, emit) async {
      emit(DeletingBill(searchValue: state.searchValue));
      for (var id in event.ids) {
        await billRepository.deleteBill(id);
        await billItemRepository.deleteBillItemsByBillID(id);
      }
      emit(DeletedBill(searchValue: state.searchValue));
      add(const GetAllBills());
    });
  }
}
