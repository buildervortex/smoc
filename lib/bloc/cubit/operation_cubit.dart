import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smo/models/sparse_matrix.dart';

part 'operation_state.dart';

class OperationCubit extends Cubit<OperationState> {
  OperationCubit()
      : super(OperationInitial(operation: Operation.none, sparseMatrixes: []));

  void setOperation(Operation operation) {
    emit(OperationState(
        operation: operation, sparseMatrixes: state.sparseMatrixes));
  }
}
