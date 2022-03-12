import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
      title: Text(
        Dictums.of(context).aboutTheAppDialogTitle,
        textAlign: TextAlign.center,
      ),
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: AspectRatio(
              aspectRatio: 1,
              child: Card(
                elevation: 12,
                child: SvgPicture.asset(
                  Theme.of(context).brightness == Brightness.light
                      ? 'assets/images/app_icon_light.svg'
                      : 'assets/images/app_icon_dark.svg',
                ),
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
          onTap: () {
            showLicensePage(context: context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.local_police_rounded),
          title: Text(Dictums.of(context).mainMenuLicensesButton),
          onTap: () {
            showLicensePage(context: context);
          },
        ),
        const Divider(height: 12),
        ListTile(
          leading: const Icon(Icons.arrow_back_rounded),
          title: Text(MaterialLocalizations.of(context).backButtonTooltip),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
