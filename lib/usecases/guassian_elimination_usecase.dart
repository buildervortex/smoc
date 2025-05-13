import 'package:smo/usecases/check_singular_matrix_usecase.dart';
import 'package:smo/usecases/swap_row_usecase.dart';

class GuassianEliminationUsecase {
  Map<int, Map<int, num>> call(
      Map<int, Map<int, num>> sparseMatrix, int matrixSize) {
    // Swap the rows in the matrix to make sure each row pivot point contains non-zero element
    var premutationMatrix = SwapRowUsecase()(sparseMatrix, matrixSize);

    // If the matrix is singular, return permutationMatrix without processing guassian elimination. because this will cause zero-division error
    if (CheckSingularMatrixUsecase()(sparseMatrix, matrixSize)) {
      return premutationMatrix;
    }

    // guassian elimination
    for (int rowIndex = 0; rowIndex < matrixSize; rowIndex++) {
      int pivotColumnIndex = rowIndex;

      for (int downRowIndex = rowIndex + 1;
          downRowIndex < matrixSize;
          downRowIndex++) {
        // if down row already zero, skip the current down row.
        if (!(sparseMatrix[downRowIndex]?.containsKey(pivotColumnIndex) ??
            false)) {
          continue;
        }

        var pivotRowContent = Map<int, num>.from(sparseMatrix[rowIndex]!);
        var downRowContent = Map<int, num>.from(sparseMatrix[downRowIndex]!);

        if (pivotRowContent[pivotColumnIndex] == 0) {
          continue;
        }

        num multiplier = downRowContent[pivotColumnIndex]! /
            pivotRowContent[pivotColumnIndex]!;

        var substractor = multiplyRow(pivotRowContent, multiplier);
        var substractedDownRow = subtractRow(downRowContent, substractor);

        sparseMatrix[downRowIndex] = substractedDownRow;

        if (sparseMatrix[downRowIndex]!.isEmpty) {
          sparseMatrix.remove(downRowIndex);
        }
      }
    }
    return premutationMatrix;
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
}
