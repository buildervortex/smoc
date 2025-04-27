import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'matrix_input_cubit_state.dart';

class MatrixInputCubitCubit extends Cubit<MatrixInputCubitState> {
  MatrixInputCubitCubit() : super(MatrixInputCubitInitial());
}
