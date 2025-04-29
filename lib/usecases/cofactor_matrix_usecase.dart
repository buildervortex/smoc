import 'package:smo/usecases/determinant_usecase.dart';

class CofactorMatrixUsecase {
  Map<int, Map<int, num>> call(Map<int, Map<int, num>> matrix, int matrixSize) {
    var cofactorMatrix = <int, Map<int, num>>{};
    for (int rowIndex = 0; rowIndex < matrixSize; rowIndex++) {
      cofactorMatrix[rowIndex] = {};
      for (int columnIndex = 0; columnIndex < matrixSize; columnIndex++) {
        var minor = getMinor(matrix, rowIndex, columnIndex, matrixSize);
        print(' rowIndex: $rowIndex, columnIndex: $columnIndex, minor: $minor');
        var determinant = DeterminantUsecase()(minor, matrixSize - 1);
        print('determinant: $determinant');
        // if (determinant == null) {
        //   throw Exception('Determinant is null');
        // }
        // var sign = ((rowIndex + columnIndex) % 2 == 0) ? 1 : -1;
        // cofactorMatrix[rowIndex]![columnIndex] = sign * determinant;
      }
    }
    return cofactorMatrix;
  }

  Map<int, Map<int, num>> getMinor(Map<int, Map<int, num>> matrix,
      int excludedRowIndex, int excludedColumnIndex, int matrixSize) {
    var minor = <int, Map<int, num>>{};

    int minorRowIndex = 0;

    for (int rowIndex = 0; rowIndex < matrixSize; rowIndex++) {
      if (rowIndex == excludedRowIndex) continue;
      if (!matrix.containsKey(rowIndex)) continue;
      minor[minorRowIndex] = {};
      int minorColumnIndex = 0;
      for (int columnIndex = 0; columnIndex < matrixSize; columnIndex++) {
        if (columnIndex == excludedColumnIndex) continue;
        if (matrix[rowIndex]!.containsKey(columnIndex)) {
          minor[minorRowIndex]![minorColumnIndex] =
              matrix[rowIndex]![columnIndex]!;
        }
        minorColumnIndex++;
      }
      if (minor[minorRowIndex]!.isEmpty) {
        minor.remove(minorRowIndex);
      }
      minorRowIndex++;
    }

    return minor;
  }
}
