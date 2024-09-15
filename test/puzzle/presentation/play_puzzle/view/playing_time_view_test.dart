import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/view/playing_time_view.dart';

import '../../../../widget_test_utils.dart';
import '../bloc/current_puzzle_factory.dart';

main() {
  testWidgets("00:05", (tester) async {
    await tester.givenView(PlayingTimeView(
      puzzle: gameOverCurrentPuzzle(
        createdAt: DateTime.parse("2024-06-01 00:00:00"),
        updatedAt: DateTime.parse("2024-06-01 00:00:05"),
      ),
    ));

    expect(find.text(l10n.playing_time("00:05")), findsOneWidget);
  });

  testWidgets("10:00", (tester) async {
    await tester.givenView(PlayingTimeView(
      puzzle: gameOverCurrentPuzzle(
        createdAt: DateTime.parse("2024-06-01 00:00:00"),
        updatedAt: DateTime.parse("2024-06-01 00:10:00"),
      ),
    ));

    expect(find.text(l10n.playing_time("10:00")), findsOneWidget);

  });

  testWidgets("1:10:00", (tester) async {
    await tester.givenView(PlayingTimeView(
      puzzle: gameOverCurrentPuzzle(
        createdAt: DateTime.parse("2024-06-01 00:00:00"),
        updatedAt: DateTime.parse("2024-06-01 01:10:00"),
      ),
    ));

    expect(find.text(l10n.playing_time("01:10:00")), findsOneWidget);
  });

  testWidgets("99:00:59", (tester) async {
    await tester.givenView(PlayingTimeView(
      puzzle: gameOverCurrentPuzzle(
        createdAt: DateTime.parse("2024-06-01 00:00:00"),
        updatedAt: DateTime.parse("2024-06-05 03:00:59"),
      ),
    ));

    expect(find.text(l10n.playing_time("99:00:59")), findsOneWidget);
  });

  testWidgets("over 99:59:59", (tester) async {
    await tester.givenView(PlayingTimeView(
      puzzle: gameOverCurrentPuzzle(
        createdAt: DateTime.parse("2024-06-01 00:00:00"),
        updatedAt: DateTime.parse("2024-06-09 08:00:00"),
      ),
    ));

    expect(find.text(l10n.playing_time("99:59:59")), findsOneWidget);
  });
}

