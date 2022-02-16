part of '../../puzzle_page.dart';

class _LevelHintsArea extends StatelessWidget {
  const _LevelHintsArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzlePageBloc, PuzzlePageBlocState>(
      builder: (context, puzzlePageBlocState) {
        Widget? result;
        if (puzzlePageBlocState is PuzzlePageBlocLevelState) {
          if (puzzlePageBlocState.level == PuzzleLevels.number) {
            result = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Dictums.of(context).additionalControlOptionsTitle, style: Theme.of(context).textTheme.headline5),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SvgPicture.asset(
                    'assets/images/keyboard_control_available.svg',
                    height: 156,
                  ),
                ),
              ],
            );
          } else if (puzzlePageBlocState.level == PuzzleLevels.image) {
            result = BlocBuilder<PuzzleBloc, PuzzleState>(
              bloc: puzzlePageBlocState.puzzleBloc,
              buildWhen: (oldState, newState) => oldState.resizedImage != newState.resizedImage,
              builder: (context, puzzleBlocState) {
                if (puzzleBlocState.resizedImage == null) {
                  return const SizedBox();
                }
                final image = puzzleBlocState.resizedImage!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${Dictums.of(context).imageReference}:',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const Gap(12),
                    Container(
                      padding: const EdgeInsets.all(2),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      foregroundDecoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 2,
                          ),
                        ),
                      ),
                      child: RawImage(
                        image: image,
                        fit: BoxFit.cover,
                        height: 312,
                        width: 312,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                  ],
                );
              },
            );
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeInCubic,
            switchOutCurve: Curves.easeOutCubic,
            child: result,
          );
        }
        return const SizedBox();
      },
    );
  }
}
