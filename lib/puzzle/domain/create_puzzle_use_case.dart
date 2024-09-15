import 'package:clock/clock.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/data/puzzle_repository.dart';
import 'package:puzzle/puzzle/domain/tiles_generator.dart';

class CreatePuzzleUseCase {
  final PuzzleRepository _puzzleRepository;
  final TilesGenerator _tileGenerator;

  CreatePuzzleUseCase(
      PuzzleRepository puzzleRepository, TilesGenerator randomGenerator)
      : _puzzleRepository = puzzleRepository,
        _tileGenerator = randomGenerator;

  Future<int> create(PuzzleType type) async {
    var tiles = _generateSolvableTiles(3);

    var puzzle = _createPuzzle(type, tiles);

    return await _puzzleRepository.create(puzzle);
  }

  List<int> _generateSolvableTiles(int size) {
    var tiles = _generateTiles(size);

    while (!_isSolvable(tiles, size)) {
      tiles = _generateTiles(size);
    }

    return tiles;
  }

  List<int> _generateTiles(int size) => _tileGenerator.generate(size * size);

  Puzzle _createPuzzle(PuzzleType type, List<int> tiles) {
    var now = clock.now();
    return Puzzle(
      type: type,
      tiles: tiles,
      createdAt: now,
      updatedAt: now,
    );
  }

  bool _isSolvable(List<int> puzzle, int size) {
    int inversions = 0;
    int emptyRow = 0;

    for (int i = 0; i < puzzle.length; i++) {
      if (puzzle[i] == 0) {
        emptyRow = i ~/ size;
        continue;
      }
      for (int j = i + 1; j < puzzle.length; j++) {
        if (puzzle[j] != 0 && puzzle[i] > puzzle[j]) {
          inversions++;
        }
      }
    }

    if (size % 2 == 1) {
      return inversions % 2 == 0;
    } else {
      return (inversions + emptyRow) % 2 == 0;
    }
  }
}
