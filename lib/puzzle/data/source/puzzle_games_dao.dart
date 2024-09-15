import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:puzzle/puzzle/data/source/app_database.dart';
import 'package:puzzle/puzzle/data/source/puzzle_games.dart';
import 'package:puzzle/puzzle/data/puzzle_db_dto.dart';

part 'puzzle_games_dao.g.dart';

@DriftAccessor(tables: [PuzzleGames])
class PuzzleGamesDao extends DatabaseAccessor<AppDatabase>
    with _$PuzzleGamesDaoMixin {
  PuzzleGamesDao(AppDatabase db) : super(db);

  Future<PuzzleDbDto> get(int id) async {
    var data = await (select(puzzleGames)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
    return PuzzleDbDto(
      id: data.id,
      type: data.type,
      tiles: jsonDecode(data.tiles).map<int>((e) => e as int).toList(),
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  Future<List<PuzzleDbDto>> getAll() async {
    List<PuzzleGame> puzzlesData = await (select(puzzleGames)).get();
    return puzzlesData.map((data) {
      return PuzzleDbDto(
        id: data.id,
        type: data.type,
        tiles: jsonDecode(data.tiles).map<int>((e) => e as int).toList(),
        createdAt: data.createdAt,
        updatedAt: data.updatedAt,
      );
    }).toList();
  }

  Future<int> insert(PuzzleDbDto puzzle) {
    return puzzleGames.insertOne(
      PuzzleGamesCompanion.insert(
        type: puzzle.type,
        tiles: jsonEncode(puzzle.tiles),
        createdAt: puzzle.createdAt,
        updatedAt: puzzle.updatedAt,
      ),
    );
  }

  Future<void> updatePuzzle(PuzzleDbDto puzzle) async {
    await (update(puzzleGames)..where((t) => t.id.equals(puzzle.id))).write(
      PuzzleGamesCompanion(
        id: Value(puzzle.id),
        type: Value(puzzle.type),
        tiles: Value(jsonEncode(puzzle.tiles)),
        createdAt: Value(puzzle.createdAt),
        updatedAt: Value(puzzle.updatedAt),
      ),
    );
    // await puzzleGames..insertOnConflictUpdate(
    //   PuzzleGamesCompanion.insert(
    //     id: Value(puzzle.id),
    //     type: puzzle.type,
    //     tiles: jsonEncode(puzzle.tiles),
    //     createdAt: puzzle.createdAt,
    //     updatedAt: puzzle.updatedAt,
    //   ),
    // );
  }
}
