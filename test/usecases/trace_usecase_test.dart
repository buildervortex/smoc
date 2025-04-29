import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/trace_usecase.dart';

void main() {
  group('TraceUsecase', () {
    final traceUsecase = TraceUsecase();

    test('should return the correct trace for a valid square matrix', () {
      final matrix = {
        0: {0: 1, 1: 2},
        1: {0: 3, 1: 4},
      };
      final result = traceUsecase.call(matrix, 2);
      expect(result, 5); // 1 + 4
    });

    test('should return 0 for an empty matrix', () {
      final matrix = <int, Map<int, num>>{};
      final result = traceUsecase.call(matrix, 0);
      expect(result, 0);
    });

    test(
        'should return the correct trace for a matrix with missing diagonal elements',
        () {
      final matrix = {
        0: {1: 2},
        1: {0: 3},
      };
      final result = traceUsecase.call(matrix, 2);
      expect(result, 0); // No diagonal elements
    });

    test('should handle a matrix with negative numbers', () {
      final matrix = {
        0: {0: -1, 1: 2},
        1: {0: 3, 1: -4},
      };
      final result = traceUsecase.call(matrix, 2);
      expect(result, -5); // -1 + (-4)
    });

    test(
        'should handle a matrix with non-square structure but valid diagonal elements',
        () {
      final matrix = {
        0: {0: 1, 1: 2},
        1: {1: 4},
        2: {2: 6},
      };
      final result = traceUsecase.call(matrix, 3);
      expect(result, 11); // 1 + 4 + 6
    });
  });
}
