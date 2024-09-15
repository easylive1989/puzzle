import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle/puzzle/data/puzzle_repository.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/bloc/current_puzzle.dart';

part 'puzzle_state.dart';

part 'puzzle_event.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  final PuzzleRepository _puzzleRepository;

  PuzzleBloc(PuzzleRepository puzzleRepository)
      : _puzzleRepository = puzzleRepository,
        super(PuzzleState.initial()) {
    on<LoadPuzzle>(_load);
  }

  Future<void> _load(event, emit) async {
    var puzzle = await _puzzleRepository.get(event.id);
    emit(state.toLoaded(CurrentPuzzle.of(puzzle)));
  }
}
