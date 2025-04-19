import 'package:expense_tracker_ui/models/expense.dart';
import 'package:expense_tracker_ui/providers/expense_provider.dart';
import 'package:expense_tracker_ui/screens/addExpenseScreen.dart';
import 'package:expense_tracker_ui/screens/budgetScreen.dart';
import 'package:expense_tracker_ui/screens/settingsScreen.dart';
import 'package:expense_tracker_ui/ui_widgets/AnalyticWidget.dart';
import 'package:expense_tracker_ui/ui_widgets/MyGradientAppBar.dart';
import 'package:expense_tracker_ui/ui_widgets/expense_tile.dart';
import 'package:expense_tracker_ui/ui_widgets/filter_action_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../ui_widgets/TotalExpenseWidget.dart';
import '../ui_widgets/navigation_bar.dart';
import 'analyticScreen.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  Future<void> _fetchExpenses() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await Provider.of<ExpenseProvider>(context, listen: false)
          .fetchExpenses();
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load Expenses. Please try again later.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _openAnalytics(List<Expense> expenses) {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (_) => AnalyticScreen(
                expenses: expenses,
              )),
    );
  }

  void _openAddExpenseScreen() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => const AddExpenseScreen()),
    );
  }

  void _openBudgetScreen() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => const BudgetScreen()),
    );
  }

  void _openSettingsScreen() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => const SettingScreen()),
    );
  }

  void _handleNavigation(int index, List<Expense> expenses) {
    setState(() {
      switch (index) {
        case 1:
          _openAnalytics(expenses);
          break;
        case 2:
          _openAddExpenseScreen();
          break;
        case 3:
          _openBudgetScreen();
          break;
        case 4:
          _openSettingsScreen();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<ExpenseProvider>(context).getExpenses();
    int currentIndex = 0;

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
        appBar: MyGradientAppBar(
          title: "Expenses",
          actions: [
            filter_button(context),
          ],
        ),
        body: SafeArea(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : _errorMessage != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _errorMessage!,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: _fetchExpenses,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  : expenses.isEmpty
                      ? const Center(
                          child: Text(
                            'No expenses found.',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : Column(
                          children: [
                            // ✅ Horizontal scroll section
                            Padding(
                              padding: MediaQuery.of(context).size.width > 600
                                  ? const EdgeInsets.symmetric(horizontal: 50)
                                  : const EdgeInsets.symmetric(horizontal: 15),
                              child: SizedBox(
                                height: 150,
                                child: ScrollConfiguration(
                                  behavior:
                                      const MaterialScrollBehavior().copyWith(
                                    dragDevices: {
                                      PointerDeviceKind.touch,
                                      PointerDeviceKind.mouse,
                                    },
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    child: Row(
                                      children: [
                                        TotalExpenseWidget(),
                                        const SizedBox(width: 10),
                                        AnalyticWidget(expenses: expenses),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // ✅ Expanded ListView
                            Expanded(
                              child: Padding(
                                padding: MediaQuery.of(context).size.width > 600
                                    ? const EdgeInsets.symmetric(horizontal: 50)
                                    : const EdgeInsets.symmetric(
                                        horizontal: 15),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: expenses.length,
                                  itemBuilder: (context, index) {
                                    final expense = expenses[index];
                                    return ExpenseTile(expense: expense);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) => _handleNavigation(index, expenses),
        ),
      ),
    );
  }
}
