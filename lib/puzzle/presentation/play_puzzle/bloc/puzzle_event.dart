part of 'puzzle_bloc.dart';

abstract class PuzzleEvent extends Equatable {}

class LoadPuzzle extends PuzzleEvent {
  final int id;

  LoadPuzzle(this.id);

  @override
  List<Object?> get props => [id];
}