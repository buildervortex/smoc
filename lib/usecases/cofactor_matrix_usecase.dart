import 'package:smo/usecases/determinant_usecase.dart';

class CofactorMatrixUsecase {
  Map<int, Map<int, num>> call(
      Map<int, Map<int, num>> matrix, int squareMatrixSize) {
    // create empty matrix to store the cofactor matrix
    var cofactorMatrix = <int, Map<int, num>>{};

    for (int rowIndex = 0; rowIndex < squareMatrixSize; rowIndex++) {
      // add new empty row to the cofactor matrix
      cofactorMatrix[rowIndex] = {};

      for (int columnIndex = 0; columnIndex < squareMatrixSize; columnIndex++) {
        // get the minor by excluding the current row and column
        var minor = getMinor(matrix, rowIndex, columnIndex, squareMatrixSize);

        // calculate the determinant of the generated minor
        var determinant = DeterminantUsecase()(minor, squareMatrixSize - 1);

        // calculate the sign for current row+column
        var sign = ((rowIndex + columnIndex) % 2 == 0) ? 1 : -1;

        // generate the cofactor column's value
        var value = sign * determinant;

        // add the cofactor column's value only if the value is not zero
        if (value != 0) {
          cofactorMatrix[rowIndex]![columnIndex] = value;
        } else {
          // remove if the row is empty and doesn't contain any column
          cofactorMatrix[rowIndex]!.remove(columnIndex);
        }
      }
    }
    return cofactorMatrix;
  }

  Map<int, Map<int, num>> getMinor(Map<int, Map<int, num>> matrix,
      int excludedRowIndex, int excludedColumnIndex, int squareMatrixSize) {
    // create empty sparse matrix for the minor
    var minor = <int, Map<int, num>>{};

    // keep track of the minor sparse matrix row index
    int minorRowIndexCounter = 0;

    for (int rowIndex = 0; rowIndex < squareMatrixSize; rowIndex++) {
      if (rowIndex == excludedRowIndex) continue;

      // if the matrix doesn't contains the entier row, which means the entier row contains zeroes, skip row. no need to add zeroes to minor matrix
      if (!matrix.containsKey(rowIndex)) continue;

      // add new row to the minor matrix
      minor[minorRowIndexCounter] = {};

      int minorColumnIndexCounter = 0;

      for (int columnIndex = 0; columnIndex < squareMatrixSize; columnIndex++) {
        if (columnIndex == excludedColumnIndex) continue;

        // if the matrix contains non-zero element added it to the minor matrix current row
        if (matrix[rowIndex]!.containsKey(columnIndex)) {
          minor[minorRowIndexCounter]![minorColumnIndexCounter] =
              matrix[rowIndex]![columnIndex]!;
        }

        // increment minor column counter by one
        minorColumnIndexCounter++;
      }

      // if accidently added empty row, remove it
      if (minor[minorRowIndexCounter]!.isEmpty) {
        minor.remove(minorRowIndexCounter);
      }

      // increment minor row counter by one
      minorRowIndexCounter++;
    }

    return minor;
  }
}
