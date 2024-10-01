import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_exception.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/domain/puzzle_error_status.dart';

class Puzzle {
  final int id;
  final List<int> tiles;
  final PuzzleType type;
  final DateTime createdAt;
  DateTime updatedAt;

  Puzzle({
    this.id = 0,
    required this.type,
    required this.tiles,
    required this.createdAt,
    required this.updatedAt,
  });

  int get size => sqrt(tiles.length).toInt();

  bool isGameOver() {
    return listEquals(
      tiles,
      List.generate(tiles.length - 1, (index) => index + 1) + [0],
    );
  }

  void move(int tile, DateTime updatedAt) {
    var indexOfEmptyTile = tiles.indexOf(0);
    var indexOfTile = tiles.indexOf(tile);

    if (!_canMove(indexOfEmptyTile, indexOfTile)) {
      throw const PuzzleException(PuzzleErrorStatus.tileNotNearEmptyTile);
    }

    _swap(indexOfEmptyTile, indexOfTile);
    _updateTime(updatedAt);
  }

  void _updateTime(DateTime updatedAt) {
    this.updatedAt = updatedAt;
  }

  bool _canMove(int indexOfEmptyTile, int indexOfTile) {
    var rowOfEmptyTile = indexOfEmptyTile ~/ size;
    var rowOfTile = indexOfTile ~/ size;
    var columnOfEmptyTile = indexOfEmptyTile % size;
    var columnOfTile = indexOfTile % size;

    var rowDifference = (rowOfEmptyTile - rowOfTile).abs();
    var columnDifference = (columnOfEmptyTile - columnOfTile).abs();

    return rowDifference + columnDifference == 1;
  }

  void _swap(int index1, int index2) {
    var temp = tiles[index1];
    tiles[index1] = tiles[index2];
    tiles[index2] = temp;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Puzzle &&
        listEquals(tiles, other.tiles) &&
        id == other.id &&
        type == other.type &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => tiles.hashCode;

  @override
  String toString() {
    return "Puzzle{id: $id, tiles: $tiles, createdAt: $createdAt, updatedAt: $updatedAt}";
  }
}
