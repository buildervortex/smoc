part of 'matrix_input_cubit.dart';

sealed class MatrixInputState extends Equatable {
  final SparseMatrix sparseMatrix;

  const MatrixInputState({required this.sparseMatrix});

  @override
  List<Object> get props => [];
}

final class MatrixInputInitial extends MatrixInputState {
  const MatrixInputInitial({required super.sparseMatrix});
}

final class MatrixInputSuccess extends MatrixInputState {
  const MatrixInputSuccess({required super.sparseMatrix});
}

final class MatrixInputFailed extends MatrixInputState {
  final String errorMessage;
  const MatrixInputFailed(
      {required super.sparseMatrix, required this.errorMessage});
}
