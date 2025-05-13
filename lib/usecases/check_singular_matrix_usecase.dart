class CheckSingularMatrixUsecase {
  bool call(Map<int, Map<int, num>> matrix, int matrixSize) {
    // check each row for zero pivot point values
    for (int rowIndex = 0; rowIndex < matrixSize - 1; rowIndex++) {
      final pivotColumnIndex = rowIndex;

      if (matrix[rowIndex] == null) {
        return true;
      } else if (!(matrix.containsKey(rowIndex))) {
        return true;
      } else if (matrix[rowIndex]?.isEmpty ?? true) {
        return true;
      } else if (!(matrix[rowIndex]?.containsKey(pivotColumnIndex) ?? false)) {
        return true;
      }
    }
    return false;
  }
}
