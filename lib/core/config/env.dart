import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get sentryDsn => dotenv.env['SENTRY_DSN'] ?? '';
  static String get environment => dotenv.env['ENV'] ?? 'dev';
  static String get apiUrl => dotenv.env['API_URL'] ?? '';
}
