part of '../puzzle_page.dart';

class _MainMenuDialog extends StatefulWidget {
  const _MainMenuDialog({Key? key}) : super(key: key);

  @override
  __MainMenuDialogState createState() => __MainMenuDialogState();
}

class __MainMenuDialogState extends State<_MainMenuDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text(
        'Paused',
        textAlign: TextAlign.center,
      ),
      children: [
        ListTile(
          leading: const Icon(Icons.login),
          title: const Text('Login'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.grid_view_rounded),
          title: const Text('Select level'),
          onTap: () {},
        ),
        const Divider(height: 24),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About the app'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.local_police_rounded),
          title: const Text('Licenses'),
          onTap: () {
            showLicensePage(context: context);
          },
        ),
        const Divider(height: 24),
        ListTile(
          leading: const Icon(Icons.done),
          title: const Text('Resume'),
          onTap: () {
            showLicensePage(context: context);
          },
        ),
      ],
    );
  }
}
