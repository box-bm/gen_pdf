import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gen_pdf/models/consigneer.dart';

part 'consigneer_event.dart';
part 'consigneer_state.dart';

class ConsigneerBloc extends Bloc<ConsigneerEvent, ConsigneerState> {
  ConsigneerBloc() : super(const ConsigneerInitial()) {
    on<ConsigneerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
