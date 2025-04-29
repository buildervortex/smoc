import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/guassian_elimination_usecase.dart';

void main() {
  group('GuassianEliminationUsecase', () {
    final guassianEliminationUsecase = GuassianEliminationUsecase();

    test('should return null for singular matrix', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {1: 2},
        1: {1: 4},
      };
      final matrixSize = 2;

      final result = guassianEliminationUsecase(sparseMatrix, matrixSize);

      expect(result, isNull);
    });

    test('should perform Gaussian elimination correctly', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 2, 1: 1},
        1: {0: 4, 1: 3},
      };
      final matrixSize = 2;

      final result = guassianEliminationUsecase(sparseMatrix, matrixSize);

      expect(result, isNotNull);
      expect(sparseMatrix[1]!.containsKey(0),
          isFalse); // Validate that [1][0] does not exist
    });

    test('should return correct permutation matrix', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 0, 1: 1},
        1: {0: 2, 1: 3},
      };
      final matrixSize = 2;

      final result = guassianEliminationUsecase(sparseMatrix, matrixSize);

      expect(result, isNotNull);
      expect(result![0]![0], 1); // Check if the permutation matrix is correct
      expect(result[1]![1], 1);
    });

    test(
        'should validate Gaussian elimination operations for each non-zero element',
        () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 2, 1: 1, 2: -1},
        1: {0: -3, 1: -1, 2: 2},
        2: {0: -2, 1: 1, 2: 2},
      };
      final matrixSize = 3;

      final result = guassianEliminationUsecase(sparseMatrix, matrixSize);

      expect(result, isNotNull);

      // Validate that the first column below the pivot is zero
      expect(sparseMatrix[1]!.containsKey(0), isFalse);
      expect(sparseMatrix[2]!.containsKey(0), isFalse);

      // Validate that the second column below the pivot is zero
      expect(sparseMatrix[2]!.containsKey(1), isFalse);

      // Validate the remaining non-zero elements
      expect(sparseMatrix[0]![0], 2);
      expect(sparseMatrix[0]![1], 1);
      expect(sparseMatrix[0]![2], -1);
      expect(sparseMatrix[1]![1], 0.5);
      expect(sparseMatrix[1]![2], 0.5);
      expect(sparseMatrix[2]![2], -1);
    });
  });
}
