import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gen_pdf/models/consigneer.dart';
import 'package:gen_pdf/repository/consigner_repository.dart';

part 'consigneer_event.dart';
part 'consigneer_state.dart';

class ConsigneerBloc extends Bloc<ConsigneerEvent, ConsigneerState> {
  ConsignerRepository consignerRepository = ConsignerRepository();

  ConsigneerBloc() : super(const ConsigneerInitial()) {
    on<GetAllConsigners>((event, emit) async {
      emit(const Loadingconsigners());
      emit(ConsignersLoaded(
          consigners: await consignerRepository.getConsigners()));
    });
    on<CreateConsigner>((event, emit) async {
      await consignerRepository.createconsigner(event.values);
      emit(const ConsignerSaved());
      add(const GetAllConsigners());
    });
    on<EditConsigner>((event, emit) async {
      await consignerRepository.updateConsigner(event.values);
      emit(const ConsignerSaved());
      add(const GetAllConsigners());
    });
    on<DeleteConsigner>((event, emit) async {
      await consignerRepository.deleteConsigner(event.id);
      emit(const DeletingConsigner());
      add(const GetAllConsigners());
    });
    on<DeleteConsigners>((event, emit) async {
      emit(const DeletingConsigner());
      for (var id in event.ids) {
        await consignerRepository.deleteConsigner(id);
      }
      emit(const DeletedConsigner());
      add(const GetAllConsigners());
    });
  }
}
