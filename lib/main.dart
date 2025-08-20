import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/app.dart';
import 'di.dart' as di;
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  await SentryFlutter.init((options) {
    options.dsn =
        'https://f43e4d840ee23d7428e85faa8935b59a@o4509876297138176.ingest.de.sentry.io/4509876298580049';
    // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
    // We recommend adjusting this value in production.
    options.tracesSampleRate = 1.0;
    // The sampling rate for profiling is relative to tracesSampleRate
    // Setting to 1.0 will profile 100% of sampled transactions:
    options.profilesSampleRate = 1.0;
  }, appRunner: () => runApp(SentryWidget(child: const MyApp())));
}
