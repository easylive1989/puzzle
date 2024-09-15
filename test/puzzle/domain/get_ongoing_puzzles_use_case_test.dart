import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/get_ongoing_puzzles_use_case.dart';
import 'package:puzzle/puzzle/data/puzzle_repository.dart';

import 'entity/puzzle_factory.dart';


late GetOngoingPuzzlesUseCase _puzzleUseCase;
late StubPuzzleRepository _puzzleRepository;

main() {
  setUp(() {
    _puzzleRepository = StubPuzzleRepository();
    _puzzleUseCase = GetOngoingPuzzlesUseCase(_puzzleRepository);
  });

  test("get ongoing puzzles", () async {
    _givenPuzzleList([
      ongoingPuzzle(),
      gameOverPuzzle(),
    ]);

    expect(await _puzzleUseCase.get(), [
      ongoingPuzzle(),
    ]);
  });
}

void _givenPuzzleList(List<Puzzle> puzzles) {
  _puzzleRepository.puzzles = puzzles;
}

class StubPuzzleRepository implements PuzzleRepository {
  List<Puzzle> puzzles = [];
  Puzzle? puzzle;

  @override
  Future<List<Puzzle>> getAll() async => puzzles;

  @override
  Future<Puzzle> get(int id) async => throw UnimplementedError();

  @override
  Future<int> save(Puzzle puzzle) => throw UnimplementedError();

  @override
  Future<int> create(Puzzle puzzle) => throw UnimplementedError();
}
