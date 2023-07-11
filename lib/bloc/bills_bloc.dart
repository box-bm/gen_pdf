import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/models/bill_item.dart';
import 'package:gen_pdf/repository/bill_item_repository.dart';
import 'package:gen_pdf/repository/bill_repository.dart';
import 'package:gen_pdf/utils/file_picker.dart';
import 'package:gen_pdf/utils/gen_test_pdf.dart';
import 'package:pdf/widgets.dart';

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
                (element.consignerNIT ?? "")
                    .toLowerCase()
                    .contains(searchCriteria) ||
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

      for (var bill in bills) {
        var items = await billItemRepository.getAllBillItemsByBillID(bill.id);
        bill.items = items;
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

      for (var item in values['items']) {
        item['billId'] = bill.id;
      }
      await billItemRepository.createBillItems(values['items']);

      emit(BillSaved(searchValue: state.searchValue));
      add(const GetAllBills());
    });
    on<EditBill>((event, emit) async {
      var values = {...event.values};
      var billItems = (values['items'] as List<dynamic>? ?? []);

      double total = billItems.isEmpty
          ? 0
          : billItems
              .map((e) => e['total'])
              .toList()
              .reduce((value, element) => value + element);

      values['total'] = total;

      await billRepository.updateBill(values);
      await billItemRepository.deleteBillItemsByBillID(event.values['id']);
      for (var item in values['items']) {
        item['billId'] = event.values['id'];
      }
      await billItemRepository.createBillItems(values['items']);

      emit(BillSaved(searchValue: state.searchValue));
      add(const GetAllBills());
    });
    on<DeleteBill>((event, emit) async {
      await Future.wait([
        billRepository.deleteBill(event.id),
        billItemRepository.deleteBillItemsByBillID(event.id)
      ]);
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

    on<FindNewBillNumber>((event, emit) async {
      List<Bill> bills = [];
      int newBillNumber = 0;

      if (event.date != null) {
        bills = await billRepository.getBills();
        bills = bills
            .where((element) => element.date!.isAtSameMomentAs(event.date!))
            .toList();
      }

      if (bills.map((e) => e.id).contains(event.id)) {
        newBillNumber =
            bills.firstWhere((element) => element.id == event.id).number;
      } else {
        newBillNumber =
            bills.isEmpty ? 0 : bills.map((e) => e.number).reduce(max);

        newBillNumber++;
      }

      emit(FindedNewBillNumber(newBillNumber, event.date,
          bills: state.bills, searchValue: state.searchValue));
      emit(BillsLoaded(searchValue: state.searchValue, bills: state.bills));
    });

    on<PrintBill>((event, emit) async {
      Bill bill = await billRepository.getByID(event.id);
      List<BillItem> items =
          await billItemRepository.getAllBillItemsByBillID(event.id);
      bill.items = items;

      var doc = await genPDF(bill);
      await savePDF(doc, defaultName: event.id);
    });

    on<PreviewPDF>((event, emit) async {
      Bill bill = await billRepository.getByID(event.id);
      List<BillItem> items =
          await billItemRepository.getAllBillItemsByBillID(event.id);
      bill.items = items;

      var doc = await genPDF(bill);
      emit(PrintReady(doc, event.id,
          searchValue: state.searchValue, bills: state.bills));
      emit(BillsLoaded(searchValue: state.searchValue, bills: state.bills));
    });
    on<PrintBills>((event, emit) async {
      var folder = await FileManager().chooseDirectoryPath(
          dialogTitle: "Seleccione la ubicacion para guardar");

      if (folder != null) {
        List<Future> savedBills = [];

        for (var id in event.ids) {
          Bill bill = await billRepository.getByID(id);
          List<BillItem> items =
              await billItemRepository.getAllBillItemsByBillID(id);

          bill.items = items;
          savedBills.add(genFile(bill, folder));
        }
        await Future.wait(savedBills);
      }
    });
  }
}

Future<void> genFile(Bill bill, String folder) async {
  var doc = await genPDF(bill);
  File file = File("$folder/${bill.id}.pdf");
  await file.writeAsBytes(await doc.save());
}
