part of 'consigneer_bloc.dart';

abstract class ConsigneerState extends Equatable {
  final String searchValue;
  final List<Consigneer> consigners;
  const ConsigneerState(
      {this.consigners = const [], required this.searchValue});

  @override
  List<Object> get props => [consigners, searchValue];
}

class ConsigneerInitial extends ConsigneerState {
  const ConsigneerInitial({super.consigners, required super.searchValue});
}

class ConsignerSaved extends ConsigneerState {
  const ConsignerSaved({super.consigners, required super.searchValue});
}

class ConsignersLoaded extends ConsigneerState {
  const ConsignersLoaded({super.consigners, required super.searchValue});
}

class Loadingconsigners extends ConsigneerState {
  const Loadingconsigners({super.consigners, required super.searchValue});
}

class ErrorLoadingconsigners extends ConsigneerState {
  const ErrorLoadingconsigners({super.consigners, required super.searchValue});
}

class DeletingConsigner extends ConsigneerState {
  const DeletingConsigner({required super.searchValue});
}

class DeletedConsigner extends ConsigneerState {
  const DeletedConsigner({required super.searchValue});
}
