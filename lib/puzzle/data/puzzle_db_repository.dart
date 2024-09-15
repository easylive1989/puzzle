
import 'package:puzzle/puzzle/data/source/puzzle_games_dao.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/data/puzzle_db_dto.dart';
import 'package:puzzle/puzzle/data/puzzle_repository.dart';

class PuzzleDbRepository implements PuzzleRepository {
  final PuzzleGamesDao _puzzleGamesDao;

  PuzzleDbRepository(PuzzleGamesDao puzzleGamesDao)
      : _puzzleGamesDao = puzzleGamesDao;

  @override
  Future<Puzzle> get(int id) async {
    PuzzleDbDto puzzle = await _puzzleGamesDao.get(id);
    return puzzle.toEntity();
  }

  @override
  Future<void> save(Puzzle puzzle) async {
    _puzzleGamesDao.updatePuzzle(
      PuzzleDbDto.fromEntity(puzzle),
    );
  }

  @override
  Future<int> create(Puzzle puzzle) async {
    return await _puzzleGamesDao.insert(
      PuzzleDbDto.fromEntity(puzzle),
    );
  }

  @override
  Future<List<Puzzle>> getAll() async {
    List<PuzzleDbDto> puzzles = await _puzzleGamesDao.getAll();
    return puzzles.map((puzzle) {
      return puzzle.toEntity();
    }).toList();
  }
}
