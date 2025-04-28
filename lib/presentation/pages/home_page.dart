import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smo/bloc/cubit/matrix_input_cubit.dart';
import 'package:smo/bloc/cubit/operation_cubit.dart';
import 'package:smo/di/injection_container.dart';
import 'package:smo/models/sparse_matrix.dart';
import 'package:smo/presentation/pages/matrix_input_page.dart';
import 'package:smo/presentation/pages/single_input_page.dart';

class MatrixOperation {
  final String name;
  final String imagePath;
  final Operation operation;

  const MatrixOperation({
    required this.name,
    required this.imagePath,
    required this.operation,
  });
}

class HomePage extends StatelessWidget {
  final List<MatrixOperation> operations = const [
    MatrixOperation(
      name: 'Addition',
      imagePath: 'assets/Plus.svg',
      operation: Operation.addition,
    ),
    MatrixOperation(
      name: 'Subtraction',
      imagePath: 'assets/Minus.svg',
      operation: Operation.subtraction,
    ),
    MatrixOperation(
      name: 'Scaler Multiplication',
      imagePath: 'assets/Multiplication.svg',
      operation: Operation.scalerMultiplication,
    ),
    MatrixOperation(
      name: 'Scaler Division',
      imagePath: 'assets/Division.svg',
      operation: Operation.scalerDivision,
    ),
    MatrixOperation(
      name: 'Hadamard Product',
      imagePath: 'assets/Astrics.svg',
      operation: Operation.hadamardProduct,
    ),
    MatrixOperation(
      name: 'Transpose',
      imagePath: 'assets/Rotate.svg',
      operation: Operation.transpose,
    ),
    MatrixOperation(
      name: 'Matrix Multiplication',
      imagePath: 'assets/MatrixMatrixMultiplication.svg',
      operation: Operation.matrixMatrixMultiplication,
    ),
    MatrixOperation(
      name: 'Determinant',
      imagePath: 'assets/determinant.svg',
      operation: Operation.determinant,
    ),
    MatrixOperation(
      name: 'Trace',
      imagePath: 'assets/Trace.svg',
      operation: Operation.trace,
    ),
    MatrixOperation(
      name: 'Inverse',
      imagePath: 'assets/Inverse.svg',
      operation: Operation.inverse,
    ),
    MatrixOperation(
      name: 'Gaussian Elimination',
      imagePath: 'assets/Elemination.svg',
      operation: Operation.guassianElimination,
    ),
    MatrixOperation(
      name: 'LU Decomposition',
      imagePath: 'assets/split.svg',
      operation: Operation.lUDecomposition,
    ),
  ];
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Select The Preferred Matrix Operation To Proceed',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<OperationCubit, OperationState>(
              builder: (cont, state) {
                final selectedOperation = state.operation;
                return ListView(
                  children: operations.map((operation) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        transform: selectedOperation == operation.operation
                            ? (Matrix4.identity()..scale(1.2))
                            : Matrix4.identity(),
                        child: ListTile(
                          horizontalTitleGap: 40,
                          leading: SizedBox(
                            width: 25,
                            height: 25,
                            child: SvgPicture.asset(
                              operation.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                          title: Text(
                            operation.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: selectedOperation == operation.operation
                                  ? Colors.cyan
                                  : Colors.black,
                            ),
                          ),
                          onTap: () {
                            context.read<OperationCubit>().setOperation(
                                  operation.operation,
                                );
                          },
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          TextButton(
              onPressed: () {
                if (context.read<OperationCubit>().state.operation ==
                    Operation.none) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select an operation first'),
                    ),
                  );
                  return;
                }
                _getInputs(context);
              },
              child: Text(
                'Proceed',
                style: TextStyle(color: Colors.cyan),
              )),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> _getInputs(BuildContext context) async {
    int matrixCount =
        context.read<OperationCubit>().state.operation.inputMatrixCount;
    int valueCount =
        context.read<OperationCubit>().state.operation.inputValueCount;

    for (int i = 0; i < matrixCount; i++) {
      var matrix = await Navigator.push<SparseMatrix>(
          context,
          MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (cont) => sl<MatrixInputCubit>(),
                    child: MatrixInputPage(),
                  )));
      if (matrix != null) {
        context.read<OperationCubit>().addSparseMatrix(matrix);
      }
    }
    for (int i = 0; i < valueCount; i++) {
      var value = await Navigator.push<double>(
          context, MaterialPageRoute(builder: (_) => SingleInputPage()));
      if (value != null) {
        context.read<OperationCubit>().addInputValue(value);
      }
    }
  }
}
