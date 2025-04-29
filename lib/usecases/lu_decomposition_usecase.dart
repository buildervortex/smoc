import 'package:smo/usecases/check_singular_matrix_usecase.dart';
import 'package:smo/usecases/swap_row_usecase.dart';

class LuDecompositionUsecase {
  LuDecompositionResult? call(
      Map<int, Map<int, num>> sparseMatrix, int matrixSize) {
    // Step 1: Swap rows to get a non-zero pivot
    var premutationMatrix = SwapRowUsecase()(sparseMatrix, matrixSize);
    // Step 2: Check for singular matrix
    // If the matrix is singular, return null
    if (CheckSingularMatrixUsecase()(sparseMatrix, matrixSize)) {
      return null;
    }
    var L = getL(matrixSize);

    // Step 3: Perform Gaussian elimination
    for (int rowIndex = 0; rowIndex < matrixSize; rowIndex++) {
      int pivotIndex = rowIndex;

      for (int downRowIndex = rowIndex + 1;
          downRowIndex < matrixSize;
          downRowIndex++) {
        if (!(sparseMatrix[downRowIndex]?.containsKey(pivotIndex) ?? false)) {
          continue;
        }

        var pivotRowContent = Map<int, num>.from(sparseMatrix[rowIndex]!);
        var downRowContent = Map<int, num>.from(sparseMatrix[downRowIndex]!);

        if (pivotRowContent[pivotIndex] == 0) {
          continue;
        }

        num multiplier =
            downRowContent[pivotIndex]! / pivotRowContent[pivotIndex]!;
        L![downRowIndex]![pivotIndex] = multiplier;

        var substractor = multiplyRow(pivotRowContent, multiplier);
        var substractedDownRow = subtractRow(downRowContent, substractor);

        sparseMatrix[downRowIndex] = substractedDownRow;

        if (sparseMatrix[downRowIndex]!.isEmpty) {
          sparseMatrix.remove(downRowIndex);
        }
      }
    }
    return LuDecompositionResult(L!, sparseMatrix, premutationMatrix);
  }

  Map<int, num> multiplyRow(Map<int, num> row, num multiplier) {
    var result = <int, num>{};
    row.forEach((column, value) {
      result[column] = value * multiplier;
    });
    return result;
  }

  Map<int, num> subtractRow(Map<int, num> row, Map<int, num> subtractor) {
    var result = Map<int, num>.from(row);
    for (var column in subtractor.keys) {
      if (result.containsKey(column)) {
        result[column] = result[column]! - subtractor[column]!;
        if (result[column] == 0) {
          result.remove(column);
        }
      } else {
        result[column] = -subtractor[column]!;
        if (result[column] == 0) {
          result.remove(column);
        }
      }
    }
    return result;
  }

  Map<int, Map<int, num>>? getL(int matrixSize) {
    var L = <int, Map<int, num>>{};
    for (int i = 0; i < matrixSize; i++) {
      L[i] = <int, num>{};
      L[i]![i] = 1;
    }
    return L;
  }
}

class LuDecompositionResult {
  final Map<int, Map<int, num>> L;
  final Map<int, Map<int, num>> U;
  final Map<int, Map<int, num>> P;

  LuDecompositionResult(this.L, this.U, this.P);
}
