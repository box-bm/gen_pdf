import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gen_pdf/models/consigner.dart';
import 'package:gen_pdf/repository/consigner_repository.dart';

part 'consigner_event.dart';
part 'consigner_state.dart';

class ConsignerBloc extends Bloc<ConsignerEvent, ConsignerState> {
  ConsignerRepository consignerRepository = ConsignerRepository();

  ConsignerBloc() : super(const ConsignerInitial(searchValue: "")) {
    on<Filter>((event, emit) {
      emit(ConsignersLoaded(searchValue: event.value));
      add(const GetAllConsigners());
    });
    on<GetAllConsigners>((event, emit) async {
      emit(Loadingconsigners(searchValue: state.searchValue));
      var consigners = await consignerRepository.getConsigners();

      if (state.searchValue.isNotEmpty) {
        var searchCriteria = state.searchValue.toLowerCase();
        consigners = consigners
            .where((element) =>
                (element.nit ?? "").toLowerCase().contains(searchCriteria) ||
                element.address.toLowerCase().contains(searchCriteria) ||
                element.name.toLowerCase().contains(searchCriteria))
            .toList();
      }
      emit(ConsignersLoaded(
          consigners: consigners, searchValue: state.searchValue));
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
      emit(DeletingConsigner(1, searchValue: state.searchValue));
      add(const GetAllConsigners());
    });
    on<DeleteConsigners>((event, emit) async {
      emit(DeletingConsigner(event.ids.length, searchValue: state.searchValue));
      for (var id in event.ids) {
        await consignerRepository.deleteConsigner(id);
      }
      emit(DeletedConsigner(event.ids.length, searchValue: state.searchValue));
      add(const GetAllConsigners());
    });
  }
}
