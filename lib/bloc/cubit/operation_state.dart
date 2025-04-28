part of 'operation_cubit.dart';

enum Operation {
  none(0, 0, 0),
  addition(2, 1, 0),
  subtraction(2, 1, 0),
  scalerMultiplication(1, 1, 1),
  scalerDivision(1, 1, 1),
  hadamardProduct(2, 1, 0),
  transpose(1, 1, 0),
  matrixMatrixMultiplication(2, 1, 0),
  determinant(1, 1, 0),
  trace(1, 1, 0),
  inverse(1, 1, 0),
  guassianElimination(1, 1, 0),
  lUDecomposition(1, 2, 0);

  final int inputMatrixCount;
  final int outputMatrixCount;
  final int inputValueCount;

  const Operation(
      this.inputMatrixCount, this.outputMatrixCount, this.inputValueCount);
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
