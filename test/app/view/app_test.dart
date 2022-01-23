
import 'package:flutter_test/flutter_test.dart';
import 'package:utopic_slide_puzzle/src/app.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/puzzle.dart';

void main() {
  group('App', () {
    testWidgets('renders PuzzlePage', (tester) async {
      await tester.pumpWidget(const UtopicSlidePuzzleApp());
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(PuzzlePage), findsOneWidget);
    });
  });
}
