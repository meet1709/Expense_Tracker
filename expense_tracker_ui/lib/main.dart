import 'package:device_preview/device_preview.dart';
import 'package:expense_tracker_ui/providers/budget_provider.dart';
import 'package:expense_tracker_ui/providers/expense_provider.dart';
import 'package:expense_tracker_ui/screens/expense_list_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
   DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => BudgetProvider()),
      ],
      child: const _MaterialApp(),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.white,
      ),
      home: const ExpenseListScreen(),
    );
  }
}
