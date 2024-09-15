import 'package:equatable/equatable.dart';
import 'package:puzzle/puzzle/domain/puzzle_error_status.dart';

class PuzzleException extends Equatable implements Exception {
  final PuzzleErrorStatus error;

  const PuzzleException(this.error);

  @override
  List<Object?> get props => [error];
}
