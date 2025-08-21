import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/app.dart';
import 'core/errors/sentry_reporter.dart';
import 'di.dart' as di;
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  // Pick env based on --dart-define
  const envFile = String.fromEnvironment(
    "ENV_FILE",
    defaultValue: ".env/.env.dev",
  );
  //! For local development
  // flutter run --dart-define=ENV_FILE=.env/.env.dev
  // flutter run --dart-define=ENV_FILE=.env/.env.staging
  // flutter run --dart-define=ENV_FILE=.env/.env.prod
  await dotenv.load(fileName: envFile);
  //! For build release
  //flutter build apk --dart-define=ENV_FILE=.env/.env.prod
  await SentryReporter.init(() => runApp(const MyApp()));
}
