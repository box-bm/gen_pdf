import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/consignee_form.dart';

class NewConsigneer extends StatelessWidget {
  static String route = "newConsigneer";
  const NewConsigneer({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
        header: Text("Consignatario"),
        content: SingleChildScrollView(
            child: SafeArea(
                minimum: EdgeInsets.fromLTRB(10, 12, 10, 20),
                child: Column(
                  children: [ConsigneeForm()],
                ))));
  }
}
