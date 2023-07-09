import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart' as form_cubit;
import 'package:gen_pdf/widgets/bill/product_table.dart';
import 'package:gen_pdf/widgets/exporter/form_inputs.dart' as exporter_input;
import 'package:gen_pdf/widgets/consigne/form_inputs.dart' as consigner_inputs;
import 'package:gen_pdf/widgets/inputs/dropdown_form.dart';
import 'package:gen_pdf/widgets/inputs/textbox_form.dart';

class CreateBillForm extends StatefulWidget {
  const CreateBillForm({super.key});

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                        constraints: const BoxConstraints(maxWidth: 330),
                        child: header(state))),
                const Expanded(
                    child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: ProductTable()))
              ],
            )));
  }

  Widget header(form_cubit.FormState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextboxForm(
            name: 'billNumber',
            label: "Numero de factura",
            value: state.values['billNumber'],
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ])),
        const SizedBox(height: 10),
        BlocBuilder<ExporterBloc, ExporterState>(
            builder: (context, exporterState) {
          if (state is LoadingExporters) {
            return const CircularProgressIndicator.adaptive();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownForm(
                  label: "Exportador",
                  name: "exporterID",
                  value: state.values['exporterID'],
                  placeholder: "Busca y selecciona el exportador",
                  onInputChange: (value) {
                    if (value != null &&
                        value != "new" &&
                        value.toString().isNotEmpty) {
                      var exporter = exporterState.exporters
                          .firstWhere((element) => element.id == value);

                      changFormValue(exporter.name, 'exporterName');
                      changFormValue(exporter.name, 'exporterAddress');
                    } else {
                      changFormValue('', 'exporterName');
                      changFormValue('', 'exporterAddress');
                    }
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  items: [
                    const DropdownMenuItem(value: 'new', child: Text("Nuevo")),
                    ...exporterState.exporters
                        .map((e) =>
                            DropdownMenuItem(value: e.id, child: Text(e.name)))
                        .toList()
                  ]),
              const SizedBox(height: 10),
              ...exporter_input.formInputs(
                  disabled:
                      (state.values['exporterID'] ?? "").toString().isEmpty ||
                          (state.values['exporterID'] ?? "") != "new")
            ],
          );
        }),
        const SizedBox(height: 10),
        BlocBuilder<ConsignerBloc, ConsignerState>(
          builder: (context, consignerState) {
            if (state is Loadingconsigners) {
              return const CircularProgressIndicator.adaptive();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownForm(
                    label: "Cliente",
                    name: "consignerID",
                    value: state.values['consignerID'],
                    placeholder: "Busca y selecciona el cliente",
                    onInputChange: (value) {
                      if (value != null &&
                          value != "new" &&
                          value.toString().isNotEmpty) {
                        var consigner = consignerState.consigners
                            .firstWhere((element) => element.id == value);
                        changFormValue(consigner.name, 'consignerName');
                        changFormValue(consigner.address, 'consignerAddress');
                        changFormValue(consigner.nit, 'consignerNIT');
                      } else {
                        changFormValue('', 'consignerName');
                        changFormValue('', 'consignerAddress');
                        changFormValue('', 'consignerNIT');
                      }
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    items: [
                      const DropdownMenuItem(
                          value: 'new', child: Text('Nuevo')),
                      ...consignerState.consigners
                          .map((e) => DropdownMenuItem(
                              value: e.id, child: Text(e.name)))
                          .toList()
                    ]),
                const SizedBox(height: 10),
                ...consigner_inputs.formInputs(
                    disabled: (state.values['consignerID'] ?? "")
                            .toString()
                            .isEmpty ||
                        (state.values['consignerID'] ?? "") != "new")
              ],
            );
          },
        ),
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
      ],
    );
  }

  void changFormValue(dynamic value, String key) {
    _formkey.currentState?.fields[key]?.didChange(value);
    context.read<form_cubit.FormCubit>().setValue(value, key);
  }
}
