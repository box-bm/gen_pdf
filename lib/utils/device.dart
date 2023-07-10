import 'dart:io';

bool get isDesktop => isMac || isWindows;
bool get isMobile => isAndroid || isIos;

bool get isMac => Platform.isMacOS;
bool get isWindows => Platform.isWindows;
bool get isAndroid => Platform.isAndroid;
bool get isIos => Platform.isAndroid;
