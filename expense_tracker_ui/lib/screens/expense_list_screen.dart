import 'package:expense_tracker_ui/models/expense.dart';
import 'package:expense_tracker_ui/providers/expense_provider.dart';
import 'package:expense_tracker_ui/screens/addExpenseScreen.dart';
import 'package:expense_tracker_ui/screens/budgetScreen.dart';
import 'package:expense_tracker_ui/screens/settingsScreen.dart';
import 'package:expense_tracker_ui/ui_widgets/expense_tile.dart';
import 'package:expense_tracker_ui/ui_widgets/filter_action_widget.dart';
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
    // TODO: implement initState
    super.initState();
    fetchExpenses();
  }

  Future<void> fetchExpenses() async {
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

  // Open Add Expense Screen
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

  void _openBudgestScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BudgetScreen()));
  }

  void _openSettingsScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingScreen()));
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
        appBar: AppBar(
          //backgroundColor: Colors.blue.shade900.withOpacity(0.9),
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade800,
                  Colors.black,
                ],
                begin: Alignment.topLeft,
              ),
            ),
          ),
          title: const Text(
            "Expenses",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
          actions: [
            filter_button(context),
          ],
        ),
        body: _isLoading
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
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: fetchExpenses,
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
                          Padding(
                            padding: MediaQuery.of(context).size.width > 600
                                ? EdgeInsets.symmetric(horizontal: 50)
                                : EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TotalExpenseWidget(),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.blue.shade700,
                                          Colors.black45
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Analytics View',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey[50],
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _openAnalytics(expenses);
                                        },
                                        icon: Icon(
                                          Icons.bar_chart,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        tooltip: "View Analytics",
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: MediaQuery.of(context).size.width > 600
                                  ? EdgeInsets.symmetric(horizontal: 50)
                                  : EdgeInsets.symmetric(horizontal: 15),
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
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              if (index == 1) {
                _openAnalytics(expenses);
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
