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

class DeleteExporter extends ExporterEvent {
  final String id;

  const DeleteExporter(this.id);
}

class DeleteExporters extends ExporterEvent {
  final List<String> ids;

  const DeleteExporters(this.ids);
}

class GetAllExporters extends ExporterEvent {
  const GetAllExporters();
}

class Filter extends ExporterEvent {
  final String value;

  const Filter(this.value);
}
