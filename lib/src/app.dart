// ignore_for_file: public_member_api_docs

import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:utopic_slide_puzzle/l10n/generated/l10n.dart';
import 'package:utopic_slide_puzzle/src/locations/page_not_found/page_not_found.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/puzzle_page.dart';
import 'package:utopic_slide_puzzle/src/theme/dynamic_theme_mode.dart';
import 'package:utopic_slide_puzzle/src/theme/flutter_app_theme/flutter_app_theme.dart';

final _beamLocations = [
  PuzzleLocation(),
  PageNotFoundLocation(),
];

class UtopicSlidePuzzleApp extends StatefulWidget {
  const UtopicSlidePuzzleApp({Key? key}) : super(key: key);

  @override
  State<UtopicSlidePuzzleApp> createState() => _UtopicSlidePuzzleAppState();
}

class _UtopicSlidePuzzleAppState extends State<UtopicSlidePuzzleApp> {
  @override
  void initState() {
    super.initState();

    Future<void>.delayed(const Duration(milliseconds: 20), () {
      precacheImage(
        Image.asset('assets/images/shuffle_icon.png').image,
        context,
      );
    });
  }

  final _routerDelegate = BeamerDelegate(
    setBrowserTabTitle: false,
    initialPath: PuzzleLocation.path,
    locationBuilder: BeamerLocationBuilder(
      beamLocations: _beamLocations,
    ),
    notFoundRedirectNamed: PageNotFoundLocation.path,
  );

  @override
  Widget build(BuildContext context) {
    return DynamicThemeMode(
      builder: (context, themeMode) {
        return MaterialApp.router(
          restorationScopeId: 'app',
          useInheritedMediaQuery: true,
          onGenerateTitle: (BuildContext context) => 'Utopic Slide Puzzle',
          debugShowCheckedModeBanner: false,
          routerDelegate: _routerDelegate,
          routeInformationParser: BeamerParser(),
          backButtonDispatcher: BeamerBackButtonDispatcher(delegate: _routerDelegate),
          localizationsDelegates: const [
            Dictums.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: Dictums.delegate.supportedLocales,
          theme: UtopicTheme.getAppTheme(Brightness.light).copyWith(
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: UtopicTheme.getAppTheme(Brightness.light).cardColor,
            ),
          ),
          darkTheme: UtopicTheme.getAppTheme(Brightness.dark),
          themeMode: themeMode,
          scrollBehavior: const CupertinoScrollBehavior(),
          builder: (context, child) {
            SystemChrome.setSystemUIOverlayStyle(UtopicTheme.getSystemUiOverlayStyle(context));

            return child ?? const SizedBox();
          },
        );
      },
    );
  }
}
