import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_exception.dart';
import 'package:puzzle/puzzle/domain/puzzle_error_status.dart';

import 'puzzle_factory.dart';

main() {
  group("game over", () {
    test("is game over", () {
      final sut = puzzle(tiles: const [1, 2, 3, 4, 5, 6, 7, 8, 0]);

      expect(sut.isGameOver(), isTrue);
    });

    test("is NOT game over", () {
      final sut = puzzle(tiles: const [1, 2, 3, 4, 5, 6, 7, 0, 8]);

      expect(sut.isGameOver(), isFalse);
    });
  });

  test("get size", () {
    expect(puzzle(tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8]).size, equals(3));
    expect(puzzle(tiles: [1, 2, 0, 3]).size, equals(2));
  });

  group("move tile", () {
    test("when move tile at right of empty tile", () async {
      final sut = puzzle(
        tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
        updatedAt: DateTime.parse("2024-05-31"),
      );

      sut.move(8, DateTime.parse("2024-06-01"));

      expect(sut.tiles, equals([1, 2, 3, 4, 5, 6, 7, 8, 0]));
      expect(sut.updatedAt, equals(DateTime.parse("2024-06-01")));
    });

    test("when move tile at top of empty tile", () async {
      final sut = puzzle(
        tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
        updatedAt: DateTime.parse("2024-05-31"),
      );

      sut.move(5, DateTime.parse("2024-06-01"));

      expect(sut.tiles, equals([1, 2, 3, 4, 0, 6, 7, 5, 8]));
      expect(sut.updatedAt, equals(DateTime.parse("2024-06-01")));
    });
  });

  group("move tile fail", () {
    test("when move tile does not near empty tile", () {
      final sut = puzzle(
        tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
        updatedAt: DateTime.parse("2024-05-31"),
      );

      expect(
        () => sut.move(3, DateTime.parse("2024-06-01")),
        throwsA(equals(
            const PuzzleException(PuzzleErrorStatus.tileNotNearEmptyTile))),
      );
    });

    test("when move in distance 1 but different row", () {
      final sut = puzzle(
        tiles: [1, 2, 3, 0, 4, 5, 6, 7, 8],
        updatedAt: DateTime.parse("2024-05-31"),
      );

      expect(
        () => sut.move(3, DateTime.parse("2024-06-01")),
        throwsA(equals(const PuzzleException(
          PuzzleErrorStatus.tileNotNearEmptyTile,
        ))),
      );
    });
  });
}
