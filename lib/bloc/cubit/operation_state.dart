part of 'operation_cubit.dart';

enum Operation {
  none,
  addition,
  subtraction,
  scalerMultiplication,
  scalerDivision,
  hadamardProduct,
  transpose,
  matrixMatrixMultiplication,
  determinant,
  trace,
  inverse,
  guassianElimination,
  lUDecomposition,
}

class OperationState extends Equatable {
  final List<SparseMatrix> sparseMatrixes;
  final Operation operation;

  const OperationState({required this.sparseMatrixes, required this.operation});

  @override
  List<Object> get props => [sparseMatrixes, operation];
}

final class OperationInitial extends OperationState {
  const OperationInitial(
      {required super.sparseMatrixes, required super.operation});
}

final class OperationSuccess extends OperationState {
  final List<SparseMatrix> resultMatrixes;
  final int resultValue;
  const OperationSuccess(
      {required this.resultMatrixes,
      required this.resultValue,
      required super.sparseMatrixes,
      required super.operation})
      : super();
}

final class OperationFailed extends OperationState {
  final String errorMessage;
  const OperationFailed(
      {required this.errorMessage,
      required super.sparseMatrixes,
      required super.operation})
      : super();
}

final class OperationLoading extends OperationState {
  const OperationLoading(
      {required super.sparseMatrixes, required super.operation})
      : super();
}
