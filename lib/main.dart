import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_pdf/app.dart';
import 'package:gen_pdf/database/database_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
  }

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(500, 700),
    title: "Generador de facturas",
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setAsFrameless();
    await windowManager.dock(side: DockSide.left, width: 400);
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden,
        windowButtonVisibility: true);
  });

  await DatabaseProvider().createDatabase();

  runApp(const MainApp());
}
