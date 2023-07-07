import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';

class NumberForm extends StatefulWidget {
  final String name;
  final String label;
  final String? placeholder;
  final num? value;
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
      value = widget.value ?? 0;
    });
  }

  @override
  void didUpdateWidget(NumberForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget != widget) {
      Future.delayed(Duration.zero, () {
        value = widget.value ?? 0;
      });
    }
  }

  void onChangeHandler(num? newValue) {
    context.read<FormCubit>().setValue(newValue ?? 0, widget.name);
    setState(() {
      value = newValue ?? 0;
    });
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
