import 'dart:convert';
import 'dart:developer' as developer;

abstract final class LogUtils {
  static void log(String message) {
    developer.log(message, name: 'info');
  }

  static void logObj(Object obj) {
    developer.log(jsonEncode(obj), name: 'info');
  }

  static void logError(Object e) {
    developer.log(e.toString(), error: e);
  }
}
