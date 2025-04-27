import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'matrix_input_state.dart';

class MatrixInputCubit extends Cubit<MatrixInputState> {
  MatrixInputCubit() : super(MatrixInputInitial());
}
