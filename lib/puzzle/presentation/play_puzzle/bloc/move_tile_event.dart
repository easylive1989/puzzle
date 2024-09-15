part of 'move_tile_bloc.dart';

abstract class MoveTileEvent extends Equatable {}

class MoveTile extends MoveTileEvent {
  final int id;
  final int tile;

  MoveTile({required this.id, required this.tile});

  @override
  List<Object?> get props => [id, tile];
}

class UndoMove extends MoveTileEvent {
  final int id;

  UndoMove({required this.id});

  @override
  List<Object?> get props => [id];
}
