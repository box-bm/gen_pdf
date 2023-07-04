import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/create_bill_form.dart';

class NewBill extends StatelessWidget {
  static String route = "newBill";
  const NewBill({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
        header: Text("Crear nueva factura"),
        content: SingleChildScrollView(
            child: SafeArea(
                minimum: EdgeInsets.fromLTRB(10, 12, 10, 20),
                child: Column(
                  children: [CreateBillForm()],
                ))));
  }
}
