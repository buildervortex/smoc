class SwapRowUsecase {
  Map<int, Map<int, num>> call(
      Map<int, Map<int, num>> sparseMatrix, int matrixSize) {
    // Create the base identity permuntation matrix
    final permutationMatrix = getPermutationMatrix(matrixSize);

    // Swap the rows to make the pivot point non zero
    for (int pivotRowIndex = 0; pivotRowIndex < matrixSize; pivotRowIndex++) {
      int currentRowPivotColumnIndex = pivotRowIndex;

      // if the current row pivot point already contains non-zero element just skip the current row
      if (sparseMatrix[pivotRowIndex]
              ?.containsKey(currentRowPivotColumnIndex) ??
          false) {
        continue;
      }

      // loop through all the rows below the current pivot point row to make their pivot point indexes zero
      for (int downRowIndex = pivotRowIndex + 1;
          downRowIndex < matrixSize;
          downRowIndex++) {
        // if the downRow pivot column already contains zero, skip the current down row
        if (!(sparseMatrix[downRowIndex]
                ?.containsKey(currentRowPivotColumnIndex) ??
            false)) {
          continue;
        }

        var currentPivotRowContent = sparseMatrix[pivotRowIndex];
        Map<int, num> downRowContent = sparseMatrix[downRowIndex]!;

        sparseMatrix[pivotRowIndex] = downRowContent;

        // if the current pivot row content empty or null, then removes the current empty row from the sparse matrix
        if (currentPivotRowContent?.isEmpty ?? true) {
          sparseMatrix.remove(downRowIndex);
        } else {
          sparseMatrix[downRowIndex] = currentPivotRowContent!;
        }

        // Swap the permutation matrix to preserve the swap
        Map<int, num> tempRow = permutationMatrix[pivotRowIndex]!;
        permutationMatrix[pivotRowIndex] = permutationMatrix[downRowIndex]!;
        permutationMatrix[downRowIndex] = tempRow;
        // after the swapping no need to look for other down elements so use break.now the current pivot row pivot column is safely contains non-zero element
        break;
      }
    }
    return permutationMatrix;
  }

  Map<int, Map<int, num>> getPermutationMatrix(int squareMatrixSize) {
    Map<int, Map<int, num>> perm = {};
    for (int i = 0; i < squareMatrixSize; i++) {
      // set the row
      perm[i] = {};
      perm[i]![i] = 1.0;
    }
    return perm;
  }
}
