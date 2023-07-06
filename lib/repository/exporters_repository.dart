import 'package:gen_pdf/models/exporter.dart';

class ExporterRepository {
  Future<Exporter> createExporter(Map<String, dynamic> values) async {
    Exporter exporter = Exporter.newByMap(values);
    await exporter.insert();
    return exporter;
  }

  Future<Exporter> updateExporter(Map<String, dynamic> values) async {
    Exporter updatedExporter = Exporter().fromMap(values);
    updatedExporter.update(values['id']);
    return updatedExporter;
  }

  Future deleteExporter(String id) async {
    await Exporter().delete(id);
  }

  Future<List<Exporter>> getExporters() async {
    Exporter exporter = Exporter();
    return await exporter.getAll();
  }
}
