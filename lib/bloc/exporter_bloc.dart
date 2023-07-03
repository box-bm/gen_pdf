import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gen_pdf/models/exporter.dart';
import 'package:gen_pdf/repository/exporters_repository.dart';

part 'exporter_event.dart';
part 'exporter_state.dart';

class ExporterBloc extends Bloc<ExporterEvent, ExporterState> {
  ExporterRepository exporterRepository = ExporterRepository();

  ExporterBloc() : super(const ExporterInitial()) {
    on<GetAllExporters>((event, emit) async {
      emit(const LoadingExporters());
      emit(ExportersLoaded(exporters: await exporterRepository.getExporters()));
    });
    on<CreateExporter>((event, emit) async {
      await exporterRepository.createExporter(event.values);
      emit(const ExporterSaved());
      add(const GetAllExporters());
    });
    on<EditExporter>((event, emit) async {
      await exporterRepository.updateExporter(event.values);
      emit(const ExporterSaved());
      add(const GetAllExporters());
    });
  }
}
