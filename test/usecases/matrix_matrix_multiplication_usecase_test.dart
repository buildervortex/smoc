import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/matrix_matrix_multiplication_usecase.dart';

void main() {
  group('MatrixMatrixMultiplicationUsecase', () {
    final usecase = MatrixMatrixMultiplicationUsecase();

    test('should multiply two valid matrices correctly', () {
      final matrix1 = {
        0: {0: 1, 1: 2},
        1: {0: 3, 1: 4},
      };
      final matrix2 = {
        0: {0: 5, 1: 6},
        1: {0: 7, 1: 8},
      };

      final result = usecase.call(matrix1, 2, 2, matrix2, 2, 2);

      expect(result, {
        0: {0: 19, 1: 22},
        1: {0: 43, 1: 50},
      });
    });

    test('should calculate the mulitiplication for one dimention', () {
      final matrix1 = {
        0: {0: 1, 1: 2},
      };
      final matrix2 = {
        0: {0: 3},
        1: {0: 4},
      };

      final result = usecase.call(matrix1, 1, 2, matrix2, 2, 1);

      expect(result, {
        0: {0: 11},
      });
    });

    test('should handle sparse matrices correctly', () {
      final matrix1 = {
        0: {0: 1},
        2: {1: 2},
      };
      final matrix2 = {
        0: {0: 3, 1: 4},
        1: {0: 5, 1: 6},
      };

      final result = usecase.call(matrix1, 3, 2, matrix2, 2, 2);

      expect(result, {
        0: {0: 3, 1: 4},
        2: {0: 10, 1: 12},
      });
    });

    test('should return a zero matrix when all elements are zero', () {
      final matrix1 = {
        0: {0: 0, 1: 0},
        1: {0: 0, 1: 0},
      };
      final matrix2 = {
        0: {0: 0, 1: 0},
        1: {0: 0, 1: 0},
      };

      final result = usecase.call(matrix1, 2, 2, matrix2, 2, 2);

      expect(result, {});
    });

    test('should throw an exception for incompatible matrices', () {
      final matrix1 = {
        0: {0: 1, 1: 2},
      };
      final matrix2 = {
        0: {0: 3},
      };

      expect(() => usecase.call(matrix1, 1, 2, matrix2, 1, 1),
          throwsA(isA<Exception>()));
    });
  });
}
