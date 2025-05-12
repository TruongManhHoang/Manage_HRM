import 'package:admin_hrm/local/hive_storage.dart';
import 'package:admin_hrm/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'app.dart';
import 'di/locator.dart';

/// Entry point of Flutter App
ServiceLocator dependencyInjector = ServiceLocator();
Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // Remove # sign from url

  dependencyInjector.servicesLocator();
  await Hive.openBox(GlobalStorageKey.globalStorage);
  setPathUrlStrategy();

  await Hive.initFlutter();
  await Hive.openBox('userBox');
  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  dependencyInjector.servicesLocator();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  // Main App Starts here...
  runApp(const App());
}
