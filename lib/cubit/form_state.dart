part of 'form_cubit.dart';

abstract class FormState extends Equatable {
  final Map<String, dynamic> values;
  const FormState(this.values);

  @override
  List<Object> get props => [values];
}

class FormInitial extends FormState {
  const FormInitial(super.values);
}

class Submitted extends FormState {
  const Submitted(super.values);
}
