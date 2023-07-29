import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/utils/appbar_utils.dart';
import 'package:gen_pdf/widgets/bill/create_bill_form.dart';
import 'package:intl/intl.dart';
import 'package:gen_pdf/utils/formatter.dart';

class NewBill extends StatefulWidget {
  static String route = "newBill";
  const NewBill({super.key});

  @override
  State<NewBill> createState() => _NewBillState();
}

class _NewBillState extends State<NewBill> {
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    context.read<ExporterBloc>().add(const GetAllExporters());
    context.read<ConsignerBloc>().add(const GetAllConsigners());
    // context.read<BillsBloc>().add(const GetAllConsigners());
    _formkey.currentState?.initState();
    super.initState();
  }

  bool validateForm(BuildContext context) {
    var valid = _formkey.currentState!.saveAndValidate();
    var errors = _formkey.currentState?.errors;

    if (errors != null) {
      if (errors.containsKey('items')) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Agregar al menos un articulo")));
      }
    }
    return valid;
  }

  @override
  Widget build(BuildContext context) {
    var values =
        (ModalRoute.of(context)?.settings.arguments) as Map<String, dynamic>?;

    var isEditing = values != null;

    return Scaffold(
      appBar: AppBar(
        leading: AppBarUtils.leadingWidget,
        title: Text(isEditing ? "Modificar Factura" : "Crear Factura"),
        toolbarHeight: AppBarUtils.appbarHeight,
        flexibleSpace: AppBarUtils.platformAppBarFlexibleSpace,
        centerTitle: false,
      ),
      body: BlocListener<BillsBloc, BillsState>(
          listener: (context, state) {
            if (state is FindedNewBillNumber) {
              _formkey.currentState?.fields['number']
                  ?.didChange(state.newBillNumber.toString());

              _formkey.currentState?.fields['billNumber']?.didChange(state
                          .dateTime !=
                      null
                  ? "502${DateFormat("MMdd").format(state.dateTime!)}${state.newBillNumber?.suffixNumber()}"
                  : null);
            }
            if (state is BillSaved) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text(isEditing ? "Factura modificada" : "Factura creada"),
                ),
              );
              Navigator.pop(context);
            }
          },
          child: FormBuilder(
              key: _formkey,
              initialValue: values ?? {},
              child: SafeArea(child: CreateBillForm(formkey: _formkey)))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (validateForm(context)) {
              if (isEditing) {
                context
                    .read<BillsBloc>()
                    .add(EditBill(_formkey.currentState!.value));
              } else {
                context
                    .read<BillsBloc>()
                    .add(CreateBill(_formkey.currentState!.value));
              }
            }
          },
          icon: const Icon(Icons.save_as_outlined),
          label: const Text("Guardar")),
    );
  }
}
