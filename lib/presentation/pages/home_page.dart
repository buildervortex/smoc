import 'package:flutter/material.dart';
import 'package:smo/bloc/cubit/operation_cubit.dart';

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
      imagePath: 'assets/images/addition.png',
      operation: Operation.addition,
    ),
    MatrixOperation(
      name: 'Subtraction',
      imagePath: 'assets/images/subtraction.png',
      operation: Operation.subtraction,
    ),
    MatrixOperation(
      name: 'Scaler Multiplication',
      imagePath: 'assets/images/multiplication.png',
      operation: Operation.scalerMultiplication,
    ),
    MatrixOperation(
      name: 'Scaler Division',
      imagePath: 'assets/images/division.png',
      operation: Operation.scalerDivision,
    ),
    MatrixOperation(
      name: 'Hadamard Product',
      imagePath: 'assets/images/hadamard_product.png',
      operation: Operation.hadamardProduct,
    ),
    MatrixOperation(
      name: 'Transpose',
      imagePath: 'assets/images/transpose.png',
      operation: Operation.transpose,
    ),
    MatrixOperation(
      name: 'Matrix Multiplication',
      imagePath: 'assets/images/matrix_multiplication.png',
      operation: Operation.matrixMatrixMultiplication,
    ),
    MatrixOperation(
      name: 'Determinant',
      imagePath: 'assets/images/determinant.png',
      operation: Operation.determinant,
    ),
    MatrixOperation(
      name: 'Trace',
      imagePath: 'assets/images/trace.png',
      operation: Operation.trace,
    ),
    MatrixOperation(
      name: 'Inverse',
      imagePath: 'assets/images/inverse.png',
      operation: Operation.inverse,
    ),
    MatrixOperation(
      name: 'Gaussian Elimination',
      imagePath: 'assets/images/gaussian_elimination.png',
      operation: Operation.guassianElimination,
    ),
    MatrixOperation(
      name: 'LU Decomposition',
      imagePath: 'assets/images/ludecomposition.png',
      operation: Operation.lUDecomposition,
    ),
  ];
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
