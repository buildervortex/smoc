import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smo/bloc/cubit/matrix_input_cubit.dart';
import 'package:smo/bloc/cubit/operation_cubit.dart';
import 'package:smo/di/injection_container.dart';
import 'package:smo/models/sparse_matrix.dart';
import 'package:smo/presentation/pages/double_matrix_output_page.dart';
import 'package:smo/presentation/pages/lup_matrix_output_page.dart';
import 'package:smo/presentation/pages/matrix_input_page.dart';
import 'package:smo/presentation/pages/single_input_page.dart';
import 'package:smo/presentation/pages/single_matrix_output_page.dart';
import 'package:smo/presentation/pages/single_value_output_page.dart';
import 'package:smo/usecases/addition_usecase.dart';
import 'package:smo/usecases/adjoint_usecase.dart';
import 'package:smo/usecases/cofactor_matrix_usecase.dart';
import 'package:smo/usecases/determinant_usecase.dart';
import 'package:smo/usecases/guassian_elimination_usecase.dart';
import 'package:smo/usecases/hadamard_product_usecase.dart';
import 'package:smo/usecases/inverse_usecase.dart';
import 'package:smo/usecases/lu_decomposition_usecase.dart';
import 'package:smo/usecases/matrix_matrix_multiplication_usecase.dart';
import 'package:smo/usecases/scaler_division_usecase.dart';
import 'package:smo/usecases/scaler_multiplication_usecase.dart';
import 'package:smo/usecases/substraction_usecase.dart';
import 'package:smo/usecases/trace_usecase.dart';
import 'package:smo/usecases/transpose_usecase.dart';

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
      var value = await Navigator.push<num>(
          context, MaterialPageRoute(builder: (_) => SingleInputPage()));
      if (value != null) {
        context.read<OperationCubit>().addInputValue(value);
      }
    }
    _performOperation(context);
  }

  Future<void> _performOperation(BuildContext context) async {
    final operation = context.read<OperationCubit>().state.operation;
    final sparseMatrixes = context.read<OperationCubit>().state.sparseMatrixes;
    final inputValues = context.read<OperationCubit>().state.inputValues;

    switch (operation) {
      case Operation.none:
        break;
      case Operation.addition:
        var additionUsecase = sl<AdditionUsecase>();
        late Map<int, Map<int, num>> result;
        try {
          result = additionUsecase(
              sparseMatrixes[0].toDoc(),
              sparseMatrixes[1].toDoc(),
              sparseMatrixes[0].rows,
              sparseMatrixes[0].columns);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
              backgroundColor: Colors.red,
            ),
          );
          break;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SingleMatrixOutputPage(
                    matrix: SparseMatrix.fromDoc(result, sparseMatrixes[0].rows,
                        sparseMatrixes[0].columns),
                    operation: operation.name)));
        context.read<OperationCubit>().clearData();
        break;
      case Operation.subtraction:
        var substractionUsecase = sl<SubstractionUsecase>();
        Map<int, Map<int, num>> result;
        try {
          result = substractionUsecase(
              sparseMatrixes[0].toDoc(),
              sparseMatrixes[1].toDoc(),
              sparseMatrixes[0].rows,
              sparseMatrixes[0].columns);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
              backgroundColor: Colors.red,
            ),
          );
          break;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SingleMatrixOutputPage(
                    matrix: SparseMatrix.fromDoc(result, sparseMatrixes[0].rows,
                        sparseMatrixes[0].columns),
                    operation: operation.name)));
        context.read<OperationCubit>().clearData();
        break;
      case Operation.scalerMultiplication:
        var scalerMultiplication = sl<ScalerMultiplication>();
        var result =
            scalerMultiplication(sparseMatrixes[0].toDoc(), inputValues[0]);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SingleMatrixOutputPage(
                    matrix: SparseMatrix.fromDoc(result, sparseMatrixes[0].rows,
                        sparseMatrixes[0].columns),
                    operation: operation.name)));
        context.read<OperationCubit>().clearData();
        break;
      case Operation.scalerDivision:
        var scalerDivision = sl<ScalerDivisionUsecase>();
        var result = scalerDivision(sparseMatrixes[0].toDoc(), inputValues[0]);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SingleMatrixOutputPage(
                    matrix: SparseMatrix.fromDoc(result, sparseMatrixes[0].rows,
                        sparseMatrixes[0].columns),
                    operation: operation.name)));
        context.read<OperationCubit>().clearData();
        break;
      case Operation.hadamardProduct:
        var hadamardProduct = sl<HadamardProductUsecase>();
        late Map<int, Map<int, num>> result;
        try {
          result = hadamardProduct(
              sparseMatrixes[0].toDoc(),
              sparseMatrixes[1].toDoc(),
              sparseMatrixes[0].rows,
              sparseMatrixes[0].columns);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
              backgroundColor: Colors.red,
            ),
          );
          break;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SingleMatrixOutputPage(
                    matrix: SparseMatrix.fromDoc(result, sparseMatrixes[0].rows,
                        sparseMatrixes[0].columns),
                    operation: operation.name)));
        context.read<OperationCubit>().clearData();
        break;
      case Operation.transpose:
        var transpose = sl<TransposeUsecase>();
        late Map<int, Map<int, num>> result;
        try {
          result = transpose(sparseMatrixes[0].toDoc());
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
              backgroundColor: Colors.red,
            ),
          );
          break;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SingleMatrixOutputPage(
                    matrix: SparseMatrix.fromDoc(result, sparseMatrixes[0].rows,
                        sparseMatrixes[0].columns),
                    operation: operation.name)));
        context.read<OperationCubit>().clearData();
        break;
      case Operation.matrixMatrixMultiplication:
        var matrixMatrixMultiplication =
            sl<MatrixMatrixMultiplicationUsecase>();
        late Map<int, Map<int, num>> result;
        try {
          result = matrixMatrixMultiplication(
              sparseMatrixes[0].toDoc(),
              sparseMatrixes[0].rows,
              sparseMatrixes[0].columns,
              sparseMatrixes[1].toDoc(),
              sparseMatrixes[1].rows,
              sparseMatrixes[1].columns);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
              backgroundColor: Colors.red,
            ),
          );
          break;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SingleMatrixOutputPage(
                    matrix: SparseMatrix.fromDoc(result, sparseMatrixes[0].rows,
                        sparseMatrixes[0].columns),
                    operation: operation.name)));
        context.read<OperationCubit>().clearData();
        break;
      case Operation.determinant:
        var determinant = sl<DeterminantUsecase>();
        num result;
        try {
          result =
              determinant(sparseMatrixes[0].toDoc(), sparseMatrixes[0].rows);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
              backgroundColor: Colors.red,
            ),
          );
          break;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SingleValueOutputPage(
                    operation: operation.name, value: result.toString())));
        context.read<OperationCubit>().clearData();
        break;
      case Operation.trace:
        var trace = sl<TraceUsecase>();
        num result;
        try {
          result = trace(sparseMatrixes[0].toDoc(), sparseMatrixes[0].rows);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
              backgroundColor: Colors.red,
            ),
          );
          break;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SingleValueOutputPage(
                    operation: operation.name, value: result.toString())));
        context.read<OperationCubit>().clearData();
        break;
      case Operation.inverse:
        var inverse = sl<InverseUsecase>();
        late Map<int, Map<int, num>> result;
        try {
          result = inverse(sparseMatrixes[0].toDoc(), sparseMatrixes[0].rows);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
              backgroundColor: Colors.red,
            ),
          );
          break;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SingleMatrixOutputPage(
                    matrix: SparseMatrix.fromDoc(result, sparseMatrixes[0].rows,
                        sparseMatrixes[0].columns),
                    operation: operation.name)));
        context.read<OperationCubit>().clearData();
        break;
      case Operation.guassianElimination:
        var elimination = sl<GuassianEliminationUsecase>();
        var doc = sparseMatrixes[0].toDoc();
        late Map<int, Map<int, num>> result;
        try {
          result = elimination(doc, sparseMatrixes[0].rows);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
              backgroundColor: Colors.red,
            ),
          );
          break;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DoubleMatrixOutputPage(
                    matrix1: SparseMatrix.fromDoc(
                        doc, sparseMatrixes[0].rows, sparseMatrixes[0].columns),
                    matrix2: SparseMatrix.fromDoc(result,
                        sparseMatrixes[0].rows, sparseMatrixes[0].columns),
                    operation: operation.name,
                    title1: "U Matrix",
                    title2: "Permutation Matrix")));
        context.read<OperationCubit>().clearData();
        break;
      case Operation.lUDecomposition:
        var lu = sl<LuDecompositionUsecase>();
        var doc = sparseMatrixes[0].toDoc();
        var rows = sparseMatrixes[0].rows;
        var columns = sparseMatrixes[0].columns;

        late LuDecompositionResult? result;
        try {
          result = lu(doc, sparseMatrixes[0].rows);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
              backgroundColor: Colors.red,
            ),
          );
          break;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => LupMatrixOutputPage(
                    uMatrix: SparseMatrix.fromDoc(result!.U, rows, columns),
                    lMatrix: SparseMatrix.fromDoc(result!.L, rows, columns),
                    pMatrix: SparseMatrix.fromDoc(result!.P, rows, columns))));
        context.read<OperationCubit>().clearData();
        break;
      case Operation.adjoint:
        var adjoin = sl<AdjointUsecase>();
        Map<int, Map<int, num>> result;
        try {
          result = adjoin(sparseMatrixes[0].toDoc(), sparseMatrixes[0].rows);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
              backgroundColor: Colors.red,
            ),
          );
          break;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SingleMatrixOutputPage(
                    matrix: SparseMatrix.fromDoc(result, sparseMatrixes[0].rows,
                        sparseMatrixes[0].columns),
                    operation: operation.name)));
        context.read<OperationCubit>().clearData();
        break;
      case Operation.cofactor:
        var cofactor = sl<CofactorMatrixUsecase>();
        late Map<int, Map<int, num>> result;
        try {
          result = cofactor(sparseMatrixes[0].toDoc(), sparseMatrixes[0].rows);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
              backgroundColor: Colors.red,
            ),
          );
          break;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SingleMatrixOutputPage(
                    matrix: SparseMatrix.fromDoc(result, sparseMatrixes[0].rows,
                        sparseMatrixes[0].columns),
                    operation: operation.name)));
        context.read<OperationCubit>().clearData();
        break;
    }
  }
}
