part of '../puzzle_board.dart';

class _ProposeToSolveDialog extends StatelessWidget {
  const _ProposeToSolveDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Hm...'), // TODO(sergei): add to dictums
      children: [
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Seems like you are in rage. Do you want I'll solve this puzzle for you?", // TODO(sergei): add to dictums
              ),
            ),
            const Gap(16),
            Wrap(
              alignment: WrapAlignment.end,
              children: [
                UtopicButton(
                  type: UtopicButtonType.text,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  text: 'No', // TODO(sergei): add to dictums
                ),
                UtopicButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  text: 'Yes', // TODO(sergei): add to dictums
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
