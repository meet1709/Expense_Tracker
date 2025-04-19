import 'package:expense_tracker_ui/screens/addExpenseScreen.dart';
import 'package:expense_tracker_ui/screens/budgetScreen.dart';
import 'package:expense_tracker_ui/ui_widgets/MyGradientAppBar.dart';
import 'package:expense_tracker_ui/ui_widgets/navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';
import 'analyticScreen.dart';
import 'expense_list_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void _openAddExpenseScreen() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => const AddExpenseScreen()),
    );
  }

  // Open Analytics Screen
  void _openAnalytics(List<Expense> expenses) {
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (_) => AnalyticScreen(
                  expenses: expenses,
                )));
  }

  void _openExpenseListScreen() {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (_) => ExpenseListScreen()));
  }

  void _openBudgestScreen() {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (_) => BudgetScreen()));
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 4;
    final expenses = Provider.of<ExpenseProvider>(context).getExpenses();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        appBar: const MyGradientAppBar(title: "Setting"),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              if (index == 0) {
                _openExpenseListScreen();
              } else if (index == 1) {
                _openAnalytics(expenses);
              } else if (index == 2) {
                _openAddExpenseScreen();
              } else if (index == 3) {
                _openBudgestScreen();
              }
            });
          },
        ),
      ),
    );
  }
}
