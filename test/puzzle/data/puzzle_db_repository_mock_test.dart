import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:puzzle/puzzle/data/puzzle_db_dto.dart';
import 'package:puzzle/puzzle/data/puzzle_db_repository.dart';
import 'package:puzzle/puzzle/data/source/puzzle_games_dao.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';

main() {
  setUp(() {
    registerFallbackValue(MockPuzzleDbDto());
  });

  test("create puzzle", () async {
    var mockPuzzleGamesDao = MockPuzzleGamesDao();
    when(() => mockPuzzleGamesDao.insert(any())).thenAnswer((_) async => 1);

    var repository = PuzzleDbRepository(mockPuzzleGamesDao);

    int id = await repository.create(Puzzle(
      id: 1,
      type: PuzzleType.number,
      tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
      createdAt: DateTime.parse("2024-06-01"),
      updatedAt: DateTime.parse("2024-06-01"),
    ));

    expect(id, 1);
    verify(() => mockPuzzleGamesDao.insert(PuzzleDbDto(
          id: 1,
          type: "PuzzleType.number",
          tiles: const [1, 2, 3, 4, 5, 6, 7, 8, 0],
          createdAt: DateTime.parse("2024-06-01"),
          updatedAt: DateTime.parse("2024-06-01"),
        ))).called(1);
  });

  test("save puzzle", () async {
    var mockPuzzleGamesDao = MockPuzzleGamesDao();
    when(() => mockPuzzleGamesDao.updatePuzzle(any())).thenAnswer((_) async {});

    var repository = PuzzleDbRepository(mockPuzzleGamesDao);

    await repository.save(Puzzle(
      id: 1,
      type: PuzzleType.number,
      tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
      createdAt: DateTime.parse("2024-06-01"),
      updatedAt: DateTime.parse("2024-06-01"),
    ));

    verify(() => mockPuzzleGamesDao.updatePuzzle(PuzzleDbDto(
          id: 1,
          type: "PuzzleType.number",
          tiles: const [1, 2, 3, 4, 5, 6, 7, 8, 0],
          createdAt: DateTime.parse("2024-06-01"),
          updatedAt: DateTime.parse("2024-06-01"),
        ))).called(1);
  });

  test("get puzzle", () async {
    var mockPuzzleGamesDao = MockPuzzleGamesDao();
    when(() => mockPuzzleGamesDao.get(any()))
        .thenAnswer((_) async => PuzzleDbDto(
              id: 1,
              type: "PuzzleType.number",
              tiles: const [1, 2, 3, 4, 5, 6, 7, 8, 0],
              createdAt: DateTime.parse("2024-06-01"),
              updatedAt: DateTime.parse("2024-06-01"),
            ));

    var repository = PuzzleDbRepository(mockPuzzleGamesDao);

    var puzzle = await repository.get(1);

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

  test("get all puzzle", () async {
    var mockPuzzleGamesDao = MockPuzzleGamesDao();
    when(() => mockPuzzleGamesDao.getAll()).thenAnswer((_) async => [
          PuzzleDbDto(
            id: 1,
            type: "PuzzleType.number",
            tiles: const [1, 2, 3, 4, 5, 6, 7, 8, 0],
            createdAt: DateTime.parse("2024-06-01"),
            updatedAt: DateTime.parse("2024-06-01"),
          ),
          PuzzleDbDto(
            id: 2,
            type: "PuzzleType.image",
            tiles: const [1, 2, 3, 4, 5, 6, 7, 0, 8],
            createdAt: DateTime.parse("2024-06-02"),
            updatedAt: DateTime.parse("2024-06-02"),
          ),
        ]);

    var repository = PuzzleDbRepository(mockPuzzleGamesDao);

    var puzzles = await repository.getAll();

    expect(
      puzzles,
      equals([
        Puzzle(
          id: 1,
          type: PuzzleType.number,
          tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
          createdAt: DateTime.parse("2024-06-01"),
          updatedAt: DateTime.parse("2024-06-01"),
        ),
        Puzzle(
          id: 2,
          type: PuzzleType.image,
          tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
          createdAt: DateTime.parse("2024-06-02"),
          updatedAt: DateTime.parse("2024-06-02"),
        ),
      ]),
    );
  });
}

class MockPuzzleGamesDao extends Mock implements PuzzleGamesDao {}

class MockPuzzleDbDto extends Mock implements PuzzleDbDto {}
