class GetSignFromPermuntationMatrixUsecase {
  int call(Map<int, Map<int, num>> sparseMatrix, int matrixSize) {
    int sign = 1;
    for (int rowIndex = 0; rowIndex < matrixSize; rowIndex++) {
      if (!(sparseMatrix[rowIndex]?.containsKey(rowIndex) ?? false)) {
        sign *= -1;
      }
    }
    return sign;
  }
}
