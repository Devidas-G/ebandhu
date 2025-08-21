import 'package:sentry_flutter/sentry_flutter.dart';
import '../config/env.dart';
import 'crash_reporter.dart';

class SentryCrashReporter implements CrashReporter {
  @override
  Future<void> init({required Function() appRunner}) async {
    await SentryFlutter.init((options) {
      options.dsn = Env.sentryDsn;
      options.environment = Env.environment;
      options.tracesSampleRate = 1.0; // 100% tracing (lower in prod if needed)
      options.profilesSampleRate =
          1.0; // 100% profiling (lower in prod if needed)
    }, appRunner: appRunner);
  }

  /// Helper to manually capture an exception
  @override
  Future<void> captureException(dynamic throwable, {dynamic stackTrace}) async {
    await Sentry.captureException(throwable, stackTrace: stackTrace);
  }

  /// Helper to manually capture a message
  @override
  Future<void> captureMessage(String message) async {
    await Sentry.captureMessage(message);
  }
}
