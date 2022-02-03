part of '../../puzzle_page.dart';

class _EndSection extends StatelessWidget {
  const _EndSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: ResponsiveLayoutBuilder(
        medium: (_, __) => const _ToTheNextLevelButton(),
        extraLarge: (_, __) => const SizedBox(),
      ),
    );
  }
}
