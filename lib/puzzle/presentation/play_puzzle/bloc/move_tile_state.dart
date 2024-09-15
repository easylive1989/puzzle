part of 'move_tile_bloc.dart';

enum MoveTileStatus {
  initial,
  success,
  fail,
}

class MoveTileState {
  final MoveTileStatus status;
  final int? lastMovedTile;

  MoveTileState({
    required this.status,
    this.lastMovedTile,
  });

  factory MoveTileState.initial() {
    return MoveTileState(status: MoveTileStatus.initial);
  }

  MoveTileState toSuccess({int? movedTile}) {
    return copyWith(
      status: MoveTileStatus.success,
      lastMovedTile: movedTile,
    );
  }

  MoveTileState toFail() {
    return copyWith(status: MoveTileStatus.fail);
  }

  MoveTileState copyWith({
    MoveTileStatus? status,
    int? lastMovedTile,
  }) {
    return MoveTileState(
      status: status ?? this.status,
      lastMovedTile: lastMovedTile ?? this.lastMovedTile,
    );
  }
}
