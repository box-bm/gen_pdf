import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:window_manager/window_manager.dart';

class PreviewBill extends StatelessWidget {
  final pw.Document document;
  final String id;

  const PreviewBill({
    super.key,
    required this.document,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: const Text("Vista previa de pdf"),
        actions: DragToMoveArea(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 138,
              height: 30,
              child: WindowCaption(
                brightness: FluentTheme.of(context).brightness,
                backgroundColor: const Color(0x00000FFF),
              ),
            )
          ],
        )),
      ),
      content: ScaffoldPage(
        content: PdfPreview(
          allowPrinting: true,
          canChangeOrientation: false,
          canChangePageFormat: false,
          canDebug: false,
          actions: [
            IconButton(
                icon: const Icon(FluentIcons.save),
                onPressed: () {
                  context.read<BillsBloc>().add(PrintBill(id));
                })
          ],
          build: (format) => document.save(),
        ),
      ),
    );
  }
}