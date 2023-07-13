import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/models/bill_item.dart';
import 'package:gen_pdf/repository/bill_item_repository.dart';
import 'package:gen_pdf/repository/bill_repository.dart';
import 'package:gen_pdf/utils/document_templates/confirmation.dart';
import 'package:gen_pdf/utils/document_templates/note.dart';
import 'package:gen_pdf/utils/document_templates/price.dart';
import 'package:gen_pdf/utils/file_picker.dart';
import 'package:gen_pdf/utils/document_templates/bill.dart';
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

    // Document Generation
    on<PreviewPDF>((event, emit) async {
      Bill bill = await getAllBillDetails(event.id);

      var doc = await generateBillPDF(bill);
      emit(PrintReady(doc, event.id,
          searchValue: state.searchValue, bills: state.bills));
      emit(BillsLoaded(searchValue: state.searchValue, bills: state.bills));
    });

    on<GenerateBillDocuments>((event, emit) async {
      var folder = await chooseFolderToSaveFiles();

      if (folder == null) {
        return;
      }
      await prinAllDocuments(event.id, folder);
    });

    on<GenerateBill>((event, emit) async {
      var path = await chooseFolderToSaveFile();

      if (path == null) {
        return;
      }
      var bill = await getAllBillDetails(event.id);
      var document = await generateBillPDF(bill);
      await saveFilesWithPath(document, path);
    });
    on<GeneratePrice>((event, emit) async {
      var path = await chooseFolderToSaveFile();

      if (path == null) {
        return;
      }
      var bill = await getAllBillDetails(event.id);
      var document = await generatePricePDF(bill);
      await saveFilesWithPath(document, path);
    });
    on<GenerateConfirmation>((event, emit) async {
      var path = await chooseFolderToSaveFile();

      if (path == null) {
        return;
      }
      var bill = await getAllBillDetails(event.id);
      var document = await generateConfirmationPDF(bill);
      await saveFilesWithPath(document, path);
    });
    on<GenerateNote>((event, emit) async {
      var path = await chooseFolderToSaveFile();

      if (path == null) {
        return;
      }
      var bill = await getAllBillDetails(event.id);
      var document = await generateNotePDF(bill);
      await saveFilesWithPath(document, path);
    });

    on<GenerateAllBillsDocuments>((event, emit) async {
      var folder = await FileManager().chooseDirectoryPath(
          dialogTitle: "Seleccione la ubicacion para guardar");

      if (folder != null) {
        List<Future> savedBills = [];

        for (var id in event.ids) {
          savedBills.add(prinAllDocuments(id, folder));
        }
        await Future.wait(savedBills);
      }
    });
  }

  Future prinAllDocuments(String id, String folder) async {
    Bill bill = await getAllBillDetails(id);

    await Future.value([
      generateBillPDF(bill)
          .then((value) => saveFiles(value, "Factura-$id", folder)),
      generatePricePDF(bill)
          .then((value) => saveFiles(value, "Cotizacion-$id", folder)),
      generateConfirmationPDF(bill)
          .then((value) => saveFiles(value, "Confirmacion-$id", folder)),
      generateNotePDF(bill)
          .then((value) => saveFiles(value, "Nota-$id", folder)),
    ]);
  }

  Future<Bill> getAllBillDetails(String id) async {
    Bill bill = await billRepository.getByID(id);
    List<BillItem> items = await billItemRepository.getAllBillItemsByBillID(id);
    bill.items = items;
    return bill;
  }

  Future<void> saveFiles(Document document, String name, String folder) async {
    File file = File("$folder/$name.pdf");
    await file.writeAsBytes(await document.save());
  }

  Future<void> saveFilesWithPath(Document document, String path) async {
    File file = File(path);
    await file.writeAsBytes(await document.save());
  }

  Future<String?> chooseFolderToSaveFiles(
      {String dialog = "Seleccione la ubicacion para guardar"}) async {
    return await FileManager().chooseDirectoryPath(dialogTitle: dialog);
  }

  Future<String?> chooseFolderToSaveFile(
      {String dialog = "Seleccione la ubicacion para guardar",
      String defaultName = "document"}) async {
    return await FileManager().saveFile(
        fileName: "$defaultName.pdf",
        allowedExtensions: ['.pdf'],
        dialogTitle: dialog);
  }
}
