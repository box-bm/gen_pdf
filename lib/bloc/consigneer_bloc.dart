import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gen_pdf/models/consigneer.dart';
import 'package:gen_pdf/repository/consigner_repository.dart';

part 'consigneer_event.dart';
part 'consigneer_state.dart';

class ConsigneerBloc extends Bloc<ConsigneerEvent, ConsigneerState> {
  ConsignerRepository consignerRepository = ConsignerRepository();

  ConsigneerBloc() : super(const ConsigneerInitial(searchValue: "")) {
    on<Filter>((event, emit) {
      emit(ConsignersLoaded(searchValue: event.value));
      add(const GetAllConsigners());
    });
    on<GetAllConsigners>((event, emit) async {
      emit(Loadingconsigners(searchValue: state.searchValue));
      var consigneers = await consignerRepository.getConsigners();

      if (state.searchValue.isNotEmpty) {
        var searchCriteria = state.searchValue.toLowerCase();
        consigneers = consigneers
            .where((element) =>
                (element.nit ?? "").toLowerCase().contains(searchCriteria) ||
                element.address.toLowerCase().contains(searchCriteria) ||
                element.name.toLowerCase().contains(searchCriteria))
            .toList();
      }
      emit(ConsignersLoaded(
          consigners: consigneers, searchValue: state.searchValue));
    });
    on<CreateConsigner>((event, emit) async {
      await consignerRepository.createconsigner(event.values);
      emit(ConsignerSaved(searchValue: state.searchValue));
      add(const GetAllConsigners());
    });
    on<EditConsigner>((event, emit) async {
      await consignerRepository.updateConsigner(event.values);
      emit(ConsignerSaved(searchValue: state.searchValue));
      add(const GetAllConsigners());
    });
    on<DeleteConsigner>((event, emit) async {
      await consignerRepository.deleteConsigner(event.id);
      emit(DeletingConsigner(searchValue: state.searchValue));
      add(const GetAllConsigners());
    });
    on<DeleteConsigners>((event, emit) async {
      emit(DeletingConsigner(searchValue: state.searchValue));
      for (var id in event.ids) {
        await consignerRepository.deleteConsigner(id);
      }
      emit(DeletedConsigner(searchValue: state.searchValue));
      add(const GetAllConsigners());
    });
  }
}
