import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'input_decoration.dart';
part 'palette.dart';
part 'typography.dart';

/// 16
const double kCardBorderRadius = 16;

/// 18
const double kBottomSheetBorderRadius = 18;

/// 20
const double kPopupBorderRadius = 20;

/// iOS scroll physics but also always scrollable to make it more interactive
const kDefaultScrollPhysics = BouncingScrollPhysics(
  parent: AlwaysScrollableScrollPhysics(),
);

/// Flutter app theme 
class UtopicTheme {
  /// Returns app's theme for passed [brightness]
  static ThemeData getAppTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      primaryColor: _getPrimaryColor(brightness),
      errorColor: UtopicPalette.red.shade700,
      hintColor: Colors.grey.shade500,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: _getPrimaryColor(brightness),
        brightness: brightness,
        errorColor: UtopicPalette.red.shade700,
        accentColor: _getPrimaryColor(brightness),
        cardColor: isDark ? UtopicPalette.veryDarkGray : null,
      ),
      applyElevationOverlayColor: isDark,
      scaffoldBackgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
      cardColor: isDark ? UtopicPalette.veryDarkGray : Colors.white,
      canvasColor: _getCanvasColor(brightness),
      textSelectionTheme: _textSelectionTheme(brightness),
      fontFamily: 'NunitoSans',
      buttonTheme: _buttonTheme,
      cardTheme: _cardTheme(isDark),
      dialogTheme: _dialogTheme,
      tooltipTheme: _tooltipTheme(brightness),
      dividerColor: _dividerColor(brightness),
      dividerTheme: _dividerTheme,
      snackBarTheme: _snackBarTheme,
      popupMenuTheme: _popupMenuTheme,
      bottomSheetTheme: _bottomSheetTheme,
      toggleableActiveColor: _getPrimaryColor(brightness),
      checkboxTheme: _checkboxThemeData(brightness),
      buttonBarTheme: _buttonBarTheme,
      shadowColor: isDark ? Colors.transparent : _getPrimaryColor(brightness).withAlpha(60),
      cupertinoOverrideTheme: _cupertinoOverrideTheme(brightness),
      inputDecorationTheme: _inputDecorationTheme(brightness),
      textTheme: _textTheme(brightness),
      appBarTheme: _appBarTheme(isDark),
      floatingActionButtonTheme: _floatingActionButtonTheme(isDark),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  /// Returns [SystemUiOverlayStyle] for current app theme's brightness
  /// Usually is applied by [AnnotatedRegion] widget
  static SystemUiOverlayStyle getSystemUiOverlayStyle(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarDividerColor: Theme.of(context).dividerColor,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      );
    }
    return SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      systemNavigationBarDividerColor: Theme.of(context).dividerColor,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    );
  }
}

Color _getCanvasColor(Brightness brightness) {
  return brightness == Brightness.dark ? UtopicPalette.veryDarkGray : const Color(0xFFF0F1F4);
}

MaterialColor _getPrimaryColor(Brightness brightness) {
  switch (brightness) {
    case Brightness.light:
      return UtopicPalette.utopicPrimary;
    case Brightness.dark:
      return UtopicPalette.utopicPrimaryDark;
  }
}

CheckboxThemeData _checkboxThemeData(Brightness brightness) {
  return CheckboxThemeData(
    shape: RoundedRectangleBorder(
      side: const BorderSide(width: 2),
      borderRadius: BorderRadius.circular(2),
    ),
  );
}

CupertinoThemeData _cupertinoOverrideTheme(Brightness brightness) {
  return CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    brightness: brightness,
  );
}

AppBarTheme _appBarTheme(bool isDark) {
  return AppBarTheme(
    color: isDark ? Colors.grey.shade900 : Colors.white,
    elevation: 0,
    foregroundColor: isDark ? null : Colors.black87,
    systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
  );
}

TextSelectionThemeData _textSelectionTheme(Brightness brightness) {
  return TextSelectionThemeData(
    cursorColor: _getPrimaryColor(brightness),
    selectionColor: _getPrimaryColor(brightness).shade400,
    selectionHandleColor: _getPrimaryColor(brightness).shade900,
  );
}

FloatingActionButtonThemeData? _floatingActionButtonTheme(bool isDark) {
  return FloatingActionButtonThemeData(
    backgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
    smallSizeConstraints: const BoxConstraints.tightFor(height: 44, width: 44),
    elevation: 0,
  );
}

Color _dividerColor(Brightness brightness) {
  switch (brightness) {
    case Brightness.light:
      return const Color(0xFFDADBE3);
    case Brightness.dark:
      return Colors.grey.shade600;
  }
}

final _buttonTheme = ButtonThemeData(
  textTheme: ButtonTextTheme.primary,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);

CardTheme _cardTheme(bool isDark) {
  return CardTheme(
    clipBehavior: Clip.hardEdge,
    margin: EdgeInsets.zero,
    elevation: 5,
    color: isDark ? UtopicPalette.veryDarkGray : Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kCardBorderRadius),
    ),
  );
}

final _dialogTheme = DialogTheme(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(kPopupBorderRadius),
  ),
);

TooltipThemeData _tooltipTheme(Brightness brightness) {
  return TooltipThemeData(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: _getPrimaryColor(brightness),
    ),
  );
}

const _dividerTheme = DividerThemeData(
  space: 1,
  thickness: 0.5,
);

const _snackBarTheme = SnackBarThemeData(
  behavior: SnackBarBehavior.floating,
);

final _popupMenuTheme = PopupMenuThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(kPopupBorderRadius),
  ),
);

const _bottomSheetTheme = BottomSheetThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(kBottomSheetBorderRadius),
    ),
  ),
);

const _buttonBarTheme = ButtonBarThemeData();
