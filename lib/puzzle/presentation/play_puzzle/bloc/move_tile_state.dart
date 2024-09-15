part of 'move_tile_bloc.dart';

enum MoveTileStatus {
  initial,
  success,
  fail,
}

class MoveTileState {
  final MoveTileStatus status;
  final List<int> lastMovedTiles;

  MoveTileState({
    required this.status,
    required this.lastMovedTiles,
  });

  factory MoveTileState.initial() {
    return MoveTileState(
      status: MoveTileStatus.initial,
      lastMovedTiles: [],
    );
  }

  MoveTileState toSuccess({required List<int> lastMoveTiles}) {
    return copyWith(
      status: MoveTileStatus.success,
      lastMovedTiles: lastMoveTiles,
    );
  }

  MoveTileState toFail() {
    return copyWith(status: MoveTileStatus.fail);
  }

  MoveTileState copyWith({
    MoveTileStatus? status,
    List<int>? lastMovedTiles,
  }) {
    return MoveTileState(
      status: status ?? this.status,
      lastMovedTiles: lastMovedTiles ?? this.lastMovedTiles,
    );
  }
}
