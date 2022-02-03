import 'dart:async';

import 'package:flutter/material.dart';

/// Represents the layout size by its width
///
/// They are sorted by size from `tiny` to `extra large`
///
/// Call [ScreenSize.getBreakpoint] to get it for the current [BuildContext]
enum Breakpoint {
  /// Tiny < 360
  tn,

  /// Extra small >= 360, < 600
  xs,

  /// Small >= 600, < 1024
  sm,

  /// Medium >= 1024, < 1440
  md,

  /// Large >= 1440, < 1920
  lg,

  /// Extra large >= 1920
  xl,
}

/// Signature for the individual actions (`small`, `medium`, `large`, etc.).
typedef ResponsiveLayoutActionFunction = FutureOr<void> Function(BuildContext context, Breakpoint breakpoint);

/// {@template screen_size}
/// An util that used to get a screen size [Breakpoint]
/// {@endtemplate}
abstract class ScreenSize {
  static const _tn = 360;
  static const _xs = 600;
  static const _sm = 1024;
  static const _md = 1440;
  static const _lg = 1920;

  /// Returns current screen size [Breakpoint]
  static Breakpoint getBreakpoint(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return _getBreakpointFromWidth(screenWidth);
  }

  static Breakpoint _getBreakpointFromWidth(double availableWidth) {
    if (availableWidth < _tn) {
      return Breakpoint.tn;
    } else if (availableWidth < _xs) {
      return Breakpoint.xs;
    } else if (availableWidth < _sm) {
      return Breakpoint.sm;
    } else if (availableWidth < _md) {
      return Breakpoint.md;
    } else if (availableWidth < _lg) {
      return Breakpoint.lg;
    }

    return Breakpoint.xl;
  }

  /// Runs a sync/async function depends on screen size
  static FutureOr<void> responsiveLayoutAction(
    BuildContext context, {
    ResponsiveLayoutActionFunction? tiny,
    ResponsiveLayoutActionFunction? extraSmall,
    ResponsiveLayoutActionFunction? small,
    ResponsiveLayoutActionFunction? medium,
    ResponsiveLayoutActionFunction? large,
    required ResponsiveLayoutActionFunction extraLarge,
  }) async {
    final breakpoint = getBreakpoint(context);

    ResponsiveLayoutActionFunction function;

    if (breakpoint.index <= Breakpoint.tn.index && tiny != null) {
      function = tiny;
    } else if (breakpoint.index <= Breakpoint.xs.index && extraSmall != null) {
      function = extraSmall;
    } else if (breakpoint.index <= Breakpoint.sm.index && small != null) {
      function = small;
    } else if (breakpoint.index <= Breakpoint.md.index && medium != null) {
      function = medium;
    } else if (breakpoint.index <= Breakpoint.lg.index && large != null) {
      function = large;
    } else {
      function = extraLarge;
    }

    await function(context, breakpoint);
  }
}

/// Signature for the individual builders (`small`, `medium`, `large`, etc.).
typedef ResponsiveLayoutWidgetBuilder = Widget Function(BuildContext context, Widget? child);

/// {@template responsive_layout_builder}
/// A wrapper around [LayoutBuilder] which exposes builders for
/// various responsive breakpoints.
/// {@endtemplate}
class ResponsiveLayoutBuilder extends StatelessWidget {
  /// {@macro responsive_layout_builder}
  const ResponsiveLayoutBuilder({
    Key? key,
    this.tiny,
    this.extraSmall,
    this.small,
    this.medium,
    this.large,
    required this.extraLarge,
    this.child,
  }) : super(key: key);

  /// [ResponsiveLayoutWidgetBuilder] for tiny layout.
  final ResponsiveLayoutWidgetBuilder? tiny;

  /// [ResponsiveLayoutWidgetBuilder] for extra small layout.
  final ResponsiveLayoutWidgetBuilder? extraSmall;

  /// [ResponsiveLayoutWidgetBuilder] for small layout.
  final ResponsiveLayoutWidgetBuilder? small;

  /// [ResponsiveLayoutWidgetBuilder] for medium layout.
  final ResponsiveLayoutWidgetBuilder? medium;

  /// [ResponsiveLayoutWidgetBuilder] for large layout.
  final ResponsiveLayoutWidgetBuilder? large;

  /// [ResponsiveLayoutWidgetBuilder] for extra large layout.
  final ResponsiveLayoutWidgetBuilder extraLarge;

  /// Optional child widget builder based on the current layout size
  /// which will be passed to the specific size builders
  /// as a way to share/optimize shared layout.
  final Widget Function(Breakpoint breakpoint)? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final breakpoint = ScreenSize.getBreakpoint(context);

        Widget Function(BuildContext, Widget?) builder;

        if (breakpoint.index <= Breakpoint.tn.index && tiny != null) {
          builder = tiny!;
        } else if (breakpoint.index <= Breakpoint.xs.index && extraSmall != null) {
          builder = extraSmall!;
        } else if (breakpoint.index <= Breakpoint.sm.index && small != null) {
          builder = small!;
        } else if (breakpoint.index <= Breakpoint.md.index && medium != null) {
          builder = medium!;
        } else if (breakpoint.index <= Breakpoint.lg.index && large != null) {
          builder = large!;
        } else {
          builder = extraLarge;
        }

        return builder(context, child?.call(breakpoint));
      },
    );
  }
}
