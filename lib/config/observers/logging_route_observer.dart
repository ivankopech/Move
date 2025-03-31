import 'package:flutter/material.dart';

class LoggingRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('🟢 PUSH: ${route.settings.name ?? route.settings.arguments ?? route.settings}', color: Ansi.green);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('🔴 POP: ${route.settings.name ?? route.settings.arguments ?? route.settings}', color: Ansi.red);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _log('🟡 REPLACE: ${newRoute?.settings.name}', color: Ansi.yellow);
  }

  void _log(String message, {String color = Ansi.reset}) {
    debugPrint('$color$message${Ansi.reset}');
  }
}

class Ansi {
  static const reset = '\x1B[0m';
  static const red = '\x1B[31m';
  static const green = '\x1B[32m';
  static const yellow = '\x1B[33m';
  static const blue = '\x1B[34m';
  static const magenta = '\x1B[35m';
  static const cyan = '\x1B[36m';
}
