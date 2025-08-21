import 'package:sentry_flutter/sentry_flutter.dart';

class SentryLogger {
  static Future<void> captureError(dynamic error, StackTrace stack) async {
    Sentry.captureException(error, stackTrace: stack, withScope: (scope) {});
  }
}
