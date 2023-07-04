import 'package:gen_pdf/models/consigneer.dart';

class ConsignerRepository {
  Future<Consigneer> createconsigner(Map<String, dynamic> values) async {
    Consigneer consigneer = Consigneer.newByMap(values);
    await consigneer.insert();
    return consigneer;
  }

  Future<Consigneer> updateConsigner(Map<String, dynamic> values) async {
    Consigneer updatedConsigner = Consigneer().fromMap(values);
    updatedConsigner.update(values['id']);
    return updatedConsigner;
  }

  Future deleteConsigner(String id) async {
    await Consigneer().delete(id);
  }

  Future<List<Consigneer>> getConsigners() async {
    Consigneer consigneer = Consigneer();
    return await consigneer.getAll();
  }
}
