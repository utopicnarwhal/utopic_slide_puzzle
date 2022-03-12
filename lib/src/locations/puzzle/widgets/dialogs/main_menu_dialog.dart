part of '../../puzzle_page.dart';

class _MainMenuDialog extends StatefulWidget {
  const _MainMenuDialog({Key? key}) : super(key: key);

  @override
  __MainMenuDialogState createState() => __MainMenuDialogState();
}

class __MainMenuDialogState extends State<_MainMenuDialog> {
  late BehaviorSubject<int> _soundFxVolumeController;

  @override
  void initState() {
    super.initState();

    _soundFxVolumeController = BehaviorSubject()
      ..listen((value) async {
        await AudioService.instance.setVolumeForFx(value / 100);
        await LocalStorageService.writeCurrentSoundFXVolume(value / 100);
      });
    LocalStorageService.readCurrentSoundFXVolume().then((value) => _soundFxVolumeController.add((value * 100).round()));
  }

  @override
  void dispose() {
    _soundFxVolumeController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        Dictums.of(context).mainMenuDialogTitle,
        textAlign: TextAlign.center,
      ),
      children: [
        ListTile(
          leading: const Icon(Icons.grid_view_rounded),
          title: Text(Dictums.of(context).mainMenuSelectLevelButton),
          iconColor: Theme.of(context).iconTheme.color,
          onTap: () {
            showDialog<PuzzleLevels>(
              context: context,
              builder: (context) => const _SelectLevelDialog(),
            ).then((result) {
              if (result != null) {
                Navigator.of(context).pop(result);
              }
            });
          },
        ),
        const Divider(height: 12),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            Dictums.of(context).mainMenuSoundVolumeSliderLabel,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              const Icon(Icons.volume_mute_rounded),
              StreamBuilder<int>(
                stream: _soundFxVolumeController,
                builder: (context, soundFxVolumeSnapshot) {
                  if (soundFxVolumeSnapshot.data == null) {
                    return const SizedBox();
                  }
                  return Slider(
                    value: soundFxVolumeSnapshot.data?.toDouble() ?? 0,
                    divisions: 10,
                    max: 100,
                    onChanged: (newValue) {
                      _soundFxVolumeController.add(newValue.round());
                    },
                  );
                },
              ),
              const Icon(Icons.volume_up_rounded),
            ],
          ),
        ),
        const ThemeModeSwitcher(),
        ListTile(
          leading: const Icon(Icons.info_outline),
          iconColor: Theme.of(context).iconTheme.color,
          title: Text(Dictums.of(context).mainMenuAboutTheAppButton),
          onTap: () {
            showDialog<PuzzleLevels>(
              context: context,
              builder: (context) => const AboutTheAppDialog(),
            );
          },
        ),
        const Divider(height: 12),
        ListTile(
          leading: const Icon(Icons.done),
          iconColor: Theme.of(context).iconTheme.color,
          title: Text(Dictums.of(context).mainMenuResumeButton),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
