part of 'puzzle_list_cubit.dart';

enum PuzzleListStatus {
  initial,
  loaded,
}

class PuzzleListState extends Equatable {
  final List<PuzzleInfo> puzzleInfos;
  final PuzzleListStatus status;

  const PuzzleListState({
    required this.status,
    required this.puzzleInfos,
  });

  factory PuzzleListState.initial() {
    return const PuzzleListState(
      status: PuzzleListStatus.initial,
      puzzleInfos: [],
    );
  }

  PuzzleListState toLoaded({required List<PuzzleInfo> puzzleInfos}) {
    return copyWith(
      status: PuzzleListStatus.loaded,
      puzzleInfos: puzzleInfos,
    );
  }

  PuzzleListState copyWith({
    PuzzleListStatus? status,
    List<PuzzleInfo>? puzzleInfos,
  }) {
    return PuzzleListState(
      status: status ?? this.status,
      puzzleInfos: puzzleInfos ?? this.puzzleInfos,
    );
  }

  @override
  List<Object?> get props => [status, puzzleInfos];
}
