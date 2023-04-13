import 'package:flutter/material.dart';
import 'package:quiz/home.dart';
import 'package:provider/provider.dart';
import 'package:quiz/testtt/1.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => IndexNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final indexProvider = Provider.of<IndexNotifier>(context);
    return Home();
  }
}
