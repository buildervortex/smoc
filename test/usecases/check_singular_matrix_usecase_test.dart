import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/check_singular_matrix_usecase.dart';

void main() {
  group('CheckSingularMatrixUsecase', () {
    final usecase = CheckSingularMatrixUsecase();

    test(
        'should return true for a singular matrix with missing diagonal elements',
        () {
      final matrix = {
        0: {1: 2.0},
        1: {0: 3.0},
      };
      final result = usecase(matrix, 2);
      expect(result, true);
    });

    test(
        'should return false for a non-singular matrix with all diagonal elements present',
        () {
      final matrix = {
        0: {0: 1.0, 1: 2.0},
        1: {0: 3.0, 1: 4.0},
      };
      final result = usecase(matrix, 2);
      expect(result, false);
    });

    test('should return true for a matrix with a missing diagonal key', () {
      final matrix = {
        0: {1: 2.0},
        1: {0: 3.0},
      };
      final result = usecase(matrix, 2);
      expect(result, true);
    });

    test('should return false for an empty matrix of size 0', () {
      final matrix = <int, Map<int, double>>{};
      final result = usecase(matrix, 0);
      expect(result, false);
    });
  });
}
