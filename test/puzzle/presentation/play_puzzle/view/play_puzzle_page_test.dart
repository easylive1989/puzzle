import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/gen/assets.gen.dart';
import 'package:puzzle/puzzle/data/puzzle_db_repository.dart';
import 'package:puzzle/puzzle/data/puzzle_repository.dart';
import 'package:puzzle/puzzle/data/source/app_database.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/domain/move_tile_use_case.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/view/play_puzzle_page.dart';

import '../../../domain/entity/puzzle_factory.dart';
import '../../../../widget_test_utils.dart';

late PuzzleRepository _puzzleRepository;
var tileSize = 90.0;
main() {
  setUp(() {
    final appDatabase = AppDatabase(NativeDatabase.memory());
    _puzzleRepository = PuzzleDbRepository(appDatabase.puzzleGamesDao);
  });

  group("undo", () {
    testWidgets("move number tile and undo", (tester) async {
      _givenPuzzle(puzzle(
        type: PuzzleType.number,
        tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
      ));

      await _givenPlayPuzzlePage(tester);

      await _whenMove(tester, tile: "7");

      await _whenUndo(tester);

      _puzzleShouldBe(tester, [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "x", "8"],
      ]);
    });

    testWidgets("undo before move any tile", (tester) async {
      _givenPuzzle(puzzle(
        type: PuzzleType.number,
        tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
      ));

      await _givenPlayPuzzlePage(tester);

      await _whenUndo(tester);

      _puzzleShouldBe(tester, [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "x", "8"],
      ]);
    });

    testWidgets("move three times and undo twice", (tester) async {
      _givenPuzzle(puzzle(
        type: PuzzleType.number,
        tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
      ));

      await _givenPlayPuzzlePage(tester);

      await _whenMove(tester, tile: "7");
      await _whenMove(tester, tile: "4");
      await _whenMove(tester, tile: "1");

      await _whenUndo(tester);
      await _whenUndo(tester);

      _puzzleShouldBe(tester, [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["x", "7", "8"],
      ]);
    }, skip: true);
  });

  group("playing time", () {
    testWidgets("show playing time when game is ongoing", (tester) async {
      withClock(Clock.fixed(DateTime.parse("2024-06-01 00:10:00")), () async {
        await _givenPuzzle(ongoingPuzzle(
          createdAt: DateTime.parse("2024-06-01 00:00:00"),
          updatedAt: DateTime.parse("2024-06-01 00:00:00"),
        ));

        await _givenPlayPuzzlePage(tester);

        expect(find.text(l10n.playing_time("10:00")), findsOneWidget);
      });
    });

    testWidgets("stop playing time when game is over", (tester) async {
      withClock(Clock.fixed(DateTime.parse("2024-06-01 00:40:00")), () async {
        _givenPuzzle(gameOverPuzzle(
          createdAt: DateTime.parse("2024-06-01 00:00:00"),
          updatedAt: DateTime.parse("2024-06-01 00:20:00"),
        ));

        await _givenPlayPuzzlePage(tester);

        expect(find.text(l10n.playing_time("20:00")), findsOneWidget);
      });
    });
  });

  group("move tile", () {
    testWidgets("move number tile", (tester) async {
      _givenPuzzle(puzzle(
        type: PuzzleType.number,
        tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
      ));

      await _givenPlayPuzzlePage(tester);

      await _whenMove(tester, tile: "8");

      _puzzleShouldBe(tester, [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "x"],
      ]);
    });

    testWidgets("move number tile and tile animate to half", (tester) async {
      _givenPuzzle(puzzle(
        type: PuzzleType.number,
        tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
      ));

      await _givenPlayPuzzlePage(tester);

      await _whenMove(tester, tile: "8", elapsedMilliseconds: 100);

      expect(
        _findNumberPosition(tester, "8"),
        isTilePositionedAt(top: 2 * tileSize, left: 1.5 * tileSize),
      );
    });

    testWidgets("move image tile fail", (tester) async {
      _givenPuzzle(puzzle(
        type: PuzzleType.image,
        tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
      ));

      await _givenPlayPuzzlePage(tester);

      await _whenMoveImage(tester, tile: Assets.puzzleImg1.path);

      expect(find.text(l10n.move_tile_error), findsOneWidget);
    });
  });

}

Future<void> _whenUndo(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.undo));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 1000));
}

void _puzzleShouldBe(WidgetTester tester, List<List<String>> puzzle) {
  for (var row = 0; row < puzzle.length; row++) {
    for (var column = 0; column < puzzle[row].length; column++) {
      if (puzzle[row][column] == "x") continue;

      _numberShouldBe(
        tester: tester,
        number: puzzle[row][column],
        row: row,
        column: column,
      );
    }
  }
}

Future<void> _whenMove(
  WidgetTester tester, {
  required String tile,
  int elapsedMilliseconds = 1000,
}) async {
  await tester.tap(find.text(tile));
  await tester.pump();
  await tester.pump(Duration(milliseconds: elapsedMilliseconds));
}

Future<void> _whenMoveImage(
  WidgetTester tester, {
  required String tile,
  int elapsedMilliseconds = 1000,
}) async {
  await tester.tap(find.image(AssetImage(tile)));
  await tester.pump();
  await tester.pump(Duration(milliseconds: elapsedMilliseconds));
}

Future<void> _givenPuzzle(Puzzle puzzle) async {
  await _puzzleRepository.create(puzzle);
}

Future<void> _givenPlayPuzzlePage(WidgetTester tester) async {
  await tester.givenView(MultiProvider(providers: [
    Provider<PuzzleRepository>.value(
      value: _puzzleRepository,
    ),
    Provider<MoveTileUseCase>.value(
      value: MoveTileUseCase(_puzzleRepository),
    ),
  ], child: const PlayPuzzlePage(id: 1)));
  await tester.pump();
}

void _numberShouldBe({
  required WidgetTester tester,
  required String number,
  required int row,
  required int column,
}) {
  final numberPositioned = _findNumberPosition(tester, number);
  expect(
    numberPositioned,
    isTilePositionedAt(top: row * tileSize, left: column * tileSize),
  );
}

Positioned _findNumberPosition(WidgetTester tester, String number) {
  return tester.widget<Positioned>(find.ancestor(
    of: find.text(number),
    matching: find.byType(Positioned),
  ));
}

TilePositionedMatcher isTilePositionedAt({
  required double top,
  required double left,
}) {
  return TilePositionedMatcher(top: top, left: left);
}

class TilePositionedMatcher extends Matcher {
  final double top;
  final double left;

  TilePositionedMatcher({
    required this.top,
    required this.left,
  });

  @override
  bool matches(covariant Positioned positioned, Map matchState) {
    return positioned.top == top && positioned.left == left;
  }

  @override
  Description describe(Description description) {
    return description.add("tile positioned should be top: $top, left: $left");
  }
}
