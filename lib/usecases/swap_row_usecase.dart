class SwapRowUsecase {
  Map<int, Map<int, num>> call(
      Map<int, Map<int, num>> sparseMatrix, int matrixSize) {
    // Create the permuntation matrix
    Map<int, Map<int, num>> perm = {};
    for (int i = 0; i < matrixSize; i++) {
      // set the row
      perm[i] = {};
      perm[i]![i] = 1.0;
    }

    // Swap the rows
    for (int rowIndex = 0; rowIndex < matrixSize; rowIndex++) {
      int pivotIndex = rowIndex;

      if (sparseMatrix[rowIndex]?.containsKey(pivotIndex) ?? false) {
        continue;
      }

      for (int downRowIndex = rowIndex + 1;
          downRowIndex < matrixSize;
          downRowIndex++) {
        if (!(sparseMatrix[downRowIndex]?.containsKey(pivotIndex) ?? false)) {
          continue;
        }

        var currentRowContent = sparseMatrix[rowIndex];
        Map<int, num> downRowContent = sparseMatrix[downRowIndex]!;

        sparseMatrix[rowIndex] = downRowContent;

        if (currentRowContent == null) {
          sparseMatrix.remove(downRowIndex);
        } else {
          sparseMatrix[downRowIndex] = currentRowContent;
        }

        // Swap the permutation matrix
        Map<int, num> tempRow = perm[rowIndex]!;
        perm[rowIndex] = perm[downRowIndex]!;
        perm[downRowIndex] = tempRow;
        break;
      }
    }
    return perm;
  }
}
