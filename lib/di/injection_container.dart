import 'package:get_it/get_it.dart';
import 'package:smo/bloc/cubit/matrix_input_cubit.dart';
import 'package:smo/bloc/cubit/operation_cubit.dart';

final sl = GetIt.instance;

Future<void> initDiContainer() async {
  // Register your services, repositories, and other dependencies here
  // Example:
  // sl.registerLazySingleton<SomeService>(() => SomeServiceImpl());

  sl.registerFactory<MatrixInputCubit>(() => MatrixInputCubit());
  sl.registerFactory<OperationCubit>(() => OperationCubit());
}
