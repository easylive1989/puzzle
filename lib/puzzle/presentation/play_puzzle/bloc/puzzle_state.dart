part of 'puzzle_bloc.dart';

enum PuzzleStatus {
  initial,
  loaded,
}

class PuzzleState extends Equatable {
  final PuzzleStatus status;
  final CurrentPuzzle? puzzle;

  const PuzzleState({
    this.puzzle,
    required this.status,
  });

  factory PuzzleState.initial() {
    return const PuzzleState(status: PuzzleStatus.initial);
  }

  PuzzleState toLoaded(CurrentPuzzle puzzle) {
    return copyWith(
      puzzle: puzzle,
      status: PuzzleStatus.loaded,
    );
  }

  PuzzleState copyWith({
    CurrentPuzzle? puzzle,
    PuzzleStatus? status,
  }) {
    return PuzzleState(
      puzzle: puzzle ?? this.puzzle,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, puzzle];
}
