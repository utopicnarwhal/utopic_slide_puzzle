part of '../puzzle_page.dart';

/// {@template puzzle_title}
/// Displays the title of the puzzle in the given color.
/// {@endtemplate}
class _PuzzleTitle extends StatelessWidget {
  /// {@macro puzzle_title}
  const _PuzzleTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  /// The title to be displayed.
  final String title;

  @override
  Widget build(BuildContext context) {
    const primaryColor = UtopicPalette.utopicPrimary;
    TextStyle? textStyle;

    return ResponsiveLayoutBuilder(
      medium: (context, child) {
        textStyle = Theme.of(context).textTheme.headline3;

        return Center(
          child: SizedBox(
            height: 60,
            child: child,
          ),
        );
      },
      extraLarge: (context, child) {
        textStyle = Theme.of(context).textTheme.headline2;
        return SizedBox(
          height: 80,
          child: child,
        );
      },
      child: (_) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.bottomLeft,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeInCubic,
            switchOutCurve: Curves.easeOutCubic,
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(animation),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: Text(
              title,
              key: Key(title),
              maxLines: 1,
              style: textStyle?.copyWith(color: primaryColor),
            ),
          ),
        );
      },
    );
  }
}
