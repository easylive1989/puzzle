import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_exception.dart';
import 'package:puzzle/puzzle/domain/move_tile_use_case.dart';

part 'move_tile_state.dart';

part 'move_tile_event.dart';

class MoveTileBloc extends Bloc<MoveTileEvent, MoveTileState> {
  final MoveTileUseCase _moveTileUseCase;

  MoveTileBloc(MoveTileUseCase moveTileUseCase)
      : _moveTileUseCase = moveTileUseCase,
        super(MoveTileState.initial()) {
    on<MoveTile>(_move);
    on<UndoMove>(_undo);
  }

  Future<void> _move(event, emit) async {
    try {
      await _moveTileUseCase.move(event.id, event.tile);
      emit(state.toSuccess(
        lastMoveTiles: state.lastMovedTiles..add(event.tile),
      ));
    } on PuzzleException {
      emit(state.toFail());
    }
  }

  Future<void> _undo(event, emit) async {
    if (state.lastMovedTiles.isEmpty) {
      return;
    }

    await _moveTileUseCase.move(event.id, state.lastMovedTiles.last);
    emit(state.toSuccess(lastMoveTiles: state.lastMovedTiles..removeLast()));
  }
}
