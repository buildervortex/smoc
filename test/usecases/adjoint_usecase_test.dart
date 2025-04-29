import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/adjoint_usecase.dart';

void main() {
  group('AdjointUsecase', () {
    test('should return the adjoint of a 2x2 matrix', () {
      final usecase = AdjointUsecase();
      final matrix = {
        0: {0: 1, 1: 2},
        1: {0: 3, 1: 4},
      };
      final expectedAdjoint = {
        0: {0: 4, 1: -2},
        1: {0: -3, 1: 1},
      };

      final result = usecase(matrix, 2);

      expect(result, expectedAdjoint);
    });

    test('should return the adjoint of a 3x3 matrix', () {
      final usecase = AdjointUsecase();
      final matrix = {
        0: {0: 1, 1: 2, 2: 3},
        1: {1: 1, 2: 4},
        2: {0: 5, 1: 6},
      };
      final expectedAdjoint = {
        0: {0: -24, 1: 18, 2: 5},
        1: {0: 20, 1: -15, 2: -4},
        2: {0: -5, 1: 4, 2: 1},
      };

      final result = usecase(matrix, 3);

      expect(result, expectedAdjoint);
    });

    test('should handle an empty matrix', () {
      final usecase = AdjointUsecase();
      final matrix = <int, Map<int, num>>{};
      final expectedAdjoint = <int, Map<int, num>>{};

      final result = usecase(matrix, 0);

      expect(result, expectedAdjoint);
    });
  });
}
