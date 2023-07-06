part of 'consigner_bloc.dart';

abstract class ConsignerEvent extends Equatable {
  const ConsignerEvent();

  @override
  List<Object> get props => [];
}

class CreateConsigner extends ConsignerEvent {
  final Map<String, dynamic> values;

  const CreateConsigner(this.values);
}

class EditConsigner extends ConsignerEvent {
  final Map<String, dynamic> values;

  const EditConsigner(this.values);
}

class DeleteConsigner extends ConsignerEvent {
  final String id;

  const DeleteConsigner(this.id);
}

class DeleteConsigners extends ConsignerEvent {
  final List<String> ids;

  const DeleteConsigners(this.ids);
}

class GetAllConsigners extends ConsignerEvent {
  const GetAllConsigners();
}

class Filter extends ConsignerEvent {
  final String value;

  const Filter(this.value);
}
