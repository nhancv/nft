import 'package:logger/logger.dart';

/// Use logger to debug, it will not show in release mode
final Logger logger = Logger(printer: SimplePrinter());
