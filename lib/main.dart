import 'package:gen_pdf/app.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/database/database_provider.dart';
import 'package:gen_pdf/utils/device.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (isDesktop) {
    sqfliteFfiInit();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: true,
      );
      await windowManager.setMinimumSize(const Size(800, 400));
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  Intl.defaultLocale = 'es_GT';
  await DatabaseProvider().createDatabase();

  runApp(const App());
}
