import 'package:equatable/equatable.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';

class PuzzleDbDto extends Equatable {
  final int id;
  final List<int> tiles;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PuzzleDbDto({
    this.id = 0,
    required this.tiles,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PuzzleDbDto.fromEntity(Puzzle puzzle) {
    return PuzzleDbDto(
      id: puzzle.id,
      tiles: puzzle.tiles,
      type: puzzle.type.toString(),
      createdAt: puzzle.createdAt,
      updatedAt: puzzle.updatedAt,
    );
  }

  Puzzle toEntity() {
    return Puzzle(
      id: id,
      tiles: tiles,
      type: PuzzleType.from(type),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        tiles,
        type,
        createdAt,
        updatedAt,
      ];
}
