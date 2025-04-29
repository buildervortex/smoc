import 'package:get_it/get_it.dart';
import 'package:smo/bloc/cubit/matrix_input_cubit.dart';
import 'package:smo/bloc/cubit/operation_cubit.dart';
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

final sl = GetIt.instance;

Future<void> initDiContainer() async {
  sl.registerFactory<MatrixInputCubit>(() => MatrixInputCubit());
  sl.registerFactory<OperationCubit>(() => OperationCubit());

  sl.registerSingleton<AdditionUsecase>(AdditionUsecase());
  sl.registerSingleton<AdjointUsecase>(AdjointUsecase());
  sl.registerSingleton<CofactorMatrixUsecase>(CofactorMatrixUsecase());
  sl.registerSingleton<DeterminantUsecase>(DeterminantUsecase());
  sl.registerSingleton<GuassianEliminationUsecase>(
      GuassianEliminationUsecase());
  sl.registerSingleton<HadamardProductUsecase>(HadamardProductUsecase());
  sl.registerSingleton<InverseUsecase>(InverseUsecase());
  sl.registerSingleton<LuDecompositionUsecase>(LuDecompositionUsecase());
  sl.registerSingleton<MatrixMatrixMultiplicationUsecase>(
      MatrixMatrixMultiplicationUsecase());
  sl.registerSingleton<ScalerDivisionUsecase>(ScalerDivisionUsecase());
  sl.registerSingleton<ScalerMultiplication>(ScalerMultiplication());
  sl.registerSingleton<SubstractionUsecase>(SubstractionUsecase());
  sl.registerSingleton<TraceUsecase>(TraceUsecase());
  sl.registerSingleton<TransposeUsecase>(TransposeUsecase());
}
