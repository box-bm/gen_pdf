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
    if (isMac) return 50;
    if (isWindows) return 40;
    return null;
  }

  static AppBarSpacing? get appbarSpace {
    if (isMac) return AppBarSpacing(120, 10);
    if (isWindows) return AppBarSpacing(50, 138);
    return null;
  }

  static Widget? get platformAppBarFlexibleSpace {
    if (isWindows) {
      return Builder(
          builder: (context) => WindowCaption(
              brightness: Theme.of(context).brightness,
              backgroundColor: Colors.transparent));
    }

    return null;
  }

  static IconData get leadingIcon {
    if (isIos || isMac) {
      return Icons.arrow_back_ios_new;
    }

    if (isWindows) {
      return Icons.arrow_back_sharp;
    }

    return Icons.arrow_back;
  }

  static Widget get leadingWidget {
    return Builder(
      builder: (context) => Visibility(
          visible: Navigator.canPop(context),
          maintainSize: false,
          child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(leadingIcon),
              ))),
    );
  }
}
