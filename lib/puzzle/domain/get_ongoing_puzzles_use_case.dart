
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/data/puzzle_repository.dart';

class GetOngoingPuzzlesUseCase {
  final PuzzleRepository _puzzleRepository;

  GetOngoingPuzzlesUseCase(PuzzleRepository puzzleRepository)
      : _puzzleRepository = puzzleRepository;

  Future<List<Puzzle>> get() async {
    var puzzles = await _puzzleRepository.getAll();
    return puzzles.where((puzzle) => !puzzle.isGameOver()).toList();
  }
}
