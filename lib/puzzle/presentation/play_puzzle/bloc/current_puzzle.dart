import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/bloc/positioned_tile.dart';

class CurrentPuzzle extends Equatable {
  final int id;
  final PuzzleType type;
  final List<int> tiles;
  final bool isGameOver;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int size;

  factory CurrentPuzzle.of(Puzzle puzzle) {
    return CurrentPuzzle(
      id: puzzle.id,
      type: puzzle.type,
      tiles: puzzle.tiles,
      isGameOver: puzzle.isGameOver(),
      createdAt: puzzle.createdAt,
      updatedAt: puzzle.updatedAt,
      size: puzzle.size,
    );
  }

  List<PositionedTile> get sortedPositionedTiles {
    return tiles.mapIndexed((index, tile) {
      return PositionedTile(
        value: tile,
        row: index ~/ size,
        column: index % size,
      );
    }).toList()
      ..sort((tile1, tile2) {
        return tile1.value.compareTo(tile2.value);
      });
  }

  Duration getPlayingTime(DateTime now) {
    var until = isGameOver ? updatedAt : now;
    return until.difference(createdAt);
  }

  const CurrentPuzzle({
    required this.id,
    required this.type,
    required this.tiles,
    required this.isGameOver,
    required this.createdAt,
    required this.updatedAt,
    required this.size,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        tiles,
        isGameOver,
        createdAt,
        updatedAt,
        size,
      ];
}
