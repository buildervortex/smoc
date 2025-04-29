import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/inverse_usecase.dart';

void main() {
  group('InverseUsecase', () {
    final inverseUsecase = InverseUsecase();

    test('should return the inverse of a 2x2 matrix', () {
      final Map<int, Map<int, num>> matrix = {
        0: {0: 4, 1: 7},
        1: {0: 2, 1: 6},
      };
      final expectedInverse = {
        0: {0: 3 / 5, 1: -7 / 10},
        1: {0: -1 / 5, 1: 2 / 5},
      };

      final result = inverseUsecase(matrix, 2);

      expect(result, expectedInverse);
    });

    test('should throw an exception for a singular matrix', () {
      final Map<int, Map<int, num>> matrix = {
        0: {0: 1, 1: 2},
        1: {0: 2, 1: 4},
      };

      expect(() => inverseUsecase(matrix, 2), throwsException);
    });

    test('should return the inverse of a 3x3 matrix', () {
      final Map<int, Map<int, num>> matrix = {
        0: {0: 6, 1: 1, 2: 1},
        1: {0: 4, 1: -2, 2: 5},
        2: {0: 2, 1: 8, 2: 7},
      };
      final expectedInverse = {
        0: {0: 3 / 17, 1: -1 / 306, 2: -7 / 306},
        1: {0: 1 / 17, 1: -20 / 153, 2: 13 / 153},
        2: {0: -2 / 17, 1: 23 / 153, 2: 8 / 153},
      };

      final result = inverseUsecase(matrix, 3);

      expect(result, expectedInverse);
    });
  });
}
