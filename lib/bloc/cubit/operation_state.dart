part of 'operation_cubit.dart';

enum Operation {
  none(0, 0, 0, "None"),
  addition(2, 1, 0, "Addition"),
  subtraction(2, 1, 0, "Subtraction"),
  scalerMultiplication(1, 1, 1, "Scaler Multiplication"),
  scalerDivision(1, 1, 1, "Scaler Division"),
  hadamardProduct(2, 1, 0, "Hadamard Product"),
  transpose(1, 1, 0, "Transpose"),
  matrixMatrixMultiplication(2, 1, 0, "Matrix Multiplication"),
  determinant(1, 1, 0, "Determinant"),
  trace(1, 1, 0, "Trace"),
  inverse(1, 1, 0, "Inverse"),
  guassianElimination(1, 1, 0, "Gaussian Elimination"),
  lUDecomposition(1, 2, 0, "LU Decomposition"),
  adjoint(1, 1, 0, "Adjoint"),
  cofactor(1, 1, 0, "Cofactor");

  final int inputMatrixCount;
  final int outputMatrixCount;
  final int inputValueCount;
  final String name;

  const Operation(this.inputMatrixCount, this.outputMatrixCount,
      this.inputValueCount, this.name);
}

class OperationState extends Equatable {
  final List<SparseMatrix> sparseMatrixes;
  final List<double> inputValues;
  final Operation operation;

  const OperationState(
      {required this.sparseMatrixes,
      required this.operation,
      required this.inputValues});

  @override
  List<Object> get props => [sparseMatrixes, operation];
}

final class OperationInitial extends OperationState {
  const OperationInitial(
      {required super.sparseMatrixes,
      required super.operation,
      required super.inputValues});
}

final class OperationSuccess extends OperationState {
  final List<SparseMatrix> resultMatrixes;
  final int resultValue;
  const OperationSuccess(
      {required this.resultMatrixes,
      required this.resultValue,
      required super.sparseMatrixes,
      required super.operation,
      required super.inputValues})
      : super();
}

final class OperationFailed extends OperationState {
  final String errorMessage;
  const OperationFailed(
      {required this.errorMessage,
      required super.sparseMatrixes,
      required super.operation,
      required super.inputValues})
      : super();
}

final class OperationLoading extends OperationState {
  const OperationLoading(
      {required super.sparseMatrixes,
      required super.operation,
      required super.inputValues})
      : super();
}
