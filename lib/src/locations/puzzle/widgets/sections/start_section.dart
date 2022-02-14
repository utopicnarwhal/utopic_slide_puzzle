part of '../../puzzle_page.dart';

/// {@template simple_start_section}
/// Displays the start section of the puzzle based on [BlocProvider]'s bloc state.
/// {@endtemplate}
class _StartSection extends StatelessWidget {
  /// {@macro simple_start_section}
  const _StartSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      extraLarge: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child!,
            const Gap(20),
            const _PuzzleActionsSection(),
          ],
        ),
      ),
      child: (_) => const _PuzzleInfoArea(),
    );
  }
}
