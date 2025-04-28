import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smo/bloc/cubit/operation_cubit.dart';
import 'package:smo/di/injection_container.dart';
import 'package:smo/presentation/pages/home_page.dart';

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
        '/': (context) => const HomePage(),
      },
      initialRoute: '/',
    );
  }
}
