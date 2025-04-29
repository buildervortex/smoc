class TraceUsecase {
  num call(Map<int, Map<int, num>> matrix, int matrixSize) {
    num sum = 0;
    for (int rowIndex = 0; rowIndex < matrixSize; rowIndex++) {
      if (matrix[rowIndex]?.containsKey(rowIndex) == true) {
        sum += matrix[rowIndex]![rowIndex]!;
      }
    }
    return sum;
  }
}
