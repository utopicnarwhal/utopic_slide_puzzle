import 'package:flutter/material.dart';
import 'package:utopic_slide_puzzle/src/common/widgets/indicators.dart';
import 'package:utopic_slide_puzzle/src/theme/flutter_app_theme.dart';

/// Type of [UtopicButton]
enum UtopicButtonType {
  /// https://material.io/components/buttons/flutter#contained-button
  contained,

  /// https://material.io/components/buttons/flutter#outlined-button
  ///
  /// Looks like this but with with wider border sides
  outlined,

  /// https://material.io/components/buttons/flutter#text-button
  text,
}

/// Size of [UtopicButton]
enum UtopicButtonSize {
  /// Has height = 56
  large,

  /// Has height = 40
  regular,

  /// Has height = 24
  small,
}

/// Color of [UtopicButton]
enum UtopicButtonColor {
  /// Uses primary color of [ThemeData]
  primary,

  /// Uses [UtopicPalette.red] as primary
  red,

  /// Uses [UtopicPalette.green] as primary
  green,

  /// Uses [UtopicPalette.blue] as primary
  blue,

  /// Uses [UtopicPalette.yellow] as primary
  yellow,

  /// Uses [UtopicPalette.peach] as primary
  peach,

  /// Uses [ThemeData].cardColor as primary
  card,
}

const _buttonSwitchingAnimationDuration = Duration(milliseconds: 150);

/// {@template utopic_button}
/// Material type button but with custom properties and styles
/// {@endtemplate}
class UtopicButton extends StatelessWidget {
  /// {@macro utopic_button}
  const UtopicButton({
    required this.onPressed,
    required this.text,
    this.leading,
    this.trailing,
    this.color = UtopicButtonColor.primary,
    this.isLoading = false,
    this.type = UtopicButtonType.contained,
    this.elevation = 0,
    this.margin,
    this.size = UtopicButtonSize.regular,
    this.fullWidth = false,
    Key? key,
  }) : super(key: key);

  /// Text string to show inside the button
  final String text;

  /// Method to call when the button is pressed
  ///
  /// Isn't called when [isLoading] == true
  final VoidCallback? onPressed;

  /// Widget to place before [text]
  final Widget? leading;

  /// Widget to place after [text]
  final Widget? trailing;

  /// Color of the button
  final UtopicButtonColor color;

  /// Should the button show loading widget and prevent [onPressed] to be called
  final bool isLoading;

  /// Type of the button
  final UtopicButtonType type;

  /// Size of the button
  final UtopicButtonSize size;

  /// Should the button fill all available width
  final bool fullWidth;

  /// Only works with Contained type of button
  final double elevation;

  /// Padding outside the button
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.button?.copyWith(fontSize: _getFontSize());
    final textWidget = Text(
      text,
      style: textStyle,
      textAlign: TextAlign.center,
    );

    late Widget result;
    result = textWidget;

    result = _buildButtonFromType(context, result, isLoading);

    result = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: fullWidth ? double.infinity : kMinInteractiveDimension,
        minHeight: _getMinHeight(),
      ),
      child: result,
    );

    if (margin != null) {
      result = Padding(
        padding: margin!,
        child: result,
      );
    }
    return result;
  }

  double _getMinHeight() {
    switch (size) {
      case UtopicButtonSize.large:
        return 56;
      case UtopicButtonSize.regular:
        return 40;
      case UtopicButtonSize.small:
        return 24;
    }
  }

  double _getFontSize() {
    switch (size) {
      case UtopicButtonSize.large:
        return 22;
      case UtopicButtonSize.regular:
        return 16;
      case UtopicButtonSize.small:
        return 14;
    }
  }

  EdgeInsets _getMinInternalPadding() {
    switch (size) {
      case UtopicButtonSize.large:
        return const EdgeInsets.symmetric(vertical: 18, horizontal: 24);
      case UtopicButtonSize.regular:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case UtopicButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 5);
    }
  }

  Color _buttonPrimaryColor(BuildContext context, UtopicButtonType type) {
    switch (color) {
      case UtopicButtonColor.primary:
        return Theme.of(context).colorScheme.primary;
      case UtopicButtonColor.red:
        return UtopicPalette.red.shade300;
      case UtopicButtonColor.blue:
        return UtopicPalette.blue.shade700;
      case UtopicButtonColor.yellow:
        return UtopicPalette.yellow.shade700;
      case UtopicButtonColor.peach:
        return UtopicPalette.peach.shade700;
      case UtopicButtonColor.green:
        return UtopicPalette.green.shade700;
      case UtopicButtonColor.card:
        if (type == UtopicButtonType.outlined || type == UtopicButtonType.text) {
          return Colors.white;
        }
        return Theme.of(context).cardColor;
    }
  }

  double _loadingWidgetSize() {
    switch (size) {
      case UtopicButtonSize.large:
        return 24;
      case UtopicButtonSize.regular:
        return 20;
      case UtopicButtonSize.small:
        return 14;
    }
  }

  Widget _buildLoadingWidget() {
    return Builder(
      builder: (context) {
        return LoadingIndicator(
          visible: isLoading,
          color: DefaultTextStyle.of(context).style.color,
          size: _loadingWidgetSize(),
          strokeWidth: size == UtopicButtonSize.small ? 3 : 5,
        );
      },
    );
  }

  Widget _buildButtonFromType(BuildContext context, Widget child, bool isLoading) {
    final buttonPrimaryColor = _buttonPrimaryColor(context, type);
    final buttonOnPressed = isLoading ? () {} : onPressed;
    Widget? buttonLeading;
    Widget? buttonTrailing;

    if (leading != null) {
      buttonLeading = Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildLoadingWidget(),
            // Button should save the size even when the button label is replaced with loading indicator
            AnimatedOpacity(
              opacity: isLoading ? 0 : 1,
              duration: _buttonSwitchingAnimationDuration,
              child: leading,
            ),
          ],
        ),
      );
    }
    if (trailing != null) {
      buttonTrailing = Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (leading == null) _buildLoadingWidget(),
            // Button should save the size even when the button label is replaced with loading indicator
            AnimatedOpacity(
              opacity: (isLoading && leading == null) ? 0 : 1,
              duration: _buttonSwitchingAnimationDuration,
              child: trailing,
            ),
          ],
        ),
      );
    }
    final buttonChild = Builder(
      // We need the Builder widget to get the corrent IconTheme.of(context)
      builder: (context) {
        return IconTheme(
          data: IconTheme.of(context).copyWith(size: _loadingWidgetSize()),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (buttonLeading != null) buttonLeading,
              // Button should save the size even when the button label is replaced with loading indicator
              Flexible(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Show loading widget in the center in case if there are no trailing and leading widgets
                    if (leading == null && trailing == null) _buildLoadingWidget(),
                    // Hide the label text in case if there are no trailing and leading widgets
                    AnimatedOpacity(
                      opacity: isLoading && leading == null && trailing == null ? 0 : 1,
                      duration: _buttonSwitchingAnimationDuration,
                      child: child,
                    ),
                  ],
                ),
              ),
              if (buttonTrailing != null) buttonTrailing,
            ],
          ),
        );
      },
    );

    switch (type) {
      case UtopicButtonType.contained:
        final buttonStyle = ElevatedButton.styleFrom(
          primary: buttonPrimaryColor,
          onPrimary: color == UtopicButtonColor.card ? Theme.of(context).colorScheme.primary : null,
          elevation: elevation,
          shape: const StadiumBorder(),
          padding: _getMinInternalPadding(),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        );

        if (buttonLeading != null) {
          return ElevatedButton(
            style: buttonStyle,
            onPressed: buttonOnPressed,
            child: buttonChild,
          );
        }
        return ElevatedButton(
          style: buttonStyle,
          onPressed: buttonOnPressed,
          child: buttonChild,
        );
      case UtopicButtonType.outlined:
        var outlineColor = buttonPrimaryColor;
        if (buttonOnPressed == null) {
          outlineColor = Theme.of(context).disabledColor;
        }
        final buttonStyle = OutlinedButton.styleFrom(
          primary: buttonPrimaryColor,
          shape: const StadiumBorder(),
          side: BorderSide(
            color: outlineColor,
            width: size == UtopicButtonSize.small ? 1 : 2,
          ),
          padding: _getMinInternalPadding(),
          splashFactory: InkSplash.splashFactory,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        );

        if (buttonLeading != null) {
          return OutlinedButton(
            style: buttonStyle,
            onPressed: buttonOnPressed,
            child: buttonChild,
          );
        }
        return OutlinedButton(
          style: buttonStyle,
          onPressed: buttonOnPressed,
          child: buttonChild,
        );
      case UtopicButtonType.text:
        final buttonStyle = TextButton.styleFrom(
          primary: buttonPrimaryColor,
          shape: const StadiumBorder(),
          padding: _getMinInternalPadding(),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        );

        if (buttonLeading != null) {
          return TextButton(
            style: buttonStyle,
            onPressed: buttonOnPressed,
            child: buttonChild,
          );
        }
        return TextButton(
          style: buttonStyle,
          onPressed: buttonOnPressed,
          child: buttonChild,
        );
    }
  }
}
