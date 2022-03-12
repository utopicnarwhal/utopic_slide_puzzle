import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utopic_slide_puzzle/l10n/generated/l10n.dart';

/// {@template about_the_app_dialog}
/// Contains [SimpleDialog] widget with information about the app. Like version, developer, licenses, etc.
/// {@endtemplate}
class AboutTheAppDialog extends StatelessWidget {
  /// {@macro about_the_app_dialog}
  const AboutTheAppDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Text(
              Dictums.of(context).aboutTheAppDialogTitle,
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
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              elevation: 12,
              child: SvgPicture.asset(
                Theme.of(context).brightness == Brightness.light
                    ? 'assets/images/app_icon_light.svg'
                    : 'assets/images/app_icon_dark.svg',
                width: 128,
                height: 128,
              ),
            ),
          ),
        ),
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, packageInfoSnapshot) {
            return Center(
              child: Text(
                packageInfoSnapshot.data?.version != null
                    ? '${Dictums.of(context).appVersionTitle} ${packageInfoSnapshot.data?.version}'
                    : '',
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
        const Gap(8),
        const Divider(height: 12),
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/utopic_narwhal.png'),
          ),
          title: Text(Dictums.of(context).developerNameHeadline),
          subtitle: const Text('Sergei Danilov'),
          onTap: () async {
            const url = 'https://github.com/utopicnarwhal';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(Dictums.of(context).cannotOpenUrl),
                ),
              );
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.source_rounded),
          title: Text(Dictums.of(context).sourceCodeRepository),
          onTap: () async {
            const sourceCodeRepositoryUrl = 'https://github.com/utopicnarwhal/utopic_slide_puzzle';
            if (await canLaunch(sourceCodeRepositoryUrl)) {
              await launch(sourceCodeRepositoryUrl);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(Dictums.of(context).cannotOpenUrl),
                ),
              );
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.local_police_rounded),
          title: Text(Dictums.of(context).mainMenuLicensesButton),
          onTap: () {
            showLicensePage(context: context);
          },
        ),
      ],
    );
  }
}
