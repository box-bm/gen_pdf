import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart' as form_cubit;
import 'package:gen_pdf/cubit/form_cubit.dart';
import 'package:gen_pdf/widgets/inputs/dropdown_form.dart';
import 'package:gen_pdf/widgets/inputs/textbox_form.dart';

class CreateBillForm extends StatefulWidget {
  final Function(Map<String, dynamic> values) onSubmit;
  const CreateBillForm({super.key, required this.onSubmit});

  @override
  State<CreateBillForm> createState() => _CreateBillFormState();
}

class _CreateBillFormState extends State<CreateBillForm> {
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    context.read<ExporterBloc>().add(const GetAllExporters());
    context.read<ConsignerBloc>().add(const GetAllConsigners());
    _formkey.currentState?.initState();
    super.initState();
  }

  @override
  void dispose() {
    _formkey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<form_cubit.FormCubit, form_cubit.FormState>(
      builder: (context, state) => FormBuilder(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextboxForm(
                  name: 'billNumber',
                  label: "Numero de factura",
                  value: state.values['billNumber'],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ])),
              const SizedBox(height: 10),
              DropdownForm(
                  label: "Exportador",
                  name: "exporterID",
                  value: state.values['exporterID'],
                  onInputChange: (value) =>
                      context.read<FormCubit>().setValue(value, 'exporterID'),
                  placeholder: "Busca y selecciona el exportador",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  items: [
                    AutoSuggestBoxItem(value: 'new', label: 'Nuevo'),
                    AutoSuggestBoxItem(value: 'none', label: 'Ninguno'),
                    ...context
                        .read<ExporterBloc>()
                        .state
                        .exporters
                        .map((e) => AutoSuggestBoxItem(
                            value: e.id,
                            label: "${e.name}, Direccion: ${e.address}"))
                        .toList()
                  ]),
              const SizedBox(height: 10),
              DropdownForm(
                  label: "Cliente",
                  name: "consignerID",
                  value: state.values['consignerID'],
                  placeholder: "Busca y selecciona el cliente",
                  onInputChange: (value) =>
                      context.read<FormCubit>().setValue(value, 'consignerID'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  items: [
                    AutoSuggestBoxItem(value: 'new', label: 'Nuevo'),
                    AutoSuggestBoxItem(value: 'none', label: 'Ninguno'),
                    ...context
                        .read<ConsignerBloc>()
                        .state
                        .consigners
                        .map((e) => AutoSuggestBoxItem(
                            value: e.id,
                            label: "${e.name}, Direccion: ${e.address}"))
                        .toList()
                  ]),
              const SizedBox(height: 10),
              TextboxForm(
                  name: 'containerNumber',
                  label: "No. de contenedor",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  value: state.values['containerNumber']),
              const SizedBox(height: 10),
              TextboxForm(
                  name: 'bl',
                  label: "No. de BL",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  value: state.values['bl']),
              const SizedBox(height: 10),
              TextboxForm(
                  name: 'termsAndConditions',
                  label: "Terminos y condiciones",
                  maxLines: null,
                  value: state.values['termsAndConditions']),
              const SizedBox(height: 10),
              Button(
                  onPressed: () {
                    if (_formkey.currentState!.saveAndValidate()) {
                      context.read<form_cubit.FormCubit>().submit();
                      widget.onSubmit(state.values);
                    }
                  },
                  child: const Text("Guardar"))
            ],
          )),
    );
  }
}
