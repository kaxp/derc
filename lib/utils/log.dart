import 'package:logger/logger.dart';

class Log {
  static final _prettyPrinter = PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 2,
    colors: true,
    printEmojis: false,
  );

  static final _logger = Logger(printer: _prettyPrinter);

  static void verbose(String message) {
    _logger.v(message);
  }

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String? message) {
    _logger.e(message);
  }

  static void errorObject(
    String? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    _logger.e(message, error, stackTrace);
  }

  static void fatal(String message) {
    _logger.wtf(message);
  }
}
