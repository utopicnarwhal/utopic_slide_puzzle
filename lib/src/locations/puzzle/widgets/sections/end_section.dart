part of '../../puzzle_page.dart';

class _EndSection extends StatelessWidget {
  const _EndSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      medium: (_, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          children: [
            const _PuzzleActionsSection(),
            const Gap(16),
            child!,
          ],
        ),
      ),
      extraLarge: (_, child) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(child: child),
      ),
      child: (_) => const _LevelHintsArea(),
    );
  }
}
