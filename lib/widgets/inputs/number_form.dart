import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/common.dart';

class NumberForm extends StatefulWidget {
  final String name;
  final String label;
  final String? placeholder;
  final num value;
  final String? Function(Object?)? validator;
  final Function(Object?)? onInputChange;
  const NumberForm({
    super.key,
    required this.name,
    required this.label,
    this.placeholder,
    this.validator,
    required this.value,
    this.onInputChange,
  });

  @override
  State<NumberForm> createState() => _NumberFormState();
}

class _NumberFormState extends State<NumberForm> {
  num value = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.value;
    });
  }

  void onChangeHandler(Object? value) {
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
        builder: (field) => InfoLabel(
              label: widget.label,
              child: NumberBox(
                mode: SpinButtonPlacementMode.inline,
                value: value,
                placeholder: widget.placeholder,
                onChanged: (value) => field.didChange(value),
              ),
            ));
  }
}
