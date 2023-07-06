import 'package:file_picker/file_picker.dart';

class FileManager {
  Future<String?> saveFile({
    String fileName = "archivo.txt",
    String dialogTitle = "Selecciones donde guardar el archivo",
    List<String> allowedExtensions = const ['txt'],
  }) async {
    String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: dialogTitle,
        fileName: fileName,
        allowedExtensions: allowedExtensions,
        type: FileType.any);
    return outputFile;
  }

  Future<FilePickerResult?> choseFile({
    String dialogTitle = "Selecciones donde guardar el archivo",
    List<String> allowedExtensions = const ['txt'],
  }) async {
    FilePickerResult? outputFile = await FilePicker.platform.pickFiles(
        dialogTitle: dialogTitle,
        allowedExtensions: allowedExtensions,
        type: FileType.any);
    return outputFile;
  }
}
