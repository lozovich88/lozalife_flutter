import 'package:logger/logger.dart';

/// Application-wide logger instance.
final Logger appLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    colors: true,
    printEmojis: false,
  ),
);
