import 'package:gen_pdf/database/table.dart';

class Person extends Table {
  late String id;
  late String name;
  late String address;

  Person({
    required this.id,
    required this.name,
    required this.address,
  });
}
