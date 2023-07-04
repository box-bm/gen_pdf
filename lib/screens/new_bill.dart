import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/create_bill_form.dart';
import 'package:window_manager/window_manager.dart';

class NewBill extends StatelessWidget {
  static String route = "newBill";
  const NewBill({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        actions: DragToMoveArea(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 138,
              height: 50,
              child: WindowCaption(
                brightness: FluentTheme.of(context).brightness,
                backgroundColor: const Color(0x00000FFF),
              ),
            )
          ],
        )),
      ),
      content: const ScaffoldPage(
          content: SingleChildScrollView(
              child: SafeArea(
                  minimum: EdgeInsets.fromLTRB(10, 12, 10, 20),
                  child: Column(
                    children: [CreateBillForm()],
                  )))),
    );
  }
}
