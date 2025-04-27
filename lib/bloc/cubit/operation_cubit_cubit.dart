import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smo/models/sparse_matrix.dart';

part 'operation_cubit_state.dart';

class OperationCubitCubit extends Cubit<OperationCubitState> {
  OperationCubitCubit()
      : super(OperationCubitInitial(
            operation: Operation.none, sparseMatrixes: []));

  void performOperation() {
    // Perform some operation
    // emit(OperationCubitInitial());
  }
}
