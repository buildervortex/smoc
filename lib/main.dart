import 'package:flutter/material.dart';
import 'package:smo/di/injection_container.dart';

void main() async {
  await initDiContainer();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
      home: Text(
        'Hello World',
        style: TextStyle(
          color: Colors.red,
          fontSize: 24,
        ),
      ),
    );
  }
}
