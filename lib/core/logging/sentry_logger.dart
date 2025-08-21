import 'package:sentry_flutter/sentry_flutter.dart';
import '../utils/device_info.dart';

class SentryLogger {
  static Future<void> captureError(dynamic error, StackTrace stack) async {
    final deviceDetails = await DeviceInfoCollector.collect();

    Sentry.captureException(
      error,
      stackTrace: stack,
      withScope: (scope) {
        deviceDetails.forEach((k, v) {
          scope.setTag(k, v.toString());
        });
      },
    );
  }
}
