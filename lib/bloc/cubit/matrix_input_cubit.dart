import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smo/models/matrix_entry.dart';
import 'package:smo/models/sparse_matrix.dart';

part 'matrix_input_state.dart';

class MatrixInputCubit extends Cubit<MatrixInputState> {
  MatrixInputCubit() : super(MatrixInputInitial());

  void setSparseMatrixSize(int rowCount, int columnCount) {
    emit(MatrixInputState(
        sparseMatrix: SparseMatrix(
            columns: columnCount,
            rows: rowCount,
            entries: state.sparseMatrix.entries)));
  }

  void addSparseMatrixEntry(int row, int column, double value) {
    final currentState = state.sparseMatrix;
    if (currentState.entries
        .any((entry) => entry.row == row && entry.column == column)) {
      emit(MatrixInputEntryFailed(
          sparseMatrix: currentState, errorMessage: "Entry already exists"));
      return;
    }
    if (row >= currentState.rows || column >= currentState.columns) {
      emit(MatrixInputEntryFailed(
          sparseMatrix: currentState, errorMessage: "Invalid entry"));
      return;
    }
    if (value == 0) {
      emit(MatrixInputEntryFailed(
          sparseMatrix: currentState, errorMessage: "Invalid entry"));
      return;
    }
    final List<MatrixEntry> newEntries = List.from(currentState.entries)
      ..add(MatrixEntry(row: row, column: column, value: value));
    emit(MatrixInputEntrySuccess(
        sparseMatrix: SparseMatrix(
            columns: currentState.columns,
            rows: currentState.rows,
            entries: newEntries)));
  }

  void removeSparseMatrixEntry(int row, int column) {
    final currentState = state.sparseMatrix;
    final List<MatrixEntry> newEntries = List.from(currentState.entries)
      ..removeWhere((entry) => entry.row == row && entry.column == column);
    emit(MatrixInputEntrySuccess(
        sparseMatrix: SparseMatrix(
            columns: currentState.columns,
            rows: currentState.rows,
            entries: newEntries)));
  }

  void clearSparseMatrix() {
    emit(MatrixInputInitial());
  }
}
