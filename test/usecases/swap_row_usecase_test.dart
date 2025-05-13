import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/swap_row_usecase.dart';

void main() {
  group('SwaprowUsecase', () {
    final swapRowUsecase = SwapRowUsecase();

    test('3x3 matrix with zero pivot point', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {1: 2.0, 2: 3.0},
        1: {0: 4.0, 2: 5.0},
        2: {0: 6.0, 1: 7.0},
      };

      final Map<int, Map<int, num>> expectedPermutationMatrix = {
        0: {1: 1.0},
        1: {0: 1.0},
        2: {2: 1.0},
      };

      final result = swapRowUsecase(sparseMatrix, 3);

      expect(result, expectedPermutationMatrix);
      expect(sparseMatrix, {
        0: {0: 4.0, 2: 5.0},
        1: {1: 2.0, 2: 3.0},
        2: {0: 6.0, 1: 7.0},
      });
    });

    test('5x5 matrix with non-zero pivot points', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 1.0, 1: 2.0},
        1: {1: 3.0, 2: 4.0},
        2: {2: 5.0, 3: 6.0},
        3: {3: 7.0, 4: 8.0},
        4: {4: 9.0},
      };

      final Map<int, Map<int, num>> expectedPermutationMatrix = {
        0: {0: 1.0},
        1: {1: 1.0},
        2: {2: 1.0},
        3: {3: 1.0},
        4: {4: 1.0},
      };

      final result = swapRowUsecase(sparseMatrix, 5);

      expect(result, expectedPermutationMatrix);
      expect(sparseMatrix, {
        0: {0: 1.0, 1: 2.0},
        1: {1: 3.0, 2: 4.0},
        2: {2: 5.0, 3: 6.0},
        3: {3: 7.0, 4: 8.0},
        4: {4: 9.0},
      });
    });

    test('3x3 matrix with no swaps needed', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 1.0, 1: 2.0},
        1: {1: 3.0, 2: 4.0},
        2: {2: 5.0},
      };

      final Map<int, Map<int, num>> expectedPermutationMatrix = {
        0: {0: 1.0},
        1: {1: 1.0},
        2: {2: 1.0},
      };

      final result = swapRowUsecase(sparseMatrix, 3);

      expect(result, expectedPermutationMatrix);
      expect(sparseMatrix, {
        0: {0: 1.0, 1: 2.0},
        1: {1: 3.0, 2: 4.0},
        2: {2: 5.0},
      });
    });

    test('4x4 matrix with zero pivot point', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {1: 2.0, 2: 3.0, 3: 4.0},
        1: {0: 5.0, 2: 6.0, 3: 7.0},
        2: {0: 8.0, 1: 9.0, 3: 10.0},
        3: {0: 11.0, 1: 12.0, 2: 13.0},
      };

      final Map<int, Map<int, num>> expectedPermutationMatrix = {
        0: {1: 1.0},
        1: {0: 1.0},
        2: {3: 1.0},
        3: {2: 1.0},
      };

      final result = swapRowUsecase(sparseMatrix, 4);

      expect(result, expectedPermutationMatrix);
      expect(sparseMatrix, {
        0: {0: 5.0, 2: 6.0, 3: 7.0},
        1: {1: 2.0, 2: 3.0, 3: 4.0},
        2: {0: 11.0, 1: 12.0, 2: 13.0},
        3: {0: 8.0, 1: 9.0, 3: 10.0},
      });
    });

    test('5x5 matrix with multiple zero pivot points', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {1: 2.0, 2: 3.0, 3: 4.0, 4: 5.0},
        1: {0: 6.0, 2: 7.0, 3: 8.0, 4: 9.0},
        2: {0: 10.0, 1: 11.0, 3: 12.0, 4: 13.0},
        3: {0: 14.0, 1: 15.0, 2: 16.0, 4: 17.0},
        4: {0: 18.0, 1: 19.0, 2: 20.0, 3: 21.0},
      };

      final Map<int, Map<int, num>> expectedPermutationMatrix = {
        0: {1: 1.0},
        1: {0: 1.0},
        2: {3: 1.0},
        3: {2: 1.0},
        4: {4: 1.0},
      };

      final result = swapRowUsecase(sparseMatrix, 5);

      expect(result, expectedPermutationMatrix);
      expect(sparseMatrix, {
        0: {0: 6.0, 2: 7.0, 3: 8.0, 4: 9.0},
        1: {1: 2.0, 2: 3.0, 3: 4.0, 4: 5.0},
        2: {0: 14.0, 1: 15.0, 2: 16.0, 4: 17.0},
        3: {0: 10.0, 1: 11.0, 3: 12.0, 4: 13.0},
        4: {0: 18.0, 1: 19.0, 2: 20.0, 3: 21.0},
      });
    });

    test('4x4 matrix with no swaps needed', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 1.0, 1: 2.0, 2: 3.0, 3: 4.0},
        1: {1: 5.0, 2: 6.0, 3: 7.0},
        2: {2: 8.0, 3: 9.0},
        3: {3: 10.0},
      };

      final Map<int, Map<int, num>> expectedPermutationMatrix = {
        0: {0: 1.0},
        1: {1: 1.0},
        2: {2: 1.0},
        3: {3: 1.0},
      };

      final result = swapRowUsecase(sparseMatrix, 4);

      expect(result, expectedPermutationMatrix);
      expect(sparseMatrix, {
        0: {0: 1.0, 1: 2.0, 2: 3.0, 3: 4.0},
        1: {1: 5.0, 2: 6.0, 3: 7.0},
        2: {2: 8.0, 3: 9.0},
        3: {3: 10.0},
      });
    });

    test('5x5 matrix with zero pivot in the last row', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 1.0, 1: 2.0, 2: 3.0, 3: 4.0},
        1: {1: 5.0, 2: 6.0, 3: 7.0},
        2: {2: 8.0, 3: 9.0},
        3: {3: 10.0},
        4: {0: 11.0, 1: 12.0, 2: 13.0, 3: 14.0},
      };

      final Map<int, Map<int, num>> expectedPermutationMatrix = {
        0: {0: 1.0},
        1: {1: 1.0},
        2: {2: 1.0},
        3: {3: 1.0},
        4: {4: 1.0},
      };

      final result = swapRowUsecase(sparseMatrix, 5);

      expect(result, expectedPermutationMatrix);
      expect(sparseMatrix, {
        0: {0: 1.0, 1: 2.0, 2: 3.0, 3: 4.0},
        1: {1: 5.0, 2: 6.0, 3: 7.0},
        2: {2: 8.0, 3: 9.0},
        3: {3: 10.0},
        4: {0: 11.0, 1: 12.0, 2: 13.0, 3: 14.0},
      });
    });

    test('matrix with missing rows', () {
      final Map<int, Map<int, num>> sparseMatrix = {
        1: {0: 4, 1: 5.0, 2: 6.0, 3: 7.0},
        3: {3: 10.0, 2: 4},
        4: {0: 11.0, 1: 12.0, 2: 13.0, 3: 14.0},
      };

      final Map<int, Map<int, num>> expectedPermutationMatrix = {
        0: {1: 1.0},
        1: {4: 1.0},
        2: {3: 1.0},
        3: {2: 1.0},
        4: {0: 1.0},
      };

      final result = swapRowUsecase(sparseMatrix, 5);

      expect(result, expectedPermutationMatrix);
      expect(sparseMatrix, {
        0: {0: 4, 1: 5.0, 2: 6.0, 3: 7.0},
        1: {0: 11.0, 1: 12.0, 2: 13.0, 3: 14.0},
        2: {3: 10.0, 2: 4},
      });
    });
  });
}
