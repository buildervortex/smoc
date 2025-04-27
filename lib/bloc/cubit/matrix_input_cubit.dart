import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smo/models/sparse_matrix.dart';

part 'matrix_input_state.dart';

class MatrixInputCubit extends Cubit<MatrixInputState> {
  MatrixInputCubit()
      : super(MatrixInputInitial(
            sparseMatrix: SparseMatrix(columns: 0, rows: 0, entries: [])));
}
