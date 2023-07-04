import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'form_state.dart';

class FormCubit extends Cubit<FormState> {
  FormCubit() : super(const FormInitial({}));

  void resetForm() => emit(const FormInitial({}));

  void setValues(Map<String, dynamic> values) => emit(FormInitial(values));

  void setValue(dynamic value, String key) {
    var newValues = {...state.values};
    if (newValues.containsKey(key)) {
      newValues[key] = value;
    } else {
      newValues = {...state.values, key: value};
    }
    emit(FormInitial(newValues));
  }

  void submit() {
    emit(Submitted(state.values));
    resetForm();
  }

  void cancel() {
    resetForm();
  }
}
