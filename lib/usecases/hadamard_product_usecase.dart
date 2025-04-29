class HadamardProductUsecase {
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
        if (!(matrix1[rowIndex]?.containsKey(columnIndex) ?? false)) {
          continue;
        }
        if (!(matrix2[rowIndex]?.containsKey(columnIndex) ?? false)) {
          continue;
        }
        num value1 = matrix1[rowIndex]![columnIndex]!;
        num value2 = matrix2[rowIndex]![columnIndex]!;
        result[rowIndex]![columnIndex] = value1 * value2;
      }
    }

    return result;
  }
}
