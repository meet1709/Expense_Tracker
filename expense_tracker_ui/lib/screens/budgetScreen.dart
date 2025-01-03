import 'package:expense_tracker_ui/screens/addExpenseScreen.dart';
import 'package:expense_tracker_ui/screens/analyticScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../providers/expense_provider.dart';
import '../ui_widgets/navigation_bar.dart';
import 'expense_list_screen.dart';
import 'settingsScreen.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {

      void _openAddExpenseScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
    );
  }

  // Open Analytics Screen
  void _openAnalytics(List<Expense> expenses) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AnalyticScreen(
                  expenses: expenses,
                )));
  }

  // Open Analytics Screen
  void _openExpenseListScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ExpenseListScreen()));
  }

    void _openSettingsScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingScreen()));
  }

 @override
  Widget build(BuildContext context) {
       
          int currentIndex = 3;
          final expenses = Provider.of<ExpenseProvider>(context).getExpenses();
    return Scaffold(
      bottomNavigationBar:CustomBottomNavBar(
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
              } else if (index == 4) {
                _openSettingsScreen();
              }
            });
          },
        ),
    );
  }
}