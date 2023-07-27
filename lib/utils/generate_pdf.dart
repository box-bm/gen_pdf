import 'package:pdf/widgets.dart';

class GeneratePDF {
  final List<Page> pages;

  GeneratePDF(this.pages);

  Document generate() {
    Document pdf = Document();
    for (var page in pages) {
      pdf.addPage(page);
    }
    return pdf;
  }
}
