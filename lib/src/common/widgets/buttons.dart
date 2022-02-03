// TODO(sergei): Add api docs
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:utopic_slide_puzzle/src/common/widgets/indicators.dart';
import 'package:utopic_slide_puzzle/src/theme/flutter_app_theme.dart';

enum UtopicButtonType {
  contained,
  outlined,
  text,
}

enum UtopicButtonSize {
  large,
  regular,
  small,
}

enum UtopicButtonColor {
  primary,
  red,
  green,
  blue,
  yellow,
  peach,
  card,
}

class UtopicButton extends StatelessWidget {
  const UtopicButton({
    required this.onPressed,
    required this.text,
    this.leading,
    this.color = UtopicButtonColor.primary,
    this.isLoading = false,
    this.type = UtopicButtonType.contained,
    this.elevation = 0,
    this.margin,
    this.size = UtopicButtonSize.regular,
    this.fullWidth = false,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Widget? leading;
  final UtopicButtonColor color;
  final bool isLoading;
  final UtopicButtonType type;
  final UtopicButtonSize size;
  final bool fullWidth;

  /// Only works with Contained type of button
  final double elevation;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.button?.copyWith(fontSize: _getFontSize());
    final textWidget = Text(text, style: textStyle);

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

    final buttonChild = Stack(
      alignment: Alignment.center,
      children: [
        if (leading == null) _buildLoadingWidget(),
        // Button should save the size even when the button label is replaced with loading indicator
        AnimatedOpacity(
          opacity: isLoading && leading == null ? 0 : 1,
          duration: const Duration(milliseconds: 150),
          child: child,
        ),
      ],
    );
    if (leading != null) {
      buttonLeading = Stack(
        alignment: Alignment.center,
        children: [
          _buildLoadingWidget(),
          // Button should save the size even when the button label is replaced with loading indicator
          AnimatedOpacity(
            opacity: isLoading ? 0 : 1,
            duration: const Duration(milliseconds: 150),
            child: leading,
          ),
        ],
      );
    }

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
          return ElevatedButton.icon(
            icon: buttonLeading,
            style: buttonStyle,
            onPressed: buttonOnPressed,
            label: buttonChild,
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
          return OutlinedButton.icon(
            icon: buttonLeading,
            style: buttonStyle,
            onPressed: buttonOnPressed,
            label: buttonChild,
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
          return TextButton.icon(
            icon: buttonLeading,
            label: buttonChild,
            style: buttonStyle,
            onPressed: buttonOnPressed,
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
