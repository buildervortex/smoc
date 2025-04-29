import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/addition_usecase.dart';

void main() {
  group('AdditionUsecase', () {
    final usecase = AdditionUsecase();

    test('should return the sum of two matrices', () {
      final matrix1 = {
        0: {0: 1, 1: 2},
        1: {0: 3, 1: 4},
      };
      final matrix2 = {
        0: {0: 5, 1: 6},
        1: {0: 7, 1: 8},
      };
      final expected = {
        0: {0: 6, 1: 8},
        1: {0: 10, 1: 12},
      };

      final result = usecase(matrix1, matrix2, 2, 2);

      expect(result, expected);
    });

    test('should handle matrices with missing elements', () {
      final matrix1 = {
        0: {0: 1},
        1: {1: 4},
      };
      final matrix2 = {
        0: {1: 6},
        1: {0: 7},
      };
      final expected = {
        0: {0: 1, 1: 6},
        1: {0: 7, 1: 4},
      };

      final result = usecase(matrix1, matrix2, 2, 2);

      expect(result, expected);
    });

    test('should handle matrices with overlapping and non-overlapping elements',
        () {
      final matrix1 = {
        0: {0: 1, 1: 2},
        1: {0: 3},
      };
      final matrix2 = {
        0: {1: 6},
        1: {0: 7, 1: 8},
      };
      final expected = {
        0: {0: 1, 1: 8},
        1: {0: 10, 1: 8},
      };

      final result = usecase(matrix1, matrix2, 2, 2);

      expect(result, expected);
    });

    test('should return an empty matrix when both matrices are empty', () {
      final matrix1 = <int, Map<int, num>>{};
      final matrix2 = <int, Map<int, num>>{};
      final expected = <int, Map<int, num>>{};

      final result = usecase(matrix1, matrix2, 0, 0);

      expect(result, expected);
    });
  });
}
