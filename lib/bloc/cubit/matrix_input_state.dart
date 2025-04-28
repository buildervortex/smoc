part of 'matrix_input_cubit.dart';

class MatrixInputState extends Equatable {
  final SparseMatrix sparseMatrix;

  const MatrixInputState({required this.sparseMatrix});

  @override
  List<Object> get props => [sparseMatrix];
}

final class MatrixInputInitial extends MatrixInputState {
  MatrixInputInitial()
      : super(sparseMatrix: SparseMatrix(columns: 0, rows: 0, entries: []));
}

final class MatrixInputEntrySuccess extends MatrixInputState {
  const MatrixInputEntrySuccess({required super.sparseMatrix});
}

final class MatrixInputEntryFailed extends MatrixInputState {
  final String errorMessage;
  const MatrixInputEntryFailed(
      {required super.sparseMatrix, required this.errorMessage});
}
