import 'package:flutter/material.dart';
import 'package:smo/models/sparse_matrix.dart';

class DoubleMatrixOutputPage extends StatelessWidget {
  final SparseMatrix matrix1;
  final SparseMatrix matrix2;
  final String title1;
  final String title2;
  final String operation;

  const DoubleMatrixOutputPage(
      {required this.matrix1,
      required this.matrix2,
      required this.operation,
      required this.title1,
      required this.title2,
      super.key});

  @override
  Widget build(BuildContext context) {
    final lightBlue = Colors.lightBlue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operation Result'),
        backgroundColor: lightBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            tooltip: 'Return to home',
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
              // Result header card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: lightBlue.shade100, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, color: lightBlue.shade700),
                          const SizedBox(width: 8),
                          Text(
                            "Operation Completed",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: lightBlue.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: lightBlue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          operation,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: lightBlue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Matrices tabs
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: lightBlue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: lightBlue,
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: lightBlue.shade700,
                          tabs: [
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.grid_on),
                                  const SizedBox(width: 8),
                                  Text(title1),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.grid_on),
                                  const SizedBox(width: 8),
                                  Text(title2),
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
                            // First matrix
                            _buildMatrixCard(context, matrix1, title1),

                            // Second matrix
                            _buildMatrixCard(context, matrix2, title2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Return button
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text(
                    'RETURN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightBlue.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatrixCard(
      BuildContext context, SparseMatrix matrix, String title) {
    final lightBlue = Colors.lightBlue;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: lightBlue.shade100, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: lightBlue.shade700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Sparse format - non-zero elements only",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: lightBlue.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: lightBlue.shade200),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.grid_on, size: 16, color: lightBlue.shade700),
                      const SizedBox(width: 4),
                      Text(
                        '${matrix.rows}×${matrix.columns}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: lightBlue.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: matrix.entries.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.table_chart_outlined,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No entries in this matrix',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: matrix.entries.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      itemBuilder: (context, index) {
                        final entry = matrix.entries[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: lightBlue.shade50,
                            foregroundColor: lightBlue.shade700,
                            child: Text('${index + 1}'),
                          ),
                          title: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: lightBlue.shade50,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: lightBlue.shade100),
                                ),
                                child: Text(
                                  '[${entry.row}, ${entry.column}]',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: lightBlue.shade700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '${entry.value}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
