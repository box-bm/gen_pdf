part of 'exporter_bloc.dart';

abstract class ExporterEvent extends Equatable {
  const ExporterEvent();

  @override
  List<Object> get props => [];
}

class CreateExporter extends ExporterEvent {
  final Map<String, dynamic> values;

  const CreateExporter(this.values);
}

class EditExporter extends ExporterEvent {
  final Map<String, dynamic> values;

  const EditExporter(this.values);
}

class GetAllExporters extends ExporterEvent {
  const GetAllExporters();
}
