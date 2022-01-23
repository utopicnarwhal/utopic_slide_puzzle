import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:utopic_slide_puzzle/l10n/generated/l10n.dart';

/// {@template puzzle_page}
/// A location for an unknown url.
///
/// Builds the [_PageNotFoundPage]
/// {@endtemplate}
class PageNotFoundLocation extends BeamLocation<BeamState> {
  /// Url path of the location
  static const path = '/page_not_found';

  @override
  List<String> get pathPatterns => [path];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('page_not_found'),
          child: _PageNotFoundPage(),
        )
      ];
}

class _PageNotFoundPage extends StatelessWidget {
  /// {@macro puzzle_page}
  const _PageNotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Dictums.of(context).pageNotFound,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
