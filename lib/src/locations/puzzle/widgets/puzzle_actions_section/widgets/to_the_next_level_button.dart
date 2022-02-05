part of '../../../puzzle_page.dart';

class _ToTheNextLevelButton extends StatelessWidget {
  const _ToTheNextLevelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(Dictums.of(context).nextLevelButtonLabel),
      backgroundColor: Theme.of(context).primaryColor,
      icon: const Icon(Icons.arrow_forward_rounded),
      onPressed: () {
        BlocProvider.of<PuzzleBloc>(context).reset();
      },
    );
  }
}
