import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gen_pdf/models/exporter.dart';
import 'package:gen_pdf/repository/exporters_repository.dart';

part 'exporter_event.dart';
part 'exporter_state.dart';

class ExporterBloc extends Bloc<ExporterEvent, ExporterState> {
  ExporterRepository exporterRepository = ExporterRepository();

  ExporterBloc() : super(const ExporterInitial(searchValue: "")) {
    on<Filter>((event, emit) {
      emit(ExportersLoaded(searchValue: event.value));
      add(const GetAllExporters());
    });
    on<GetAllExporters>((event, emit) async {
      emit(LoadingExporters(searchValue: state.searchValue));
      var exporters = await exporterRepository.getExporters();

      if (state.searchValue.isNotEmpty) {
        var searchCriteria = state.searchValue.toLowerCase();
        exporters = exporters
            .where((element) =>
                element.address.toLowerCase().contains(searchCriteria) ||
                element.name.toLowerCase().contains(searchCriteria))
            .toList();
      }

      emit(ExportersLoaded(
          exporters: exporters, searchValue: state.searchValue));
    });
    on<CreateExporter>((event, emit) async {
      await exporterRepository.createExporter(event.values);
      emit(ExporterSaved(searchValue: state.searchValue));
      add(const GetAllExporters());
    });
    on<EditExporter>((event, emit) async {
      await exporterRepository.updateExporter(event.values);
      emit(ExporterSaved(searchValue: state.searchValue));
      add(const GetAllExporters());
    });
    on<DeleteExporter>((event, emit) async {
      await exporterRepository.deleteExporter(event.id);
      emit(DeletedExporter(searchValue: state.searchValue));
      add(const GetAllExporters());
    });
    on<DeleteExporters>((event, emit) async {
      emit(DeletingExporter(searchValue: state.searchValue));
      for (var id in event.ids) {
        await exporterRepository.deleteExporter(id);
      }
      emit(DeletedExporter(searchValue: state.searchValue));
      add(const GetAllExporters());
    });
  }
}
