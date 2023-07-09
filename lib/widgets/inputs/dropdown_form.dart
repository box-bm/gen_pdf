import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';

class DropdownForm extends StatefulWidget {
  final String name;
  final String label;
  final String? placeholder;
  final String? value;
  final List<DropdownMenuItem<dynamic>> items;
  final String? Function(Object?)? validator;
  final Function(Object?)? onInputChange;

  const DropdownForm({
    super.key,
    required this.name,
    required this.label,
    this.placeholder,
    this.validator,
    required this.value,
    this.onInputChange,
    required this.items,
  });

  @override
  State<DropdownForm> createState() => _DropdownFormState();
}

class _DropdownFormState extends State<DropdownForm> {
  void onChangeHandler(Object? value) {
    context.read<FormCubit>().setValue(value, widget.name);
    if (widget.onInputChange != null) {
      widget.onInputChange!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: widget.name,
      validator: widget.validator,
      onChanged: onChangeHandler,
      initialValue: widget.value,
      builder: (field) => DropdownButton(
          onChanged: (value) => field.didChange(value.toString()),
          value: widget.value,
          items: widget.items),
    );
  }
}
