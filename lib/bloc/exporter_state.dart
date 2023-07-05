part of 'exporter_bloc.dart';

abstract class ExporterState extends Equatable {
  final String searchValue;
  final List<Exporter> exporters;
  const ExporterState({this.exporters = const [], required this.searchValue});

  @override
  List<Object> get props => [exporters, searchValue];
}

class ExporterInitial extends ExporterState {
  const ExporterInitial({super.exporters, required super.searchValue});
}

class ExporterSaved extends ExporterState {
  const ExporterSaved({super.exporters, required super.searchValue});
}

class ExportersLoaded extends ExporterState {
  const ExportersLoaded({super.exporters, required super.searchValue});
}

class LoadingExporters extends ExporterState {
  const LoadingExporters({super.exporters, required super.searchValue});
}

class ErrorLoadingExporters extends ExporterState {
  const ErrorLoadingExporters({super.exporters, required super.searchValue});
}

class DeletingExporter extends ExporterState {
  const DeletingExporter({required super.searchValue});
}

class DeletedExporter extends ExporterState {
  const DeletedExporter({required super.searchValue});
}
