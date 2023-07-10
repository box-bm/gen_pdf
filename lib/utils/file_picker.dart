import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<String> saveTempFile({
    String fileName = "archivo.txt",
  }) async {
    var tempDirectory = (await getTempDirectory()) ?? "";

    return "$tempDirectory/$fileName";
  }

  Future<String?> getTempDirectory() async {
    var dir = await getTemporaryDirectory();
    return dir.path;
  }

  Future<String?> chooseDirectoryPath({
    String dialogTitle = "Selecciones donde guardar el archivo",
  }) async {
    return await FilePicker.platform.getDirectoryPath(dialogTitle: dialogTitle);
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
