import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/common.dart';

class DropdownForm extends StatefulWidget {
  final String name;
  final String label;
  final String? placeholder;
  final String value;
  final List<AutoSuggestBoxItem<dynamic>> items;
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
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    changeValue();
  }

  void changeValue() {
    if (widget.items.isNotEmpty && widget.value.isNotEmpty) {
      editingController.value = editingController.value.copyWith(
          text: widget.items
              .firstWhere((element) => element.value == widget.value)
              .label);
    }
  }

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DropdownForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget != widget) {
      if (editingController.value.text != widget.value) {
        Future.delayed(Duration.zero, () {
          changeValue();
        });
      }
    }
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
      initialValue: editingController.text,
      builder: (field) => InfoLabel(
          label: widget.label,
          child: AutoSuggestBox(
              controller: editingController,
              onSelected: (value) => field.didChange(value.value),
              placeholder: widget.placeholder,
              items: widget.items)),
    );
  }
}
