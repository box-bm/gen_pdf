import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/utils/device.dart';
import 'package:window_manager/window_manager.dart';

class AppBarSpacing {
  final double left;
  final double right;

  AppBarSpacing(this.left, this.right);
}

class AppBarUtils {
  static double? get appbarHeight {
    if (isMac) return 16;
    if (isWindows) return 40;
    return null;
  }

  static AppBarSpacing? get appbarSpace {
    if (isMac) return AppBarSpacing(500, 0);
    if (isWindows) return AppBarSpacing(50, 138);
    return null;
  }

  static Widget? platformAppBarFlexibleSpace(BuildContext context) {
    if (isWindows) {
      return WindowCaption(
        brightness: Theme.of(context).brightness,
        backgroundColor: Colors.transparent,
      );
    }

    return null;
  }
}
