import 'package:flutter_test/flutter_test.dart';
import 'package:smo/models/sparse_matrix.dart';
import 'package:smo/models/matrix_entry.dart';

void main() {
  group('SparseMatrix', () {
    test('toDoc converts SparseMatrix to a nested map representation', () {
      final matrix = SparseMatrix(
        rows: 3,
        columns: 3,
        entries: [
          MatrixEntry(row: 0, column: 1, value: 2.0),
          MatrixEntry(row: 0, column: 2, value: 2.0),
          MatrixEntry(row: 1, column: 2, value: 3.5),
        ],
      );

      final doc = matrix.toDoc();

      expect(doc, {
        0: {1: 2.0, 2: 2.0},
        1: {2: 3.5},
      });
    });

    test('toCOO converts SparseMatrix to a COO format list', () {
      final matrix = SparseMatrix(
        rows: 3,
        columns: 3,
        entries: [
          MatrixEntry(row: 0, column: 1, value: 2.0),
          MatrixEntry(row: 1, column: 2, value: 3.5),
        ],
      );

      final coo = matrix.toCOO();

      expect(coo, [
        [0.0, 1.0, 2.0],
        [1.0, 2.0, 3.5],
      ]);
    });

    test('fromDoc creates SparseMatrix from a nested map representation', () {
      final doc = {
        0: {1: 2.0, 2: 4.0},
        1: {2: 3.5},
      };

      final matrix = SparseMatrix.fromDoc(doc, 3, 3);

      expect(matrix.rows, 3);
      expect(matrix.columns, 3);
      expect(matrix.entries, [
        MatrixEntry(row: 0, column: 1, value: 2.0),
        MatrixEntry(row: 0, column: 2, value: 4.0),
        MatrixEntry(row: 1, column: 2, value: 3.5),
      ]);
    });

    test('fromCOO creates SparseMatrix from a COO format list', () {
      final coo = [
        [0.0, 1.0, 2.0],
        [1.0, 2.0, 3.5],
      ];

      final matrix = SparseMatrix.fromCOO(coo, 3, 3);

      expect(matrix.rows, 3);
      expect(matrix.columns, 3);
      expect(matrix.entries, [
        MatrixEntry(row: 0, column: 1, value: 2.0),
        MatrixEntry(row: 1, column: 2, value: 3.5),
      ]);
    });

    test('docfromCOO converts COO format list to a nested map representation',
        () {
      final coo = [
        [0.0, 1.0, 2.0],
        [1.0, 2.0, 3.5],
      ];

      final matrix = SparseMatrix(rows: 3, columns: 3, entries: []);
      final doc = matrix.docfromCOO(coo);

      expect(doc, {
        0: {1: 2.0},
        1: {2: 3.5},
      });
    });

    test('coofromDoc converts a nested map representation to COO format list',
        () {
      final doc = {
        0: {1: 2.0},
        1: {2: 3.5},
      };

      final matrix = SparseMatrix(rows: 3, columns: 3, entries: []);
      final coo = matrix.coofromDoc(doc);

      expect(coo, [
        [0.0, 1.0, 2.0],
        [1.0, 2.0, 3.5],
      ]);
    });
  });
}
