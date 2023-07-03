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

class GetAllConsigners extends ConsigneerEvent {
  const GetAllConsigners();
}
