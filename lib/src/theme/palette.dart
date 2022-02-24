part of 'flutter_app_theme.dart';

/// Abstract class that contains preset values for the most commonly used colors in the app
abstract class UtopicPalette {
  /// Common use: canvas color for the [ThemeData] in the dark mode
  ///
  /// #121212
  static const veryDarkGray = Color(0xFF121212);

  /// https://en.wikipedia.org/wiki/Baker-Miller_pink
  ///
  /// #FF91AF
  static const MaterialColor utopicPrimary = MaterialColor(0xFFFF91AF, {
    50: Color(0xFFFFE5EB),
    100: Color(0xFFFFBCCE),
    200: Color(0xFFFF91AF),
    300: Color(0xFFFD658E),
    400: Color(0xFFF94475),
    500: Color(0xFFF6275E),
    600: Color(0xFFE5235B),
    700: Color(0xFFCF1D57),
    800: Color(0xFFBB1855),
    900: Color(0xFF960F4F),
  });

  /// Color to use as primary with the dark theme
  ///
  /// Just a shade 800 of [utopicPrimary] #BB1855
  static const MaterialColor utopicPrimaryDark = MaterialColor(0xFFBB1855, {
    50: Color(0xFFFFE5EB),
    100: Color(0xFFFFBCCE),
    200: Color(0xFFFF91AF),
    300: Color(0xFFFD658E),
    400: Color(0xFFF94475),
    500: Color(0xFFF6275E),
    600: Color(0xFFE5235B),
    700: Color(0xFFCF1D57),
    800: Color(0xFFBB1855),
    900: Color(0xFF960F4F),
  });

  /// Soft red color
  ///
  /// #FF6F64
  static const red = MaterialColor(0xFFFF6F64, {
    900: Color(0xFFEE4948),
    800: Color(0xFFEE4948),
    700: Color(0xFFEE4948),
    600: Color(0xFFFF6F64),
    500: Color(0xFFFF6F64),
    400: Color(0xFFFF6F64),
    300: Color(0xFFFF6F64),
    200: Color(0xFFFFD4D1),
    100: Color(0xFFFFD4D1),
    50: Color(0xFFFFD4D1),
  });


  /// Soft light-blue color
  ///
  /// #B3E3F2
  static const blue = MaterialColor(0xFFB3E3F2, {
    900: Color(0xFF64B6CF),
    800: Color(0xFF64B6CF),
    700: Color(0xFF64B6CF),
    600: Color(0xFFB3E3F2),
    500: Color(0xFFB3E3F2),
    400: Color(0xFFB3E3F2),
    300: Color(0xFFB3E3F2),
    200: Color(0xFFE9F5F9),
    100: Color(0xFFE9F5F9),
    50: Color(0xFFE9F5F9),
  });

  /// Soft light-green color
  ///
  /// #76D2A0
  static const green = MaterialColor(0xFF76D2A0, {
    900: Color(0xFF41A870),
    800: Color(0xFF41A870),
    700: Color(0xFF41A870),
    600: Color(0xFF76D2A0),
    500: Color(0xFF76D2A0),
    400: Color(0xFF76D2A0),
    300: Color(0xFF76D2A0),
    200: Color(0xFFD5F1E2),
    100: Color(0xFFD5F1E2),
    50: Color(0xFFD5F1E2),
  });

  /// Soft yellow color
  ///
  /// #F9D853
  static const yellow = MaterialColor(0xFFF9D853, {
    900: Color(0xFFEBBC00),
    800: Color(0xFFEBBC00),
    700: Color(0xFFEBBC00),
    600: Color(0xFFF9D853),
    500: Color(0xFFF9D853),
    400: Color(0xFFF9D853),
    300: Color(0xFFF9D853),
    200: Color(0xFFFDF3CB),
    100: Color(0xFFFDF3CB),
    50: Color(0xFFFDF3CB),
  });

  /// Peach color
  ///
  /// #FBAD91
  static const peach = MaterialColor(0xFFFBAD91, {
    900: Color(0xFFF6764A),
    800: Color(0xFFF6764A),
    700: Color(0xFFF6764A),
    600: Color(0xFFFBAD91),
    500: Color(0xFFFBAD91),
    400: Color(0xFFFBAD91),
    300: Color(0xFFFBAD91),
    200: Color(0xFFFDDED3),
    100: Color(0xFFFDDED3),
    50: Color(0xFFFDDED3),
  });

  /// Base color for a shimmering effect
  static const shimmerBaseColor = Color(0x40BDBDBD);
  /// Highlight color for a shimmering effect
  static const shimmerHighlightColor = Color(0x50efefef);
}
