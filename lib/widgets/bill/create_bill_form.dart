import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/bill/header_bill_form.dart';
import 'package:gen_pdf/widgets/bill/product_table.dart';

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
    return FormBuilder(
        key: _formkey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                    constraints: const BoxConstraints(maxWidth: 330),
                    child: HeaderBillForm(formKey: _formkey))),
            Expanded(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ProductTable(formKey: _formkey)))
          ],
        ));
  }
}
