import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smo/models/sparse_matrix.dart';

part 'operation_state.dart';

class OperationCubit extends Cubit<OperationState> {
  OperationCubit()
      : super(OperationInitial(
            operation: Operation.none, sparseMatrixes: [], inputValues: []));

  void setOperation(Operation operation) {
    emit(OperationState(
        operation: operation,
        sparseMatrixes: state.sparseMatrixes,
        inputValues: state.inputValues));
  }

  void addSparseMatrix(SparseMatrix sparseMatrix) {
    final List<SparseMatrix> newSparseMatrixes = List.from(state.sparseMatrixes)
      ..add(sparseMatrix);
    emit(OperationState(
        operation: state.operation,
        sparseMatrixes: newSparseMatrixes,
        inputValues: state.inputValues));
  }

  void addInputValue(num inputValue) {
    final List<num> newInputValues = List.from(state.inputValues);
    newInputValues.add(inputValue);
    emit(OperationState(
        operation: state.operation,
        sparseMatrixes: state.sparseMatrixes,
        inputValues: newInputValues));
  }

  void clearData() {
    emit(OperationState(
        operation: state.operation, sparseMatrixes: [], inputValues: []));
  }
}
