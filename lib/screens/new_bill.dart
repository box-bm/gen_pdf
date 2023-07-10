import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/utils/appbar_utils.dart';
import 'package:gen_pdf/widgets/bill/create_bill_form.dart';

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
    _formkey.currentState?.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var values =
        (ModalRoute.of(context)?.settings.arguments) as Map<String, dynamic>?;

    var isEditing = values != null;

    bool validateForm() {
      return _formkey.currentState!.saveAndValidate();
    }

    return FormBuilder(
        key: _formkey,
        initialValue: values ?? {},
        child: Scaffold(
          appBar: AppBar(
            title: Text(isEditing ? "Modificar Factura" : "Creando Factura"),
            leadingWidth: AppBarUtils.appbarSpace?.left,
            toolbarHeight: AppBarUtils.appbarHeight,
            flexibleSpace: AppBarUtils.platformAppBarFlexibleSpace(context),
            actions: [
              TextButton.icon(
                  onPressed: () {
                    if (validateForm()) {
                      context
                          .read<BillsBloc>()
                          .add(CreateBill(_formkey.currentState!.value));
                    }
                  },
                  icon: const Icon(Icons.save_as_outlined),
                  label: const Text("Guardar")),
              SizedBox(width: AppBarUtils.appbarSpace?.right)
            ],
          ),
          body: BlocListener<BillsBloc, BillsState>(
            listener: (context, state) {
              if (state is BillSaved) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        isEditing ? "Factura modificada" : "Factura creada"),
                  ),
                );
              }
            },
            child: SafeArea(child: CreateBillForm(formkey: _formkey)),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                if (validateForm()) {
                  context
                      .read<BillsBloc>()
                      .add(CreateBill(_formkey.currentState!.value));
                }
              },
              label: const Text("Guardar")),
        ));
  }
}
