part of '../../../puzzle_page.dart';

class _ShuffleButton extends StatelessWidget {
  const _ShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(Dictums.of(context).shuffleButtonText),
      backgroundColor: Theme.of(context).primaryColor,
      icon: const Icon(Icons.refresh),
      onPressed: () {
        BlocProvider.of<PuzzleBloc>(context).reset();
      },
    );
  }
}
