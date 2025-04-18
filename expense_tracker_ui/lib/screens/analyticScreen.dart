// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expense_tracker_ui/constants/constants.dart';
import 'package:expense_tracker_ui/models/expense.dart';
import 'package:expense_tracker_ui/screens/addExpenseScreen.dart';
import 'package:expense_tracker_ui/screens/settingsScreen.dart';
import 'package:expense_tracker_ui/ui_widgets/MyGradientAppBar.dart';
import 'package:expense_tracker_ui/ui_widgets/TotalExpenseWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui_widgets/Bar_chart.dart';
import '../ui_widgets/Pie_chart.dart';
import '../ui_widgets/navigation_bar.dart';
import 'budgetScreen.dart';
import 'expense_list_screen.dart';

class AnalyticScreen extends StatefulWidget {
  final List<Expense> expenses;

  const AnalyticScreen({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  @override
  State<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends State<AnalyticScreen> {
  // Data for charts
  final List<Map<String, dynamic>> _monthWiseExpenses = [
    {'month': 'January', 'amount': 1500.0},
    {'month': 'February', 'amount': 1200.0},
    {'month': 'March', 'amount': 1000.0},
    {'month': 'April', 'amount': 800.0},
    {'month': 'May', 'amount': 950.0},
    {'month': 'June', 'amount': 1200.0},
  ];

  final List<Map<String, dynamic>> _categoryWiseExpenses = [
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

  // Navigation functions
  void _openAddExpenseScreen() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => const AddExpenseScreen()),
    );
  }

  void _openExpenseListScreen() {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (_) => ExpenseListScreen()));
  }

  void _openSettingsScreen() {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (_) => SettingScreen()));
  }

  void _openBudgetScreen() {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (_) => BudgetScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const MyGradientAppBar(title: "Analytics"),
      body: SafeArea(child: _buildBody()),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Build body
  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: _buildContent(),
    );
  }

  // Build content
  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            _buildTotalExpenseWidget(),
            const SizedBox(
              height: 20,
            ),
            _buildMonthWiseExpenseChart(),
            const SizedBox(
              height: 20,
            ),
            _buildCategoryWiseExpenseChart(),
            const SizedBox(
              height: 20,
            ),
            _buildCategoryLegend(),
          ],
        ),
      ),
    );
  }

  // Build total expense widget
  Widget _buildTotalExpenseWidget() {
    return Padding(
      padding: MediaQuery.of(context).size.width > 600
          ? const EdgeInsets.symmetric(horizontal: 50)
          : const EdgeInsets.symmetric(horizontal: 15),
      child: const TotalExpenseWidget(),
    );
  }

  // Build month-wise expense chart
  Widget _buildMonthWiseExpenseChart() {
    return Column(
      children: [
        const Text(
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
      ],
    );
  }

  // Build category-wise expense chart
  Widget _buildCategoryWiseExpenseChart() {
    return Column(
      children: [
        const Text(
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
      ],
    );
  }

  // Build category legend
  Widget _buildCategoryLegend() {
    return Row(
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
                  // Color block
                  Container(
                    width: 20,
                    height: 20,
                    color: pieChartColors[index % pieChartColors.length],
                  ),
                  const SizedBox(width: 8),
                  // Category name
                  Text(
                    _categories[index],
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  // Build bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return CustomBottomNavBar(
      currentIndex: 1,
      onTap: (index) {
        setState(() {
          if (index == 0) {
            _openExpenseListScreen();
          } else if (index == 2) {
            _openAddExpenseScreen();
          } else if (index == 3) {
            _openBudgetScreen();
          } else if (index == 4) {
            _openSettingsScreen();
          }
        });
      },
    );
  }
}
