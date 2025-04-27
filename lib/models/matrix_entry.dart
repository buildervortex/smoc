import 'package:equatable/equatable.dart';

class Matrixentry extends Equatable {
  final int row;
  final int column;
  final double value;

  const Matrixentry({
    required this.row,
    required this.column,
    required this.value,
  });

  @override
  List<Object> get props => [row, column, value];

  @override
  String toString() {
    return 'MatrixEntry(row: $row, column: $column, value: $value)';
  }
}
