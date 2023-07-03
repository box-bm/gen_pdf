part of 'consigneer_bloc.dart';

abstract class ConsigneerState extends Equatable {
  final List<Consigneer> consigners;
  const ConsigneerState({this.consigners = const []});

  @override
  List<Object> get props => [];
}

class ConsigneerInitial extends ConsigneerState {
  const ConsigneerInitial({super.consigners});
}

class ConsignerSaved extends ConsigneerState {
  const ConsignerSaved({super.consigners});
}

class ConsignersLoaded extends ConsigneerState {
  const ConsignersLoaded({super.consigners});
}

class Loadingconsigners extends ConsigneerState {
  const Loadingconsigners({super.consigners});
}

class ErrorLoadingconsigners extends ConsigneerState {
  const ErrorLoadingconsigners({super.consigners});
}
