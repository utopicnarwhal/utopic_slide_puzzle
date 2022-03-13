import 'dart:async';
import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:utopic_slide_puzzle/src/services/audio_service.dart';

/// Custom instance of [BlocObserver] which logs
/// any state changes and errors.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

/// Bootstrap is responsible for any common setup and calls
/// [runApp] with the widget returned by [builder] in an error zone.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    Beamer.setPathUrlStrategy();
  }
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await BlocOverrides.runZoned(
    () async => await runZonedGuarded(
      () async {
        await AudioService.instance.init();
        runApp(await builder());
      },
      (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
    ),
    blocObserver: AppBlocObserver(),
  );
}
