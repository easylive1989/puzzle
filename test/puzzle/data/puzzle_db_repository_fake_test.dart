import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle/puzzle/data/puzzle_db_dto.dart';
import 'package:puzzle/puzzle/data/source/puzzle_games_dao.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/data/puzzle_db_repository.dart';

import '../domain/entity/puzzle_factory.dart';

late PuzzleGamesDao _puzzleGamesDao;

main() {
  setUp(() {
    _puzzleGamesDao = FakePuzzleGamesDao();
  });

  test("save puzzle", () async {
    var puzzleDbRepository = PuzzleDbRepository(_puzzleGamesDao);

    int id = await puzzleDbRepository.create(puzzle(
      type: PuzzleType.number,
      tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
    ));

    await puzzleDbRepository.save(Puzzle(
      id: id,
      type: PuzzleType.number,
      tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
      createdAt: DateTime.parse("2024-06-01"),
      updatedAt: DateTime.parse("2024-06-01"),
    ));

    expect(
      await puzzleDbRepository.get(id),
      equals(Puzzle(
        id: id,
        type: PuzzleType.number,
        tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
        createdAt: DateTime.parse("2024-06-01"),
        updatedAt: DateTime.parse("2024-06-01"),
      )),
    );
  });

  test("create puzzle", () async {
    var puzzleDbRepository = PuzzleDbRepository(FakePuzzleGamesDao());

    int id = await puzzleDbRepository.create(Puzzle(
      id: 1,
      type: PuzzleType.number,
      tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
      createdAt: DateTime.parse("2024-06-01"),
      updatedAt: DateTime.parse("2024-06-01"),
    ));

    var puzzle = await puzzleDbRepository.get(id);
    expect(
      puzzle,
      equals(Puzzle(
        id: 1,
        type: PuzzleType.number,
        tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
        createdAt: DateTime.parse("2024-06-01"),
        updatedAt: DateTime.parse("2024-06-01"),
      )),
    );
  });
}

class FakePuzzleGamesDao extends Fake implements PuzzleGamesDao {
  Map<int, PuzzleDbDto> puzzles = {};

  @override
  Future<int> insert(PuzzleDbDto puzzle) async {
    puzzles[puzzle.id] = puzzle;
    return puzzle.id;
  }

  @override
  Future<void> updatePuzzle(PuzzleDbDto puzzle) async =>
      puzzles[puzzle.id] = puzzle;

  @override
  Future<PuzzleDbDto> get(int id) async => puzzles[id]!;

  @override
  Future<List<PuzzleDbDto>> getAll() async => puzzles.values.toList();
}
