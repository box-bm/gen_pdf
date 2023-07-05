part of 'consigneer_bloc.dart';

abstract class ConsigneerEvent extends Equatable {
  const ConsigneerEvent();

  @override
  List<Object> get props => [];
}

class CreateConsigner extends ConsigneerEvent {
  final Map<String, dynamic> values;

  const CreateConsigner(this.values);
}

class EditConsigner extends ConsigneerEvent {
  final Map<String, dynamic> values;

  const EditConsigner(this.values);
}

class DeleteConsigner extends ConsigneerEvent {
  final String id;

  const DeleteConsigner(this.id);
}

class DeleteConsigners extends ConsigneerEvent {
  final List<String> ids;

  const DeleteConsigners(this.ids);
}

class GetAllConsigners extends ConsigneerEvent {
  const GetAllConsigners();
}

class Filter extends ConsigneerEvent {
  final String value;

  const Filter(this.value);
}
