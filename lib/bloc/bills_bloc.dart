import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bills_event.dart';
part 'bills_state.dart';

class BillsBloc extends Bloc<BillsEvent, BillsState> {
  BillsBloc() : super(BillsInitial()) {
    on<BillsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
