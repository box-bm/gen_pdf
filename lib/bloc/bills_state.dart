part of 'bills_bloc.dart';

abstract class BillsState extends Equatable {
  const BillsState();
  
  @override
  List<Object> get props => [];
}

class BillsInitial extends BillsState {}
