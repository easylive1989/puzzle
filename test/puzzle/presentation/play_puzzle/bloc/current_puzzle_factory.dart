import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/bloc/current_puzzle.dart';

CurrentPuzzle gameOverCurrentPuzzle({
  required DateTime createdAt,
  required DateTime updatedAt,
}) {
  return CurrentPuzzle(
    id: 1,
    type: PuzzleType.number,
    tiles: const [],
    isGameOver: true,
    createdAt: createdAt,
    updatedAt: updatedAt,
    size: 3,
  );
}
