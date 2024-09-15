import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/domain/create_puzzle_use_case.dart';
import 'package:puzzle/puzzle/data/puzzle_repository.dart';
import 'package:puzzle/puzzle/domain/tiles_generator.dart';

late MockRandomGenerator _mockRandomGenerator;
late FakePuzzleRepository _puzzleRepository;
late CreatePuzzleUseCase _createPuzzleUseCase;

main() {
  setUp(() {
    _puzzleRepository = FakePuzzleRepository();
    _mockRandomGenerator = MockRandomGenerator();
    _createPuzzleUseCase =
        CreatePuzzleUseCase(_puzzleRepository, _mockRandomGenerator);
  });

  test("create puzzle", () async {
    withClock(Clock.fixed(now), () async {
      _givenRandomNumberList([1, 2, 3, 4, 5, 6, 7, 0, 8]);

      var id = await _createPuzzleUseCase.create(PuzzleType.number);

      expect(await _puzzleRepository.getAll(), [
        Puzzle(
          id: id,
          type: PuzzleType.number,
          tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
          createdAt: now,
          updatedAt: now,
        )
      ]);
    });
  });

  test("create puzzle when it generates invalid first", () async {
    withClock(Clock.fixed(now), () async {
      final responses = [
        [1, 2, 3, 4, 5, 6, 8, 7, 0],
        [1, 2, 3, 4, 5, 6, 7, 0, 8],
      ];

      when(() => _mockRandomGenerator.generate(any()))
          .thenAnswer((_) => responses.removeAt(0));

      var id = await _createPuzzleUseCase.create(PuzzleType.number);

      expect(await _puzzleRepository.getAll(), [
        Puzzle(
          id: id,
          type: PuzzleType.number,
          tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
          createdAt: now,
          updatedAt: now,
        )
      ]);
    });
  });
}

DateTime get now => DateTime.parse("2024-06-01");

void _givenRandomNumberList(List<int> list) {
  when(() => _mockRandomGenerator.generate(any())).thenReturn(list);
}

class MockRandomGenerator extends Mock implements TilesGenerator {}

class FakePuzzleRepository extends Fake implements PuzzleRepository {
  Puzzle? puzzle;

  @override
  Future<Puzzle> get(int id) async {
    return puzzle!;
  }

  @override
  Future<void> save(Puzzle puzzle) async {
    this.puzzle = puzzle;
  }

  @override
  Future<int> create(Puzzle puzzle) async {
    this.puzzle = puzzle;
    return puzzle.id;
  }

  @override
  Future<List<Puzzle>> getAll() async {
    return [puzzle!];
  }
}
