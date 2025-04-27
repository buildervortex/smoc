import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'operation_cubit_state.dart';

class OperationCubitCubit extends Cubit<OperationCubitState> {
  OperationCubitCubit() : super(OperationCubitInitial());

  void performOperation() {
    // Perform some operation
    emit(OperationCubitInitial());
  }
}
