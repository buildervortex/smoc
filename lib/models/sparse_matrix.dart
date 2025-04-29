import 'package:equatable/equatable.dart';
import 'package:smo/models/matrix_entry.dart';

class SparseMatrix extends Equatable {
  final int rows;
  final int columns;
  final List<MatrixEntry> entries;

  const SparseMatrix({
    required this.rows,
    required this.columns,
    required this.entries,
  });

  @override
  List<Object> get props => [rows, columns, entries];

  Map<int, Map<int, double>> toDoc() {
    final map = <int, Map<int, double>>{};

    for (var entry in entries) {
      if (!map.containsKey(entry.row)) {
        map[entry.row] = {};
      }
      map[entry.row]![entry.column] = entry.value;
    }

    return map;
  }

  List<List<double>> toCOO() {
    final List<List<double>> list = [];

    for (var entry in entries) {
      List<double> item = [];
      item.add(entry.row.toDouble());
      item.add(entry.column.toDouble());
      item.add(entry.value);
      list.add(item);
    }
    return list;
  }

  factory SparseMatrix.fromDoc(
      Map<int, Map<int, double>> doc, int rows, int columns) {
    final matrixEntries = <MatrixEntry>[];

    for (var rowEntry in doc.entries) {
      for (var columnEntry in rowEntry.value.entries) {
        matrixEntries.add(MatrixEntry(
            row: rowEntry.key,
            column: columnEntry.key,
            value: columnEntry.value));
      }
    }

    return SparseMatrix(
      rows: rows,
      columns: columns,
      entries: matrixEntries,
    );
  }

  factory SparseMatrix.fromCOO(List<List<double>> coo, int rows, int columns) {
    final entries = <MatrixEntry>[];

    for (var entry in coo) {
      entries.add(MatrixEntry(
          row: entry[0].toInt(), column: entry[1].toInt(), value: entry[2]));
    }

    return SparseMatrix(
      rows: rows,
      columns: columns,
      entries: entries,
    );
  }

  static Map<int, Map<int, num>> docfromCOO(List<List<num>> coo) {
    final dok = <int, Map<int, num>>{};

    for (var entry in coo) {
      final row = entry[0].toInt();
      final column = entry[1].toInt();
      final value = entry[2];

      if (!dok.containsKey(row)) {
        dok[row] = {};
      }
      dok[row]![column] = value;
    }

    return dok;
  }

  static List<List<num>> coofromDoc(Map<int, Map<int, num>> doc) {
    final coo = <List<num>>[];

    for (var rowEntry in doc.entries) {
      for (var columnEntry in rowEntry.value.entries) {
        coo.add([
          rowEntry.key.toDouble(),
          columnEntry.key.toDouble(),
          columnEntry.value
        ]);
      }
    }

    return coo;
  }

  @override
  String toString() {
    return 'SparseMatrix(rows: $rows, columns: $columns, entries: $entries)';
  }
}
