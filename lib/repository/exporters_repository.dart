import 'package:gen_pdf/models/exporter.dart';

class ExporterRepository {
  createExporter(Map<String, dynamic> values) async {
    Exporter exporter = Exporter.newByMap(values);
    await exporter.insert();
  }

  getExporters() async {
    Exporter exporter = Exporter();
    return await exporter.getAll();
  }
}
