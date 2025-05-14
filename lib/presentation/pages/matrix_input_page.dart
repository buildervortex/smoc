import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smo/bloc/cubit/matrix_input_cubit.dart';

class MatrixInputPage extends StatefulWidget {
  const MatrixInputPage({super.key});

  @override
  State<MatrixInputPage> createState() => _MatrixInputPageState();
}

class _MatrixInputPageState extends State<MatrixInputPage> {
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    final lightBlue = Colors.lightBlue;
    final theme = Theme.of(context);

    return BlocListener<MatrixInputCubit, MatrixInputState>(
      listener: (cont, state) {
        if (state is MatrixInputEntryFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is MatrixInputEntrySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('operation successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Matrix Input'),
          backgroundColor: lightBlue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Matrix Card
              Card(
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
                      Text(
                        'Matrix Dimensions',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: lightBlue.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child:
                                BlocBuilder<MatrixInputCubit, MatrixInputState>(
                              builder: (context, state) {
                                _controllers[0].text =
                                    state.sparseMatrix.rows.toString();
                                return TextField(
                                  controller: _controllers[0],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Rows',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: lightBlue, width: 2),
                                    ),
                                    prefixIcon: Icon(Icons.table_rows,
                                        color: lightBlue),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text("×",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: lightBlue)),
                          ),
                          Expanded(
                            child:
                                BlocBuilder<MatrixInputCubit, MatrixInputState>(
                              builder: (context, state) {
                                _controllers[1].text =
                                    state.sparseMatrix.columns.toString();
                                return TextField(
                                  controller: _controllers[1],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Columns',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: lightBlue, width: 2),
                                    ),
                                    prefixIcon: Icon(Icons.view_column,
                                        color: lightBlue),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              final rowCount = int.parse(_controllers[0].text);
                              final columnCount =
                                  int.parse(_controllers[1].text);
                              context
                                  .read<MatrixInputCubit>()
                                  .setSparseMatrixSize(
                                    rowCount,
                                    columnCount,
                                  );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('matrix size set successfully'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            icon: const Icon(Icons.check),
                            label: const Text('Set Size'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: lightBlue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Matrix Values List
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: lightBlue.shade100, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: Text(
                            'Matrix Entries',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: lightBlue.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child:
                              BlocBuilder<MatrixInputCubit, MatrixInputState>(
                            builder: (context, state) {
                              if (state.sparseMatrix.entries.isEmpty) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.table_chart,
                                          size: 48,
                                          color: Colors.grey.shade400),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No entries yet',
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return ListView.separated(
                                itemCount: state.sparseMatrix.entries.length,
                                separatorBuilder: (context, index) => Divider(
                                    height: 1, color: Colors.grey.shade200),
                                itemBuilder: (context, index) {
                                  final entry =
                                      state.sparseMatrix.entries[index];
                                  return ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 4.0),
                                    leading: CircleAvatar(
                                      backgroundColor: lightBlue.shade50,
                                      foregroundColor: lightBlue.shade700,
                                      child: Text('${index + 1}'),
                                    ),
                                    title: Text(
                                      "Position [${entry.row + 1}, ${entry.column + 1}]",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      "Value: ${entry.value}",
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete,
                                          color: Colors.red.shade400),
                                      onPressed: () {
                                        context
                                            .read<MatrixInputCubit>()
                                            .removeSparseMatrixEntry(
                                                entry.row, entry.column);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Add Entry Section
              Card(
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
                      Text(
                        'Add New Entry',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: lightBlue.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controllers[2],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Row',
                                hintText: "Index from 1",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: lightBlue, width: 2),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _controllers[3],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Column',
                                hintText: "Index from 1",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: lightBlue, width: 2),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _controllers[4],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: InputDecoration(
                                labelText: 'Value',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: lightBlue, width: 2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_controllers[2].text.isNotEmpty &&
                                _controllers[3].text.isNotEmpty &&
                                _controllers[4].text.isNotEmpty) {
                              final row = int.parse(_controllers[2].text);
                              final column = int.parse(_controllers[3].text);
                              final value = double.parse(_controllers[4].text);
                              context
                                  .read<MatrixInputCubit>()
                                  .addSparseMatrixEntry(
                                    row,
                                    column,
                                    value,
                                  );
                              _controllers[2].clear();
                              _controllers[3].clear();
                              _controllers[4].clear();
                            }
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('ADD ENTRY'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: lightBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Proceed Button
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    var matrix =
                        context.read<MatrixInputCubit>().state.sparseMatrix;
                    Navigator.pop(context, matrix);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightBlue.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'PROCEED',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
