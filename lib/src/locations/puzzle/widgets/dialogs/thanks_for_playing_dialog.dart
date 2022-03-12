part of '../../puzzle_page.dart';

class _ThanksForPlayingDialog extends StatefulWidget {
  const _ThanksForPlayingDialog({Key? key}) : super(key: key);

  @override
  State<_ThanksForPlayingDialog> createState() => _ThanksForPlayingDialogState();
}

class _ThanksForPlayingDialogState extends State<_ThanksForPlayingDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Text(
              Dictums.of(context).thanksForPlayingDialogTitle,
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            Dictums.of(context).thanksForPlayingMessagePart1,
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            Dictums.of(context).thanksForPlayingMessagePart2,
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Lottie.asset(
              'assets/animations/like.json',
              width: 64,
            ),
          ),
        ),
      ],
    );
  }
}
