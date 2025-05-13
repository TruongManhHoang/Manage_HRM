import 'package:admin_hrm/local/hive_storage.dart';
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
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(GlobalStorageKey.globalStorage);
  setPathUrlStrategy();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  dependencyInjector.servicesLocator();

  runApp(const App());
}
