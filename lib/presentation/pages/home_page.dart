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
    MatrixOperation(
      name: 'Adjoint',
      imagePath: 'assets/Puzzle.svg',
      operation: Operation.adjoint,
    ),
    MatrixOperation(
      name: 'Cofactor',
      imagePath: 'assets/Connector.svg',
      operation: Operation.cofactor,
    ),
  ];

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final lightBlue = Colors.lightBlue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matrix Operations'),
        backgroundColor: lightBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(
                    'Select Matrix Operation',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: lightBlue.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose one of the operations below to proceed',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // Operations List
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: lightBlue.shade100, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: BlocBuilder<OperationCubit, OperationState>(
                    builder: (context, state) {
                      final selectedOperation = state.operation;
                      return ListView.separated(
                        padding: const EdgeInsets.all(8),
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          indent: 70,
                          endIndent: 24,
                          color: Colors.grey.shade200,
                        ),
                        itemCount: operations.length,
                        itemBuilder: (context, index) {
                          final operation = operations[index];
                          final isSelected =
                              selectedOperation == operation.operation;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            margin: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: isSelected ? 8 : 0,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? lightBlue.shade50
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  context.read<OperationCubit>().setOperation(
                                        operation.operation,
                                      );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: ListTile(
                                    leading: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? lightBlue.shade100
                                            : Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      child: SvgPicture.asset(
                                        operation.imagePath,
                                        fit: BoxFit.contain,
                                        colorFilter: ColorFilter.mode(
                                          isSelected
                                              ? lightBlue.shade700
                                              : Colors.grey.shade700,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      operation.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: isSelected
                                            ? lightBlue.shade700
                                            : Colors.black87,
                                      ),
                                    ),
                                    trailing: isSelected
                                        ? Icon(
                                            Icons.check_circle,
                                            color: lightBlue,
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),

            // Proceed Button
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (context.read<OperationCubit>().state.operation ==
                      Operation.none) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please select an operation first'),
                        backgroundColor: lightBlue.shade700,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                    return;
                  }
                  _getInputs(context);
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
            const SizedBox(height: 16),
          ],
        ),
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
