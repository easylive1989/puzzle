import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/move_tile_use_case.dart';
import 'package:puzzle/puzzle/data/puzzle_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'entity/puzzle_factory.dart';

late MoveTileUseCase _puzzleUseCase;
late MockPuzzleRepository _mockPuzzleRepository;
final DateTime createdAt = DateTime.parse("2024-05-31");
final DateTime now = DateTime.parse("2024-06-01");
main() {
  setUp(() {
    _mockPuzzleRepository = MockPuzzleRepository();
    _puzzleUseCase = MoveTileUseCase(_mockPuzzleRepository);
    registerFallbackValue(_MockPuzzle());
    _givenSaveOk();
  });

  test("should not move when game over", () async {
    _givenPuzzle(puzzle(
      tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
      updatedAt: createdAt,
    ));

    await _puzzleUseCase.move(1, 8);

    verifyNever(() => _mockPuzzleRepository.save(any()));
  });

  test("should update puzzle when game is not over", () async {
    withClock(Clock.fixed(now), () async {
      _givenPuzzle(puzzle(
        tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
        updatedAt: createdAt,
      ));

      await _puzzleUseCase.move(1, 8);

      verify(() => _mockPuzzleRepository.save(puzzle(
            tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
            updatedAt: now,
          ))).called(1);
    });
  });
}

void _givenSaveOk() {
  when(() => _mockPuzzleRepository.save(any()))
      .thenAnswer((invocation) async => 0);
}

void _givenPuzzle(Puzzle puzzle) {
  when(() => _mockPuzzleRepository.get(any())).thenAnswer((invocation) async {
    return puzzle;
  });
}

class MockPuzzleRepository extends Mock implements PuzzleRepository {}

class _MockPuzzle extends Mock implements Puzzle {}
