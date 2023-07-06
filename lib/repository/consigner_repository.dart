import 'package:gen_pdf/models/consigner.dart';

class ConsignerRepository {
  Future<Consigner> createconsigner(Map<String, dynamic> values) async {
    Consigner consigner = Consigner.newByMap(values);
    await consigner.insert();
    return consigner;
  }

  Future<Consigner> updateConsigner(Map<String, dynamic> values) async {
    Consigner updatedConsigner = Consigner().fromMap(values);
    updatedConsigner.update(values['id']);
    return updatedConsigner;
  }

  Future deleteConsigner(String id) async {
    await Consigner().delete(id);
  }

  Future<List<Consigner>> getConsigners() async {
    Consigner consigner = Consigner();
    return await consigner.getAll();
  }
}
