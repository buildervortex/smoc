import 'package:smo/models/sparse_matrix.dart';

class ScalerMultiplication {
  Map<int, Map<int, num>> call(Map<int, Map<int, num>> matrix, num divider) {
    if (divider == 0) {
      throw ArgumentError('Divider cannot be zero');
    }
    List<List<num>> matrixList = [];
    for (var row in matrix.entries) {
      for (var column in row.value.entries) {
        var scaledValue = column.value / divider;
        if (scaledValue != 0) {
          matrixList.add([row.key, column.key, scaledValue]);
        }
      }
    }
    return SparseMatrix.docfromCOO(matrixList);
  }
}
