import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selecteds_state.dart';

class SelectedsCubit extends Cubit<List<String>> {
  SelectedsCubit() : super([]);

  select(String id) {
    if (state.contains(id)) {
      var newState = state.where((element) => element != id).toList();
      emit(newState);
    } else {
      emit([...state, id]);
    }
  }

  clearSelection() {
    emit([]);
  }
}
