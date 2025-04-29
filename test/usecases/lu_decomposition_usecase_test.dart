import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/lu_decomposition_usecase.dart';

void main() {
  group('LuDecompositionUsecase', () {
    test('should return null for a singular matrix', () {
      final usecase = LuDecompositionUsecase();
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {1: 2},
        1: {1: 4},
      };
      final result = usecase(sparseMatrix, 2);
      expect(result, isNull);
    });

    test('should perform LU decomposition for a non-singular matrix', () {
      final usecase = LuDecompositionUsecase();
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 2, 1: 3},
        1: {0: 4, 1: 7},
      };
      final result = usecase(sparseMatrix, 2);

      expect(result, isNotNull);
      expect(result!.L, {
        0: {0: 1},
        1: {0: 2, 1: 1},
      });
      expect(result.U, {
        0: {0: 2, 1: 3},
        1: {1: 1},
      });
      expect(result.P, isNotNull);
    });
    test('should perform LU decomposition for a non-singular matrix1', () {
      final usecase = LuDecompositionUsecase();
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 2, 1: 1, 2: 1},
        1: {0: 4, 1: -6},
        2: {0: -2, 1: 7, 2: 2},
      };
      final result = usecase(sparseMatrix, 3);

      expect(result, isNotNull);
      expect(result!.U, {
        0: {0: 2, 1: 1, 2: 1},
        1: {1: -8, 2: -2},
        2: {2: 1},
      });
      expect(result.L, {
        0: {0: 1},
        1: {0: 2, 1: 1},
        2: {0: -1, 1: -1, 2: 1},
      });
      expect(result.P, isNotNull);
    });

    test('should handle an empty matrix', () {
      final usecase = LuDecompositionUsecase();
      final Map<int, Map<int, num>> sparseMatrix = <int, Map<int, num>>{};
      final result = usecase(sparseMatrix, 0);

      expect(result, isNotNull);
      expect(result!.L, isEmpty);
      expect(result.U, isEmpty);
      expect(result.P, isEmpty);
    });

    test('should handle a 1x1 matrix', () {
      final usecase = LuDecompositionUsecase();
      final Map<int, Map<int, num>> sparseMatrix = {
        0: {0: 5},
      };
      final result = usecase(sparseMatrix, 1);

      expect(result, isNotNull);
      expect(result!.L, {
        0: {0: 1},
      });
      expect(result.U, {
        0: {0: 5},
      });
      expect(result.P, isNotNull);
    });
  });
}
