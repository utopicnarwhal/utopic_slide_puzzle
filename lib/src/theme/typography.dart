part of 'flutter_app_theme.dart';

/// The values except the color are taken from the Material `Type scale generator`
/// https://material.io/design/typography/the-type-system.html#type-scale
TextTheme _textTheme(Brightness brightness) {
  final color = brightness == Brightness.light ? Colors.black87 : Colors.white;
  const fontFamily = 'Rubik';

  return TextTheme(
    headline1: TextStyle(
      fontSize: 98,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      fontFamily: fontFamily,
      color: color,
    ),
    headline2: TextStyle(
      fontSize: 61,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      fontFamily: fontFamily,
      color: color,
    ),
    headline3: TextStyle(
      fontSize: 49,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily,
      color: color,
    ),
    headline4: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      fontFamily: fontFamily,
      color: color,
    ),
    headline5: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily,
      color: color,
    ),
    headline6: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      fontFamily: fontFamily,
      color: color,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      fontFamily: fontFamily,
      color: color,
    ),
    subtitle2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      fontFamily: fontFamily,
      color: color,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      fontFamily: fontFamily,
      color: color,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      fontFamily: fontFamily,
      color: color,
    ),
    button: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      fontFamily: fontFamily,
      color: color,
    ),
    caption: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      fontFamily: fontFamily,
      color: color,
    ),
    overline: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      fontFamily: fontFamily,
      color: color,
    ),
  );
}
