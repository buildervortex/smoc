import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/determinant_usecase.dart';

void main() {
  group('DeterminantUsecase', () {
    final determinantUsecase = DeterminantUsecase();

    test('should return correct determinant for a non-singular matrix', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 2, 1: 1},
        1: {0: 1, 1: 3},
      };
      final matrixSize = 2;

      final result = determinantUsecase(sparseMatrix, matrixSize);

      expect(result, equals(5)); // Determinant = 2*3 - 1*1 = 5
    });

    test('should return null for a singular matrix', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {1: 2},
        1: {1: 4},
      };
      final matrixSize = 2;

      final result = determinantUsecase(sparseMatrix, matrixSize);

      expect(result, isNull); // Singular matrix, determinant is 0
    });

    test('should return correct sign and determinant for a larger matrix', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 6, 1: 1, 2: 1},
        1: {0: 4, 1: -2, 2: 5},
        2: {0: 2, 1: 8, 2: 7},
      };
      final matrixSize = 3;

      final result = determinantUsecase(sparseMatrix, matrixSize);

      expect(result, equals(-306)); // Determinant calculated manually
    });

    test(
        'should return correct determinant for a 2x2 matrix with negative values',
        () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: -3, 1: 2},
        1: {0: 4, 1: -5},
      };
      final matrixSize = 2;

      final result = determinantUsecase(sparseMatrix, matrixSize);

      expect(result, equals(7)); // Determinant = (-3)*(-5) - (2*4) = 7
    });

    test('should return correct determinant for a 3x3 matrix with zeros', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 1, 2: 2},
        1: {1: 3},
        2: {0: 4, 2: 5},
      };
      final matrixSize = 3;

      final result = determinantUsecase(sparseMatrix, matrixSize);

      expect(result, equals(-9)); // Determinant calculated manually
    });

    test('should return correct determinant for a 4x4 matrix', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 1, 1: 2, 2: 3, 3: 4},
        1: {0: 5, 1: 6, 2: 7, 3: 8},
        2: {0: 9, 1: 10, 2: 11, 3: 12},
        3: {0: 13, 1: 14, 2: 15, 3: 16},
      };
      final matrixSize = 4;

      final result = determinantUsecase(sparseMatrix, matrixSize);
      print(result);

      expect(result, equals(0)); // Determinant = 0 for this singular matrix
    });

    test(
        'should return correct determinant for a 3x3 matrix with all negative values',
        () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: -2, 1: -3, 2: -1},
        1: {0: -4, 1: -5, 2: -6},
        2: {0: -7, 1: -8, 2: -9},
      };
      final matrixSize = 3;

      final result = determinantUsecase(sparseMatrix, matrixSize);

      expect(result, equals(-9)); // Determinant = 0 for this singular matrix
    });
  });
}
