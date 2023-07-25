part of 'consigner_bloc.dart';

abstract class ConsignerState extends Equatable {
  final String searchValue;
  final List<Consigner> consigners;
  const ConsignerState({this.consigners = const [], required this.searchValue});

  @override
  List<Object> get props => [consigners, searchValue];
}

class ConsignerInitial extends ConsignerState {
  const ConsignerInitial({super.consigners, required super.searchValue});
}

class ConsignerSaved extends ConsignerState {
  const ConsignerSaved({super.consigners, required super.searchValue});
}

class ConsignersLoaded extends ConsignerState {
  const ConsignersLoaded({super.consigners, required super.searchValue});
}

class Loadingconsigners extends ConsignerState {
  const Loadingconsigners({super.consigners, required super.searchValue});
}

class ErrorLoadingconsigners extends ConsignerState {
  const ErrorLoadingconsigners({super.consigners, required super.searchValue});
}

class DeletingConsigner extends ConsignerState {
  final int quantity;
  const DeletingConsigner(this.quantity, {required super.searchValue});
}

class DeletedConsigner extends ConsignerState {
  final int quantity;
  const DeletedConsigner(this.quantity, {required super.searchValue});
}
