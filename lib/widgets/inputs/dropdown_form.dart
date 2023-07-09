import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/common.dart';

class DropdownForm extends StatefulWidget {
  final String name;
  final String label;
  final String? placeholder;
  final List<DropdownMenuItem<dynamic>> items;
  final String? Function(Object?)? validator;
  final Function(Object?)? onInputChange;

  const DropdownForm({
    super.key,
    required this.name,
    required this.label,
    this.placeholder,
    this.validator,
    this.onInputChange,
    required this.items,
  });

  @override
  State<DropdownForm> createState() => _DropdownFormState();
}

class _DropdownFormState extends State<DropdownForm> {
  void onChangeHandler(Object? value) {
    widget.onInputChange!(value);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: widget.name,
      validator: widget.validator,
      onChanged: onChangeHandler,
      builder: (field) => DropdownButton(
          isExpanded: true,
          hint: widget.placeholder != null ? Text(widget.placeholder!) : null,
          onChanged: (value) => field.didChange(value.toString()),
          value: field.value,
          items: widget.items),
    );
  }
}
