import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/scaler_multiplication.dart';

void main() {
  group('ScalerMultiplication', () {
    final scalerMultiplication = ScalerMultiplication();

    test('should scale a non-empty sparse matrix correctly', () {
      final matrix = {
        0: {0: 1, 1: 2},
        1: {0: 3, 1: 4},
      };
      final scaler = 2;

      final result = scalerMultiplication.call(matrix, scaler);

      expect(result, {
        0: {0: 2, 1: 4},
        1: {0: 6, 1: 8},
      });
    });

    test('should return an empty matrix when scaling an empty matrix', () {
      final matrix = <int, Map<int, num>>{};
      final scaler = 5;

      final result = scalerMultiplication.call(matrix, scaler);

      expect(result, {});
    });

    test('should handle scaling with a zero scaler', () {
      final matrix = {
        0: {0: 1, 1: 2},
        1: {0: 3, 1: 4},
      };
      final scaler = 0;

      final result = scalerMultiplication.call(matrix, scaler);

      expect(result, {});
    });

    test('should handle scaling with a negative scaler', () {
      final matrix = {
        0: {0: 1, 1: -2},
        1: {0: -3, 1: 4},
      };
      final scaler = -1;

      final result = scalerMultiplication.call(matrix, scaler);

      expect(result, {
        0: {0: -1, 1: 2},
        1: {0: 3, 1: -4},
      });
    });

    test('should ignore zero values in the matrix', () {
      final matrix = {
        0: {0: 0, 1: 2},
        1: {0: 3, 1: 0},
      };
      final scaler = 3;

      final result = scalerMultiplication.call(matrix, scaler);

      expect(result, {
        0: {1: 6},
        1: {0: 9},
      });
    });
  });
}