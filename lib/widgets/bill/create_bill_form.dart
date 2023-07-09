import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/bill/header_bill_form.dart';
import 'package:gen_pdf/widgets/bill/product_table.dart';

class CreateBillForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formkey;

  const CreateBillForm({super.key, required this.formkey});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Container(
                constraints: const BoxConstraints(maxWidth: 330),
                child: HeaderBillForm(formKey: formkey))),
        Expanded(
            child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: ProductTable(formKey: formkey)))
      ],
    );
  }
}
