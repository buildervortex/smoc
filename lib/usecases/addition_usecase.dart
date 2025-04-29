class AdditionUsecase {
  Map<int, Map<int, num>> call(
    Map<int, Map<int, num>> matrix1,
    Map<int, Map<int, num>> matrix2,
    int rowCount,
    int columnCount,
  ) {
    Map<int, Map<int, num>> result = {};

    for (int rowIndex = 0; rowIndex < rowCount; rowIndex++) {
      result[rowIndex] = {};
      for (int columnIndex = 0; columnIndex < columnCount; columnIndex++) {
        bool matrix1ElementExists =
            matrix1[rowIndex]?.containsKey(columnIndex) ?? false;
        bool matrix2ElementExists =
            matrix2[rowIndex]?.containsKey(columnIndex) ?? false;
        if (matrix1ElementExists && !(matrix2ElementExists)) {
          result[rowIndex]![columnIndex] = matrix1[rowIndex]![columnIndex]!;
          continue;
        } else if (matrix2ElementExists && !(matrix1ElementExists)) {
          result[rowIndex]![columnIndex] = matrix2[rowIndex]![columnIndex]!;
          continue;
        } else if (matrix1ElementExists && matrix2ElementExists) {
          var data = matrix1[rowIndex]![columnIndex]! +
              matrix2[rowIndex]![columnIndex]!;
          if (data != 0) {
            result[rowIndex]![columnIndex] = data;
          }
          continue;
        }
      }
      if (result[rowIndex]!.isEmpty) {
        result.remove(rowIndex);
      }
    }

    return result;
  }
}
