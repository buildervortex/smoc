part of 'operation_cubit_cubit.dart';

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

sealed class OperationCubitState extends Equatable {
  final List<Sparsematrix> sparseMatrixes;
  final Operation operation;

  const OperationCubitState(
      {required this.sparseMatrixes, required this.operation});

  @override
  List<Object> get props => [sparseMatrixes, operation];
}

final class OperationCubitInitial extends OperationCubitState {
  const OperationCubitInitial(
      {required super.sparseMatrixes, required super.operation});
}

final class OperationCubitSuccess extends OperationCubitState {
  final List<Sparsematrix> resultMatrixes;
  final int resultValue;
  const OperationCubitSuccess(
      {required this.resultMatrixes,
      required this.resultValue,
      required super.sparseMatrixes,
      required super.operation})
      : super();
}

final class OperationCubitFailed extends OperationCubitState {
  final String errorMessage;
  const OperationCubitFailed(
      {required this.errorMessage,
      required super.sparseMatrixes,
      required super.operation})
      : super();
}

final class OperationCubitLoading extends OperationCubitState {
  const OperationCubitLoading(
      {required super.sparseMatrixes, required super.operation})
      : super();
}
