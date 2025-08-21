import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/app.dart';
import 'core/errors/crash_reporter.dart';
import 'di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  const envFile = String.fromEnvironment(
    "ENV_FILE",
    defaultValue: ".env/.env.dev",
  );
  await dotenv.load(fileName: envFile);
  await di.sl<CrashReporter>().init(appRunner: () => runApp(MyApp()));
}

//! For local development
  // flutter run --dart-define=ENV_FILE=.env/.env.dev
  // flutter run --dart-define=ENV_FILE=.env/.env.staging
  // flutter run --dart-define=ENV_FILE=.env/.env.prod

//! For build release
  //flutter build apk --dart-define=ENV_FILE=.env/.env.prod