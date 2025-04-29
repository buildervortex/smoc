import 'package:flutter_test/flutter_test.dart';
import 'package:smo/usecases/hadamard_product_usecase.dart';

void main() {
  group('HadamardProductUsecase', () {
    final hadamardProductUsecase = HadamardProductUsecase();

    test('should return correct Hadamard product for two matrices', () {
      final Map<int, Map<int, num>> matrix1 = {
        0: {0: 1, 1: 2},
        1: {0: 3, 1: 4},
      };
      final Map<int, Map<int, num>> matrix2 = {
        0: {0: 5, 1: 6},
        1: {0: 7, 1: 8},
      };
      final expected = {
        0: {0: 5, 1: 12},
        1: {0: 21, 1: 32},
      };

      final result = hadamardProductUsecase(matrix1, matrix2, 2, 2);

      expect(result, expected);
    });

    test('should handle matrices with missing values', () {
      final Map<int, Map<int, num>> matrix1 = {
        0: {0: 1},
        1: {1: 4},
      };
      final Map<int, Map<int, num>> matrix2 = {
        0: {1: 6},
        1: {0: 7},
      };
      final expected = {
        0: {},
        1: {},
      };

      final result = hadamardProductUsecase(matrix1, matrix2, 2, 2);

      expect(result, expected);
    });

    // test('should handle matrices with different dimensions', () {
    //   final Map<int,Map<int,num>> matrix1 = {
    //     0: {0: 1, 1: 2},
    //   };
    //   final Map<int,Map<int,num>> matrix2 = {
    //     0: {0: 3},
    //     1: {1: 4},
    //   };
    //   final expected = {
    //     0: {0: 3},
    //   };

    //   final result = hadamardProductUsecase(matrix1, matrix2, 2, 2);

    //   expect(result, expected);
    // });

    test('should handle matrices with zero values', () {
      final matrix1 = {
        0: {0: 0, 1: 2},
        1: {0: 3, 1: 0},
      };
      final matrix2 = {
        0: {0: 5, 1: 0},
        1: {0: 0, 1: 8},
      };
      final expected = {
        0: {0: 0, 1: 0},
        1: {0: 0, 1: 0},
      };

      final result = hadamardProductUsecase(matrix1, matrix2, 2, 2);

      expect(result, expected);
    });
  });
}
