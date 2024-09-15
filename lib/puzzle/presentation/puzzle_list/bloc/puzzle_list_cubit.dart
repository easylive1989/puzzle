import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle/puzzle/domain/get_ongoing_puzzles_use_case.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/domain/create_puzzle_use_case.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/bloc/puzzle_info.dart';

part 'puzzle_list_state.dart';

class PuzzleListCubit extends Cubit<PuzzleListState> {
  final GetOngoingPuzzlesUseCase _getOngoingPuzzlesUseCase;
  final CreatePuzzleUseCase _createPuzzleUseCase;

  PuzzleListCubit(GetOngoingPuzzlesUseCase getAllPuzzleUseCase,
      CreatePuzzleUseCase createPuzzleUseCase)
      : _getOngoingPuzzlesUseCase = getAllPuzzleUseCase,
        _createPuzzleUseCase = createPuzzleUseCase,
        super(PuzzleListState.initial());

  Future<void> create(PuzzleType type) async {
    var id = await _createPuzzleUseCase.create(type);
    emit(state.toLoaded(puzzleInfos: [
      ...state.puzzleInfos,
      PuzzleInfo(id: id, type: type),
    ]));
  }

  Future<void> load() async {
    var puzzles = await _getOngoingPuzzlesUseCase.get();
    emit(state.toLoaded(
      puzzleInfos: puzzles.map((puzzle) {
        return PuzzleInfo(id: puzzle.id, type: puzzle.type);
      }).toList(),
    ));
  }
}
