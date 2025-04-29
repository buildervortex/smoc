import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/transpose_usecase.dart';

void main() {
  group('TransposeUsecase', () {
    final transposeUsecase = TransposeUsecase();

    test('should transpose a simple 2x2 matrix', () {
      final inputMatrix = {
        0: {0: 1, 1: 2},
        1: {0: 3, 1: 4},
      };

      final expectedOutput = {
        0: {0: 1, 1: 3},
        1: {0: 2, 1: 4},
      };

      final result = transposeUsecase(inputMatrix);

      expect(result, equals(expectedOutput));
    });

    test('should transpose a sparse matrix', () {
      final inputMatrix = {
        0: {1: 5},
        2: {0: 3, 2: 8},
      };

      final expectedOutput = {
        0: {2: 3},
        1: {0: 5},
        2: {2: 8},
      };

      final result = transposeUsecase(inputMatrix);

      expect(result, equals(expectedOutput));
    });

    test('should handle an empty matrix', () {
      final inputMatrix = <int, Map<int, num>>{};

      final expectedOutput = <int, Map<int, num>>{};

      final result = transposeUsecase(inputMatrix);

      expect(result, equals(expectedOutput));
    });

    test('should handle a matrix with a single element', () {
      final inputMatrix = {
        0: {0: 42},
      };

      final expectedOutput = {
        0: {0: 42},
      };

      final result = transposeUsecase(inputMatrix);

      expect(result, equals(expectedOutput));
    });

    test('should transpose a rectangular matrix', () {
      final inputMatrix = {
        0: {0: 1, 1: 2, 2: 3},
        1: {0: 4, 1: 5, 2: 6},
      };

      final expectedOutput = {
        0: {0: 1, 1: 4},
        1: {0: 2, 1: 5},
        2: {0: 3, 1: 6},
      };

      final result = transposeUsecase(inputMatrix);

      expect(result, equals(expectedOutput));
    });
  });
}