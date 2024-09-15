import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle/puzzle/data/source/app_database.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/data/puzzle_db_repository.dart';
import 'package:drift/native.dart';

import '../domain/entity/puzzle_factory.dart';

late AppDatabase _database;
late PuzzleDbRepository _puzzleDbRepository;

main() {
  setUp(() {
    _database = AppDatabase(NativeDatabase.memory());
    _puzzleDbRepository = PuzzleDbRepository(_database.puzzleGamesDao);
  });

  tearDown(() => _database.close());

  test("save puzzle", () async {
    DateTime now = DateTime.parse("2024-06-01");

    int id = await _puzzleDbRepository.create(Puzzle(
      type: PuzzleType.number,
      tiles: const [1, 2, 3, 4, 5, 6, 7, 0, 8],
      createdAt: now,
      updatedAt: now,
    ));

    await _puzzleDbRepository.save(Puzzle(
      id: id,
      type: PuzzleType.number,
      tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
      createdAt: now,
      updatedAt: now,
    ));

    expect(
      await _puzzleDbRepository.get(id),
      equals(Puzzle(
        id: id,
        type: PuzzleType.number,
        tiles: const [1, 2, 3, 4, 5, 6, 7, 8, 0],
        createdAt: now,
        updatedAt: now,
      )),
    );
  });

  test("create puzzle", () async {
    int id = await _puzzleDbRepository.create(puzzle(
      type: PuzzleType.number,
      tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
    ));

    var result = await _puzzleDbRepository.get(id);
    expect(result.tiles, equals([1, 2, 3, 4, 5, 6, 7, 8, 0]));
    expect(result.type, equals(PuzzleType.number));
  });

  test("get puzzle", () async {
    DateTime now = DateTime.parse("2024-06-01");

    int id = await _puzzleDbRepository.create(Puzzle(
      type: PuzzleType.number,
      tiles: const [1, 2, 3, 4, 5, 6, 7, 0, 8],
      createdAt: now,
      updatedAt: now,
    ));

    var result = await _puzzleDbRepository.get(id);

    expect(
      result,
      equals(Puzzle(
        id: id,
        type: PuzzleType.number,
        tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
        createdAt: now,
        updatedAt: now,
      )),
    );
  });

  test("get all puzzles", () async {
    DateTime now = DateTime.parse("2024-06-01");
    int id1 = await _puzzleDbRepository.create(Puzzle(
      type: PuzzleType.number,
      tiles: const [1, 2, 3, 4, 5, 6, 7, 0, 8],
      createdAt: now,
      updatedAt: now,
    ));
    int id2 = await _puzzleDbRepository.create(Puzzle(
      type: PuzzleType.image,
      tiles: const [1, 2, 3, 4, 5, 6, 0, 7, 8],
      createdAt: now,
      updatedAt: now,
    ));

    var result = await _puzzleDbRepository.getAll();

    expect(
      result,
      equals([
        Puzzle(
          id: id1,
          type: PuzzleType.number,
          tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
          createdAt: now,
          updatedAt: now,
        ),
        Puzzle(
          id: id2,
          type: PuzzleType.image,
          tiles: [1, 2, 3, 4, 5, 6, 0, 7, 8],
          createdAt: now,
          updatedAt: now,
        ),
      ]),
    );
  });
}
