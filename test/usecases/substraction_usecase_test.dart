import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/substraction_usecase.dart';

void main() {
  group('SubstractionUsecase', () {
    final substractionUsecase = SubstractionUsecase();

    test('should return correct result for two matrices with same dimensions',
        () {
      final matrix1 = {
        0: {0: 5, 1: 3},
        1: {0: 2, 1: 4},
      };
      final matrix2 = {
        0: {0: 2, 1: 1},
        1: {0: 1, 1: 3},
      };
      final result = substractionUsecase(matrix1, matrix2, 2, 2);

      expect(result, {
        0: {0: 3, 1: 2},
        1: {0: 1, 1: 1},
      });
    });

    test('should handle matrices with missing elements', () {
      final matrix1 = {
        0: {0: 5},
        1: {1: 4},
      };
      final matrix2 = {
        0: {1: 1},
        1: {0: 1},
      };
      final result = substractionUsecase(matrix1, matrix2, 2, 2);

      expect(result, {
        0: {0: 5, 1: -1},
        1: {0: -1, 1: 4},
      });
    });


    test('should handle matrices with zero differences', () {
      final matrix1 = {
        0: {0: 5, 1: 3},
        1: {0: 2, 1: 4},
      };
      final matrix2 = {
        0: {0: 5, 1: 3},
        1: {0: 2, 1: 4},
      };
      final result = substractionUsecase(matrix1, matrix2, 2, 2);

      expect(result, {});
    });

    test('should handle negative results correctly', () {
      final matrix1 = {
        0: {0: 2, 1: 1},
        1: {0: 1, 1: 3},
      };
      final matrix2 = {
        0: {0: 5, 1: 3},
        1: {0: 2, 1: 4},
      };
      final result = substractionUsecase(matrix1, matrix2, 2, 2);

      expect(result, {
        0: {0: -3, 1: -2},
        1: {0: -1, 1: -1},
      });
    });
  });
}
