import 'package:flutter/material.dart';
import 'package:smo/models/sparse_matrix.dart';

class LupMatrixOutputPage extends StatelessWidget {
  final SparseMatrix uMatrix;
  final SparseMatrix lMatrix;
  final SparseMatrix pMatrix;

  const LupMatrixOutputPage(
      {required this.uMatrix,
      required this.lMatrix,
      required this.pMatrix,
      super.key});

  @override
  Widget build(BuildContext context) {
    final lightBlue = Colors.lightBlue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('LU Decomposition Result'),
        backgroundColor: lightBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              _showInfoDialog(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'LU Decomposition with Partial Pivoting',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: lightBlue.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Matrix formula representation
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: lightBlue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'A = P⁻¹ × L × U',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Matrix tabs
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: lightBlue.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: lightBlue,
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: lightBlue.shade700,
                          tabs: const [
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'L ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('Matrix'),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'U ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('Matrix'),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'P ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('Matrix'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildMatrixCard(
                                context,
                                lMatrix,
                                'Lower Triangular Matrix',
                                'Contains multipliers used during elimination'),
                            _buildMatrixCard(
                                context,
                                uMatrix,
                                'Upper Triangular Matrix',
                                'Result of Gaussian elimination'),
                            _buildMatrixCard(
                                context,
                                pMatrix,
                                'Permutation Matrix',
                                'Represents row exchanges during pivoting'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom buttons
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('BACK'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: lightBlue.shade700,
                          side: BorderSide(color: lightBlue.shade700),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Return to home or main screen
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        icon: const Icon(Icons.home),
                        label: const Text('HOME'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lightBlue.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatrixCard(BuildContext context, SparseMatrix matrix,
      String title, String description) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.lightBlue.shade100, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue.shade700,
                  ),
                ),
                const Spacer(),
                Text(
                  '${matrix.rows}×${matrix.columns}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildMatrixDisplay(context, matrix),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatrixDisplay(BuildContext context, SparseMatrix matrix) {
    // Build a grid to display the matrix
    if (matrix.entries.isEmpty) {
      return Center(
        child: Text(
          'Matrix has no non-zero entries',
          style: TextStyle(color: Colors.grey.shade600),
        ),
      );
    }

    // First convert sparse to dense format
    List<List<num>> denseMatrix = List.generate(
      matrix.rows,
      (_) => List.filled(matrix.columns, 0.0),
    );

    // Fill in non-zero values
    for (var entry in matrix.entries) {
      denseMatrix[entry.row][entry.column] = entry.value;
    }

    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Create matrix with brackets
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.lightBlue.shade700, width: 2),
                  right: BorderSide(color: Colors.lightBlue.shade700, width: 2),
                ),
              ),
              child: Table(
                defaultColumnWidth: const IntrinsicColumnWidth(),
                children: List.generate(
                  matrix.rows,
                  (i) => TableRow(
                    children: List.generate(
                      matrix.columns,
                      (j) => Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: denseMatrix[i][j] != 0.0
                              ? Colors.lightBlue.shade50
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          denseMatrix[i][j].toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: denseMatrix[i][j] != 0.0
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: denseMatrix[i][j] != 0.0
                                ? Colors.lightBlue.shade700
                                : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'About LU Decomposition',
            style: TextStyle(color: Colors.lightBlue.shade700),
          ),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'LU decomposition with partial pivoting factors a matrix A into three matrices:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text('• L: Lower triangular matrix with 1s on the diagonal'),
                Text('• U: Upper triangular matrix'),
                Text('• P: Permutation matrix for pivoting'),
                SizedBox(height: 16),
                Text(
                  'The factorization satisfies: PA = LU',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'This decomposition is useful for solving linear systems of equations, calculating determinants, and finding matrix inverses.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'CLOSE',
                style: TextStyle(color: Colors.lightBlue.shade700),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }
}
