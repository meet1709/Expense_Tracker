// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expense_tracker_ui/constants/constants.dart';
import 'package:expense_tracker_ui/models/expense.dart';
import 'package:expense_tracker_ui/screens/addExpenseScreen.dart';
import 'package:expense_tracker_ui/screens/settingsScreen.dart';
import 'package:expense_tracker_ui/ui_widgets/TotalExpenseWidget.dart';
import 'package:flutter/material.dart';

import '../ui_widgets/Bar_chart.dart';
import '../ui_widgets/Pie_chart.dart';
import '../ui_widgets/navigation_bar.dart';
import 'budgetScreen.dart';
import 'expense_list_screen.dart';

class AnalyticScreen extends StatefulWidget {
  final List<Expense> expenses;
  AnalyticScreen({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  @override
  State<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends State<AnalyticScreen> {
  final List<Map<String, dynamic>> monthWiseExpenses = [
    {'month': 'January', 'amount': 1500.0},
    {'month': 'February', 'amount': 1200.0},
    {'month': 'March', 'amount': 1000.0},
    {'month': 'April', 'amount': 800.0},
    {'month': 'May', 'amount': 950.0},
    {'month': 'June', 'amount': 1200.0},
  ];

  // Example data for bar chart (category-wise expenses)
  final List<Map<String, dynamic>> categoryWiseExpenses = [
    {'category': 'Food', 'amount': 2000.0},
    {'category': 'Transportation', 'amount': 1200.0},
    {'category': 'Clothes', 'amount': 1500.0},
    {'category': 'Grocery', 'amount': 1000.0},
    {'category': 'Entertainment', 'amount': 500.0},
  ];

  final List<String> _categories = [
    "Food",
    "Transportation",
    "Entertainment",
    "Utilities",
    "Shopping",
    "Clothes",
    "Electronics",
    "Jwellary",
    "Restaurant",
    "Grocery",
    "Others"
  ];

  void _openAddExpenseScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
    );
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

  void _openBudgestScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BudgetScreen()));
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 1;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.black],
                begin: Alignment.topLeft,
              ),
            ),
          ),
          title: const Text(
            "Analytics",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: MediaQuery.of(context).size.width > 600
                      ? EdgeInsets.symmetric(horizontal: 50)
                      : EdgeInsets.symmetric(horizontal: 15),
                  child: TotalExpenseWidget(),
                ),
                const SizedBox(height: 20),
                // Bar Chart Section
                Text(
                  'Month-wise Expense Breakdown:',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 300,
                  child: BarChartWidget(
                    expenses: widget.expenses,
                  ),
                ),
                const SizedBox(height: 20),
                // Pie Chart Section
                Text(
                  'Category-wise Expense Breakdown:',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 300,
                  child: PieChartWithHover(
                    expenses: widget.expenses,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(_categories.length, (index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  // Color Block
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: pieChartColors[
                                        index % pieChartColors.length],
                                  ),
                                  const SizedBox(width: 8),
                                  // Category Name
                                  Text(
                                    _categories[index],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ));
                        })),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              if (index == 0) {
                _openExpenseListScreen();
              } else if (index == 2) {
                _openAddExpenseScreen();
              } else if (index == 3) {
                _openBudgestScreen();
              } else if (index == 4) {
                _openSettingsScreen();
              }
            });
          },
        ),
      ),
    );
  }
}
