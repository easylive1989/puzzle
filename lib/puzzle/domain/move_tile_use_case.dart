import 'package:clock/clock.dart';
import 'package:puzzle/puzzle/data/puzzle_repository.dart';

class MoveTileUseCase {
  final PuzzleRepository _puzzleRepository;

  MoveTileUseCase(
    PuzzleRepository puzzleRepository,
  ) : _puzzleRepository = puzzleRepository;

  Future<void> move(int id, int tile) async {
    var puzzle = await _puzzleRepository.get(id);

    if (puzzle.isGameOver()) {
      return;
    }

    puzzle.move(tile, clock.now());

    await _puzzleRepository.save(puzzle);
  }
}
