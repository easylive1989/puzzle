part of 'move_tile_bloc.dart';

enum MoveTileStatus {
  initial,
  success,
  fail,
}

class MoveTileState {
  final MoveTileStatus status;

  MoveTileState({
    required this.status,
  });

  factory MoveTileState.initial() {
    return MoveTileState(status: MoveTileStatus.initial);
  }

  MoveTileState toSuccess() {
    return copyWith(status: MoveTileStatus.success);
  }

  MoveTileState toFail() {
    return copyWith(status: MoveTileStatus.fail);
  }

  MoveTileState copyWith({MoveTileStatus? status}) {
    return MoveTileState(
      status: status ?? this.status,
    );
  }
}
