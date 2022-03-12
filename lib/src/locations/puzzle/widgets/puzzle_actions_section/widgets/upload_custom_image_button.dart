part of '../../../puzzle_page.dart';

class _UploadCustomImageButton extends StatefulWidget {
  const _UploadCustomImageButton({Key? key}) : super(key: key);

  @override
  State<_UploadCustomImageButton> createState() => _UploadCustomImageButtonState();
}

class _UploadCustomImageButtonState extends State<_UploadCustomImageButton> {
  late BehaviorSubject<bool> _loadingController;

  @override
  void initState() {
    super.initState();
    _loadingController = BehaviorSubject.seeded(false);
  }

  @override
  void dispose() {
    _loadingController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _loadingController,
      builder: (context, loadingSnapshot) {
        return FloatingActionButton.extended(
          label: Text(Dictums.of(context).uploadCustomImageButtonLabel),
          backgroundColor: Theme.of(context).primaryColor,
          icon: loadingSnapshot.data == true
              ? LoadingIndicator(
                  color: Theme.of(context).primaryIconTheme.color,
                  size: 24,
                )
              : const Icon(Icons.image),
          onPressed: loadingSnapshot.data == true
              ? () {}
              : () async {
                  final puzzlePageBloc = BlocProvider.of<PuzzlePageBloc>(context);
                  _loadingController.add(true);
                  try {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: [
                        'png',
                        'jpg',
                        'jpeg',
                      ].expand((element) => [element, element.toUpperCase()]).toList(),
                    );

                    if (result?.files.single.bytes != null) {
                      if (!puzzlePageBloc.isClosed) {
                        puzzlePageBloc.addImageToPuzzleWithImageBloc(result!.files.single.bytes!);
                      }
                    }
                  } on Exception catch (exception) {
                    debugPrint(exception.toString());
                  }
                  _loadingController.add(false);
                },
        );
      },
    );
  }
}
