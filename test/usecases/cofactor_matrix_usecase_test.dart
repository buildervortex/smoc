import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/cofactor_matrix_usecase.dart';

void main() {
  group('CofactorMatrixUsecase', () {
    final cofactorMatrixUsecase = CofactorMatrixUsecase();

    test('should calculate the cofactor matrix correctly', () {
      final matrix = {
        0: {0: 1, 1: 2, 2: 3},
        1: {1: 1, 2: 4},
        2: {0: 5, 1: 6},
      };
      final matrixSize = 3;

      final result = cofactorMatrixUsecase(matrix, matrixSize);

      expect(result, {
        0: {0: -24, 1: 20, 2: -5},
        1: {0: 18, 1: -15, 2: 4},
        2: {0: 5, 1: -4, 2: 1},
      });
    });
    test('should calculate the cofactor matrix correctly for 4x4', () {
      final matrix = {
        0: {0: 1, 1: 2, 2: 3},
        1: {1: 1, 2: 4,3:5},
        2: {0: 5, 1: 6,3:2},
        3: {0: 4, 2: 5}
      };
      final matrixSize = 4;

      final result = cofactorMatrixUsecase(matrix, matrixSize);

      expect(result, {
        0: {0: 140.0, 1: -157.0, 2: -112.0,3:121.0},
        1: {0: 20.0, 1: 14.0, 2: -16.0,3:-92.0},
        2: {0: -50.0, 1: -35.0, 2: 40.0,3:-25.0},
        3: {0: -100.0, 1: 83.0, 2: -22.0,3:1.0},
      });
    });

    test('should calculate the minor matrix correctly', () {
      final matrix = {
        0: {0: 1, 1: 2, 2: 3},
        1: {0: 0, 1: 1, 2: 4},
        2: {0: 5, 1: 6, 2: 0},
      };
      final excludedRowIndex = 0;
      final excludedColumnIndex = 1;
      final matrixSize = 3;

      final result = cofactorMatrixUsecase.getMinor(
        matrix,
        excludedRowIndex,
        excludedColumnIndex,
        matrixSize,
      );

      expect(result, {
        0: {0: 0, 1: 4},
        1: {0: 5, 1: 0},
      });
    });
  });
}
