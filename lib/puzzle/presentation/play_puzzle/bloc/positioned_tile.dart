import 'package:equatable/equatable.dart';

class PositionedTile extends Equatable {
  final int value;
  final int row;
  final int column;

  const PositionedTile({
    required this.value,
    required this.row,
    required this.column,
  });

  @override
  List<Object?> get props => [value, row, column];
}
