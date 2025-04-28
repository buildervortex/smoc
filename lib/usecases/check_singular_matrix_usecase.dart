class CheckSingularMatrixUsecase {
  bool call(Map<int, Map<int, num>> matrix, int matrixSize) {
    for (int rowIndex = 0; rowIndex < matrixSize; rowIndex++) {
      if (matrix[rowIndex] == null ||
          !matrix[rowIndex]!.containsKey(rowIndex)) {
        return true;
      }
    }
    return false;
  }
}
