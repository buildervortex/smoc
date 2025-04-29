import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/scaler_division_usecase.dart';

void main() {
  group('scalerDivision', () {
    final scalerDivision = ScalerDivisionUsecase();

    test('should divide all elements of the matrix by the given divider', () {
      final matrix = {
        0: {0: 4, 1: 8},
        1: {0: 6, 1: 12},
      };
      final divider = 2;

      final result = scalerDivision.call(matrix, divider);

      expect(result, {
        0: {0: 2.0, 1: 4.0},
        1: {0: 3.0, 1: 6.0},
      });
    });

    test('should throw an error when divider is zero', () {
      final matrix = {
        0: {0: 4, 1: 8},
        1: {0: 6, 1: 12},
      };
      final divider = 0;

      expect(() => scalerDivision.call(matrix, divider), throwsArgumentError);
    });

    test('should return an empty matrix when input matrix is empty', () {
      final matrix = <int, Map<int, num>>{};
      final divider = 2;

      final result = scalerDivision.call(matrix, divider);

      expect(result, isEmpty);
    });

    test('should handle matrices with zero values correctly', () {
      final matrix = {
        0: {0: 0, 1: 8},
        1: {0: 6, 1: 0},
      };
      final divider = 2;

      final result = scalerDivision.call(matrix, divider);

      expect(result, {
        0: {1: 4.0},
        1: {0: 3.0},
      });
    });

    test('should handle negative values in the matrix', () {
      final matrix = {
        0: {0: -4, 1: 8},
        1: {0: 6, 1: -12},
      };
      final divider = 2;

      final result = scalerDivision.call(matrix, divider);

      expect(result, {
        0: {0: -2.0, 1: 4.0},
        1: {0: 3.0, 1: -6.0},
      });
    });
  });
}
