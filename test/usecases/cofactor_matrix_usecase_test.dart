import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/cofactor_matrix_usecase.dart';

void main() {
  // group('CofactorMatrixUsecase', () {
  //   final cofactorMatrixUsecase = CofactorMatrixUsecase();

  //   test('should calculate the cofactor matrix correctly', () {
  //     final matrix = {
  //       0: {0: 1, 1: 2, 2: 3},
  //       1: {1: 1, 2: 4},
  //       2: {0: 5, 1: 6},
  //     };
  //     final matrixSize = 3;

  //     final result = cofactorMatrixUsecase(matrix, matrixSize);

  //     expect(result, {
  //       0: {0: -24, 1: 20, 2: -5},
  //       1: {0: 12, 1: -15, 2: 4},
  //       2: {0: -2, 1: -5, 2: 1},
  //     });
  //   });

  //   test('should calculate the minor matrix correctly', () {
  //     final matrix = {
  //       0: {0: 1, 1: 2, 2: 3},
  //       1: {0: 0, 1: 1, 2: 4},
  //       2: {0: 5, 1: 6, 2: 0},
  //     };
  //     final excludedRowIndex = 0;
  //     final excludedColumnIndex = 1;
  //     final matrixSize = 3;

  //     final result = cofactorMatrixUsecase.getMinor(
  //       matrix,
  //       excludedRowIndex,
  //       excludedColumnIndex,
  //       matrixSize,
  //     );

  //     expect(result, {
  //       0: {0: 0, 1: 4},
  //       1: {0: 5, 1: 0},
  //     });
  //   });
  // });
}
