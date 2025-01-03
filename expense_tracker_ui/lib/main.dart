import 'package:expense_tracker_ui/providers/expense_provider.dart';
import 'package:expense_tracker_ui/screens/expense_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpenseProvider(),
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Color(0xFFF5F4F4),
          
        ),
        home: const ExpenseListScreen(),
      ),
    );
  }
}


