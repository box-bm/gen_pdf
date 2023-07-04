part of 'exporter_bloc.dart';

abstract class ExporterState extends Equatable {
  final List<Exporter> exporters;
  const ExporterState({this.exporters = const []});

  @override
  List<Object> get props => [exporters];
}

class ExporterInitial extends ExporterState {
  const ExporterInitial({super.exporters});
}

class ExporterSaved extends ExporterState {
  const ExporterSaved({super.exporters});
}

class ExportersLoaded extends ExporterState {
  const ExportersLoaded({super.exporters});
}

class LoadingExporters extends ExporterState {
  const LoadingExporters({super.exporters});
}

class ErrorLoadingExporters extends ExporterState {
  const ErrorLoadingExporters({super.exporters});
}

class DeletingExporter extends ExporterState {
  const DeletingExporter();
}

class DeletedExporter extends ExporterState {
  const DeletedExporter();
}
