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
        return UtopicButton(
          leading: const Icon(Icons.image),
          text: Dictums.of(context).uploadCustomImageButtonLabel,
          isLoading: loadingSnapshot.data == true,
          onPressed: () async {
            final puzzlePageBloc = BlocProvider.of<PuzzlePageBloc>(context);
            _loadingController.add(true);
            try {
              final result = await FilePicker.platform.pickFiles(type: FileType.image);

              final allowedExtensionsList =
                  ['png', 'jpg', 'jpeg'].expand((element) => [element, element.toUpperCase()]).toList();

              if (result == null) {
                _loadingController.add(false);
                return;
              }

              if (!allowedExtensionsList.contains(result.files.single.extension)) {
                if (!mounted) {
                  return;
                }
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(Dictums.of(context).onlyPngAndJpgFormatsSupported),
                  ),
                );
                _loadingController.add(false);
                return;
              }

              Uint8List? bytes;
              if (result.files.single.bytes != null) {
                bytes = result.files.single.bytes;
              } else if (result.files.single.path != null) {
                bytes = await File(result.files.single.path!).readAsBytes();
              }
              if (bytes == null) {
                if (!mounted) {
                  return;
                }
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(Dictums.of(context).onlyPngAndJpgFormatsSupported),
                  ),
                );
                _loadingController.add(false);
                return;
              }
              if (!puzzlePageBloc.isClosed) {
                puzzlePageBloc.addImageToPuzzleWithImageBloc(bytes);
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
