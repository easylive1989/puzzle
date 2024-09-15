import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/puzzle/data/puzzle_db_repository.dart';
import 'package:puzzle/puzzle/data/puzzle_repository.dart';
import 'package:puzzle/puzzle/data/source/app_database.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/domain/move_tile_use_case.dart';
import 'package:puzzle/puzzle/domain/tiles_generator.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/view/play_puzzle_page.dart';

import '../../../domain/entity/puzzle_factory.dart';
import '../../../../widget_test_utils.dart';

late MockTilesGenerator _mockTilesGenerator;
late PuzzleRepository _puzzleRepository;
late MockNavigator _navigator;

main() {
  setUp(() {
    _mockTilesGenerator = MockTilesGenerator();
    var appDatabase = AppDatabase(NativeDatabase.memory());
    _puzzleRepository = PuzzleDbRepository(appDatabase.puzzleGamesDao);
    _navigator = MockNavigator();
  });

  testWidgets("finish game when game over", (tester) async {
    _givenCanPop(true);

    await _givenPuzzle(puzzle(
      type: PuzzleType.number,
      tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
    ));

    await _givenPlayPuzzlePage(tester);

    await tester.tap(find.text(l10n.finish_game));

    verify(() => _navigator.pop(true)).called(1);
  });
}

void _givenCanPop(bool canPop) {
  when(_navigator.canPop).thenReturn(canPop);
}

Future<void> _givenPlayPuzzlePage(WidgetTester tester) async {
  await tester.givenView(MultiProvider(
      providers: [
        Provider.value(value: _puzzleRepository),
        Provider.value(value: MoveTileUseCase(_puzzleRepository)),
      ],
      child: MockNavigatorProvider(
        navigator: _navigator,
        child: const PlayPuzzlePage(id: 1),
      )));
  await tester.pump();
}

Future<void> _givenPuzzle(Puzzle initPuzzle) async {
  when(() => _mockTilesGenerator.generate(any()))
      .thenReturn([1, 2, 3, 4, 5, 6, 7, 0, 8]);
  await _puzzleRepository.create(initPuzzle);
}

class MockTilesGenerator extends Mock implements TilesGenerator {}
