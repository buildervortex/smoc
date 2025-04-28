import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smo/bloc/cubit/matrix_input_cubit.dart';
import 'package:smo/di/injection_container.dart';
import 'package:smo/presentation/widgets/SparseMatrixInputForm.dart';

class InputPage extends StatelessWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (cont) => sl<MatrixInputCubit>(),
          child: Sparsematrixinputform(),
        ),
      ),
    );
  }
}
