import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';

Puzzle ongoingPuzzle({
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  return puzzle(
    tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

Puzzle gameOverPuzzle({
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  return puzzle(
    tiles: [1, 2, 3, 4, 5, 6, 7, 8, 0],
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

Puzzle puzzle({
  int? id,
  List<int>? tiles,
  PuzzleType? type,
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  return Puzzle(
    id: id ?? 1,
    type: type ?? PuzzleType.number,
    tiles: tiles ?? [1, 2, 3, 4, 5, 6, 7, 0, 8],
    createdAt: createdAt ?? DateTime.parse("2024-05-31"),
    updatedAt: updatedAt ?? DateTime.parse("2024-06-01"),
  );
}
