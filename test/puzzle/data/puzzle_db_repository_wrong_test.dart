import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle/puzzle/data/source/app_database.dart';
import 'package:puzzle/puzzle/data/puzzle_db_repository.dart';
import 'package:drift/native.dart';

import '../domain/entity/puzzle_factory.dart';

main() {
  var database = AppDatabase(NativeDatabase.memory());
  var puzzleDbRepository = PuzzleDbRepository(database.puzzleGamesDao);

  test("create puzzle", () async {
    int id = await puzzleDbRepository.create(puzzle(
      tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
      updatedAt: DateTime.parse("2024-05-31"),
    ));

    expect(
        await puzzleDbRepository.get(id),
        equals(puzzle(
          id: id,
          tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
          updatedAt: DateTime.parse("2024-05-31"),
        )));
  });

  test("save puzzle", () async {
    await puzzleDbRepository.save(puzzle(
      id: 1,
      tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
      updatedAt: DateTime.parse("2024-06-01"),
    ));

    expect(
        await puzzleDbRepository.get(1),
        equals(puzzle(
          id: 1,
          tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
          updatedAt: DateTime.parse("2024-06-01"),
        )));
  });
}
