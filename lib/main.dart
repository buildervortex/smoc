import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smo/bloc/cubit/operation_cubit.dart';
import 'package:smo/di/injection_container.dart';
import 'package:smo/models/matrix_entry.dart';
import 'package:smo/models/sparse_matrix.dart';
import 'package:smo/presentation/pages/home_page.dart';
import 'package:smo/presentation/pages/single_matrix_output_page.dart';

void main() async {
  await initDiContainer();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
    create: (context) => sl<OperationCubit>(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sparse Matrix Operations',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) =>  SingleMatrixOutputPage(matrix: SparseMatrix(rows: 2, columns: 2, entries: [
          MatrixEntry(row: 0, column: 0, value: 1),
          MatrixEntry(row: 0, column: 1, value: 2),
          MatrixEntry(row: 1, column: 0, value: 3),
          MatrixEntry(row: 1, column: 1, value: 4),
        ]),operation: "Addition"),
      },
      initialRoute: '/',
    );
  }
}
