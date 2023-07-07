import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart' as form_cubit;
import 'package:gen_pdf/widgets/inputs/number_form.dart';
import 'package:gen_pdf/widgets/inputs/submit_button_form.dart';
import 'package:gen_pdf/widgets/inputs/textbox_form.dart';

class NewItemForm extends StatefulWidget {
  final Function(Map<String, dynamic> values) onSubmit;

  const NewItemForm({super.key, required this.onSubmit});

  @override
  State<NewItemForm> createState() => _NewItemFormState();
}

class _NewItemFormState extends State<NewItemForm> {
  final _key = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: BlocBuilder<form_cubit.FormCubit, form_cubit.FormState>(
        builder: (context, state) => FormBuilder(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Nuevo elemento",
                    style: FluentTheme.of(context).typography.title),
                const SizedBox(height: 15),
                TextboxForm(
                  name: "newItem.numeration",
                  label: "Numeracion",
                  value: state.values["newItem.numeration"],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 10),
                TextboxForm(
                  name: "newItem.description",
                  label: "Descripcion",
                  value: state.values["newItem.description"],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 10),
                NumberForm(
                  name: "newItem.quantity",
                  label: "Cantidad",
                  value: state.values["newItem.quantity"],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    (value) {
                      if ((value ?? 0) < 0) {
                        return "Debe ser una cantidad mayor a 0";
                      }
                      return null;
                    }
                  ]),
                ),
                const SizedBox(height: 10),
                TextboxForm(
                    name: "newItem.prs",
                    label: "PRS",
                    value: state.values["newItem.prs"]),
                const SizedBox(height: 10),
                NumberForm(
                  name: "newItem.unitPrice",
                  label: "Precio Unitario",
                  value: state.values["newItem.unitPrice"],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 10),
                SubmitButtonForm(
                  formKey: _key,
                  onSubmit: () {
                    var values = {...state.values.entries}
                        .where((element) => element.key.contains("newItem"))
                        .map((e) => {e.key.replaceAll("newItem.", ""): e.value})
                        .toList();

                    for (var entry in state.values.entries
                        .where((element) => element.key.contains("newItem"))) {
                      if (entry.value is num) {
                        context
                            .read<form_cubit.FormCubit>()
                            .setValue(0, entry.key);
                      } else {
                        context
                            .read<form_cubit.FormCubit>()
                            .setValue("", entry.key);
                      }
                    }

                    Map<String, dynamic> mapValues = {};

                    for (var element in values) {
                      mapValues.addAll(element);
                    }

                    if (!mapValues.containsKey('prs')) {
                      mapValues.addAll({'prs': ""});
                    }

                    mapValues.addAll({
                      "total": mapValues["unitPrice"] * mapValues["quantity"]
                    });

                    widget.onSubmit(mapValues);
                  },
                )
              ],
            )),
      ),
    );
  }
}
