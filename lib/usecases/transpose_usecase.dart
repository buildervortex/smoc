import 'package:smo/models/sparse_matrix.dart';

class TransposeUsecase {
  Map<int, Map<int, num>> call(Map<int, Map<int, num>> matrix) {
    List<List<num>> coo = SparseMatrix.coofromDoc(matrix);

    List<List<num>> transposedMatrix = [];

    for (var entry in coo) {
      int row = entry[0].toInt();
      int column = entry[1].toInt();
      num value = entry[2];

      transposedMatrix.add([column, row, value]);
    }
    return SparseMatrix.docfromCOO(transposedMatrix);
  }
}
