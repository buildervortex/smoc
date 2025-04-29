class MatrixMatrixMultiplicationUsecase {
  Map<int, Map<int, num>> call(
      Map<int, Map<int, num>> matrix1,
      int matrix1Row,
      int matrix1Column,
      Map<int, Map<int, num>> matrix2,
      int matrix2Row,
      int matrix2Column) {
    if (matrix1Column != matrix2Row) {
      throw Exception('Matrix multiplication not possible');
    }

    Map<int, Map<int, num>> result = {};

    for (int rowIndex = 0; rowIndex < matrix1Row; rowIndex++) {
      result[rowIndex] ??= {};
      for (int columnIndex = 0; columnIndex < matrix2Column; columnIndex++) {
        var rows = getMatrixRowsColumns(matrix1, rowIndex);
        var columns = getMatrixColumnsRow(matrix2, columnIndex);
        var multiplicationAddition = getMultiplicationAddition(rows, columns);
        if (multiplicationAddition != 0) {
          result[rowIndex]![columnIndex] = multiplicationAddition;
        }
      }
      if (result[rowIndex]!.isEmpty) {
        result.remove(rowIndex);
      }
    }

    return result;
  }

  Map<int, num> getMatrixRowsColumns(
      Map<int, Map<int, num>> matrix, int rowIndex) {
    return matrix[rowIndex] ?? {};
  }

  Map<int, num> getMatrixColumnsRow(
      Map<int, Map<int, num>> matrix, int columnIndex) {
    Map<int, num> columns = {};

    for (var row in matrix.entries) {
      if (row.value.containsKey(columnIndex)) {
        columns[row.key] = row.value[columnIndex] ?? 0;
      }
    }
    return columns;
  }

  num getMultiplicationAddition(Map<int, num> rows, Map<int, num> columns) {
    num result = 0;
    for (var row in rows.entries) {
      for (var column in columns.entries) {
        if (row.key == column.key) {
          result += row.value * column.value;
        }
      }
    }

    return result;
  }
}
