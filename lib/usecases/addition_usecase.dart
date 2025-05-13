class AdditionUsecase {
  Map<int, Map<int, num>> call(
    Map<int, Map<int, num>> matrix1,
    Map<int, Map<int, num>> matrix2,
    int matrixRowCount,
    int matrixColumnCount,
  ) {
    // create empty dok type sparse matrix
    Map<int, Map<int, num>> result = {};

    for (int rowIndex = 0; rowIndex < matrixRowCount; rowIndex++) {
      // add new empty dictionary to hold the columns
      result[rowIndex] = {};

      for (int columnIndex = 0;
          columnIndex < matrixColumnCount;
          columnIndex++) {
        bool elementExistsInMatrix1 =
            matrix1[rowIndex]?.containsKey(columnIndex) ?? false;
        bool elementExistsInMatrix2 =
            matrix2[rowIndex]?.containsKey(columnIndex) ?? false;

        // if the matrix2 element is zero, set the result as matrix 1 element
        if (elementExistsInMatrix1 && !(elementExistsInMatrix2)) {
          result[rowIndex]![columnIndex] = matrix1[rowIndex]![columnIndex]!;
          continue;
        }
        // if matrix1 element is zero, set result as matrix2 element
        else if (elementExistsInMatrix2 && !(elementExistsInMatrix1)) {
          result[rowIndex]![columnIndex] = matrix2[rowIndex]![columnIndex]!;
          continue;
        }
        // if both matrix1 and matrix2 element are non-zero, add together
        else if (elementExistsInMatrix1 && elementExistsInMatrix2) {
          var data = matrix1[rowIndex]![columnIndex]! +
              matrix2[rowIndex]![columnIndex]!;
          // only add the column if the addition result is not zero
          if (data != 0) {
            result[rowIndex]![columnIndex] = data;
          }
          continue;
        }
      }
      // if no column is in the row, remove the empty row
      if (result[rowIndex]!.isEmpty) {
        result.remove(rowIndex);
      }
    }

    return result;
  }
}
