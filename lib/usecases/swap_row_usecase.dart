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

      // loop through all the rows below the current pivot point row to select a row which has non-zero element at its current pivot column index
      for (int downRowIndex = pivotRowIndex + 1;
          downRowIndex < matrixSize;
          downRowIndex++) {
        // if the downRow pivot column contains zero, skip the current down row, and find for next one
        if (!(sparseMatrix.containsKey(downRowIndex))) {
          continue;
        } else if (!(sparseMatrix[downRowIndex]
                ?.containsKey(currentRowPivotColumnIndex) ??
            false)) {
          continue;
        }

        Map<int, num> currentPivotRowContent =
            Map<int, num>.from(sparseMatrix[pivotRowIndex] ?? {});
        Map<int, num> downRowContent =
            Map<int, num>.from(sparseMatrix[downRowIndex]!);

        sparseMatrix[pivotRowIndex] = downRowContent;

        // if the current pivot row content empty or null, then removes the current empty row from the sparse matrix
        if (currentPivotRowContent.isEmpty) {
          sparseMatrix.remove(downRowIndex);
        } else {
          sparseMatrix[downRowIndex] = currentPivotRowContent;
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
    // create the permutation identity matrix for given size square matrix
    for (int i = 0; i < squareMatrixSize; i++) {
      // set the row
      perm[i] = {};
      perm[i]![i] = 1.0;
    }
    return perm;
  }
}
