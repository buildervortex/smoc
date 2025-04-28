import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smo/bloc/cubit/matrix_input_cubit.dart';

class Sparsematrixinputform extends StatefulWidget {
  const Sparsematrixinputform({super.key});

  @override
  State<Sparsematrixinputform> createState() => _SparsematrixinputformState();
}

class _SparsematrixinputformState extends State<Sparsematrixinputform> {
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 10,
            children: [
              Spacer(
                flex: 1,
              ),
              SizedBox(
                width: 100,
                child: BlocBuilder<MatrixInputCubit, MatrixInputState>(
                  builder: (cont, state) {
                    _controllers[0].text = state.sparseMatrix.rows.toString();
                    return TextField(
                      controller: _controllers[0],
                      decoration: InputDecoration(
                        labelText: 'Row Count',
                        border: OutlineInputBorder(),
                        hintText: "Enter row count",
                      ),
                    );
                  },
                ),
              ),
              Text("X"),
              SizedBox(
                width: 100,
                child: BlocBuilder<MatrixInputCubit, MatrixInputState>(
                  builder: (cont, state) {
                    _controllers[1].text =
                        state.sparseMatrix.columns.toString();
                    return TextField(
                      controller: _controllers[1],
                      decoration: InputDecoration(
                        labelText: 'Column Count',
                        border: OutlineInputBorder(),
                        hintText: "Enter column count",
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  final rowCount = int.parse(_controllers[0].text);
                  final columnCount = int.parse(_controllers[1].text);
                  context.read<MatrixInputCubit>().setSparseMatrixSize(
                        rowCount,
                        columnCount,
                      );
                },
                icon: Icon(Icons.save),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
          Expanded(child: BlocBuilder<MatrixInputCubit, MatrixInputState>(
            builder: (cont, state) {
              print("State: ${state.sparseMatrix}");
              return ListView(
                children: state.sparseMatrix.entries.map((entry) {
                  return ListTile(
                    title: Text("Row: ${entry.row}, Column: ${entry.column}"),
                    subtitle: Text("Value: ${entry.value}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        context
                            .read<MatrixInputCubit>()
                            .removeSparseMatrixEntry(entry.row, entry.column);
                      },
                    ),
                  );
                }).toList(),
              );
            },
          )),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controllers[2],
                  decoration: InputDecoration(
                    labelText: 'Row',
                    border: OutlineInputBorder(),
                    hintText: "Enter row number index from 0",
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _controllers[3],
                  decoration: InputDecoration(
                    labelText: 'Column',
                    border: OutlineInputBorder(),
                    hintText: "Enter column number index from 0",
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _controllers[4],
                  decoration: InputDecoration(
                      labelText: 'Value',
                      border: OutlineInputBorder(),
                      hintText: "Enter value"),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                  child: IconButton(
                onPressed: () {
                  final row = int.parse(_controllers[2].text);
                  final column = int.parse(_controllers[3].text);
                  final value = double.parse(_controllers[4].text);
                  context.read<MatrixInputCubit>().addSparseMatrixEntry(
                        row,
                        column,
                        value,
                      );
                  _controllers[2].clear();
                  _controllers[3].clear();
                  _controllers[4].clear();
                },
                icon: Icon(Icons.add),
              ))
            ],
          ),
          TextButton(
            child: Text("Procede"),
            onPressed: () {
              var matrix = context.read<MatrixInputCubit>().state.sparseMatrix;
              Navigator.pop(context, matrix);
            },
          ),
        ],
      ),
    );
  }
}
