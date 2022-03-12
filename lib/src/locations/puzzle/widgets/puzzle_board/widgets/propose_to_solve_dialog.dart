part of '../puzzle_board.dart';

class _ProposeToSolveDialog extends StatelessWidget {
  const _ProposeToSolveDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(Dictums.of(context).proposeToSolveDialogTitle),
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                Dictums.of(context).proposeToSolveDialogBody,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const Gap(16),
            Wrap(
              alignment: WrapAlignment.end,
              runAlignment: WrapAlignment.end,
              spacing: 12,
              runSpacing: 8,
              children: [
                UtopicButton(
                  type: UtopicButtonType.text,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  text: Dictums.of(context).no,
                ),
                UtopicButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  text: Dictums.of(context).yes,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
