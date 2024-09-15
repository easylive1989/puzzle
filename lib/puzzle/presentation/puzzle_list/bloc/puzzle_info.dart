import 'package:equatable/equatable.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';

class PuzzleInfo extends Equatable {
  final int id;
  final PuzzleType type;

  const PuzzleInfo({
    required this.id,
    required this.type,
  });



  @override
  List<Object?> get props => [id, type];

}