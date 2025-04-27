import 'package:equatable/equatable.dart';
import 'package:smo/models/matrix_entry.dart';

class SparseMatrix extends Equatable {
  final int rows;
  final int columns;
  final List<MatrixEntry> entries;

  const SparseMatrix({
    required this.rows,
    required this.columns,
    required this.entries,
  });

  @override
  List<Object> get props => [rows, columns, entries];

  @override
  String toString() {
    return 'SparseMatrix(rows: $rows, columns: $columns, entries: $entries)';
  }
}
