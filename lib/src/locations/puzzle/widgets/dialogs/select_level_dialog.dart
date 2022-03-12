part of '../../puzzle_page.dart';

class _SelectLevelDialog extends StatelessWidget {
  const _SelectLevelDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var thumbnailSideLength = 64.0;
    var borderRadius = 16.0;
    var thumbnailSpacing = 8;

    return ResponsiveLayoutBuilder(
      extraSmall: (context, child) => child!,
      medium: (context, child) {
        thumbnailSideLength = 80;
        borderRadius = 20;
        thumbnailSpacing = 10;
        return child!;
      },
      extraLarge: (context, child) {
        thumbnailSideLength = 128;
        borderRadius = 24;
        thumbnailSpacing = 12;
        return child!;
      },
      child: (breakpoint) {
        final wrapMaxWidth = (2 * thumbnailSpacing) + (thumbnailSideLength * 3);
        return SimpleDialog(
          title: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Text(
                  Dictums.of(context).levelSelectionDialogTitle,
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: wrapMaxWidth),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    for (var level in PuzzleLevels.values)
                      SizedBox(
                        height: thumbnailSideLength,
                        width: thumbnailSideLength,
                        child: ElevatedButton(
                          clipBehavior: Clip.hardEdge,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Theme.of(context).primaryColor,
                            textStyle: Theme.of(context).textTheme.headline2?.copyWith(fontWeight: FontWeight.w600),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(borderRadius),
                              ),
                            ),
                            padding: EdgeInsets.zero,
                          ).copyWith(
                            elevation: MaterialStateProperty.resolveWith(
                              (states) => [
                                MaterialState.focused,
                                MaterialState.hovered,
                                MaterialState.selected,
                                MaterialState.pressed,
                              ].any((element) => states.contains(element))
                                  ? 8
                                  : 0,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(level);
                          },
                          child: _LevelThumbnail(puzzleLevel: level),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LevelThumbnail extends StatelessWidget {
  const _LevelThumbnail({required this.puzzleLevel, Key? key}) : super(key: key);

  final PuzzleLevels puzzleLevel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (puzzleLevel) {
          case PuzzleLevels.number:
            return Text(
              '1',
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              maxLines: 1,
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: constraints.maxHeight / 2.2,
              ),
            );
          case PuzzleLevels.image:
            return Icon(
              Icons.image_rounded,
              size: constraints.maxHeight / 2.2,
            );
          case PuzzleLevels.swaps:
            return Icon(
              Icons.numbers_rounded,
              size: constraints.maxHeight / 2.2,
            );
          case PuzzleLevels.trafficLight:
            return Icon(
              Icons.traffic_rounded,
              size: constraints.maxHeight / 2.2,
            );
          case PuzzleLevels.remember:
            return Icon(
              Icons.opacity_rounded,
              size: constraints.maxHeight / 2.2,
            );
          case PuzzleLevels.pianoNotes:
            return Icon(
              Icons.music_note_rounded,
              size: constraints.maxHeight / 2.2,
            );
        }
      },
    );
  }
}
