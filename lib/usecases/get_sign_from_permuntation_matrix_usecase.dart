class GetSignFromPermuntationMatrixUsecase {
  int call(Map<int, Map<int, num>> sparseMatrix, int matrixSize) {
    int swapCount = 0;
    int sign = 1;
    for (int rowIndex = 0; rowIndex < matrixSize; rowIndex++) {
      if (!(sparseMatrix[rowIndex]?.containsKey(rowIndex) ?? false)) {
        swapCount++;
      }
    }
    if (swapCount == 0) {
      return 1;
    }
    return (swapCount - 1) % 2 == 0 ? sign : -sign;
  }
}
