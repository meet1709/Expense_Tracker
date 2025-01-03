import 'package:expense_tracker_ui/models/expense.dart';
import 'package:expense_tracker_ui/providers/expense_provider.dart';
import 'package:expense_tracker_ui/screens/analyticScreen.dart';
import 'package:expense_tracker_ui/screens/budgetScreen.dart';
import 'package:expense_tracker_ui/screens/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../ui_widgets/navigation_bar.dart';
import 'expense_list_screen.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newExpense = Expense(
          category: _categoryController.text,
          description: _descriptionController.text,
          amount: double.parse(_amountController.text),
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()));

      try {
        await Provider.of<ExpenseProvider>(context, listen: false)
            .addExpense(newExpense);
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add expense: $error')));
      }
    }
  }

  void _openSettingsScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingScreen()));
  }

  void _openBudgestScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BudgetScreen()));
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

  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<ExpenseProvider>(context).getExpenses();
    int currentIndex = 2;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade800,
            Colors.black,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Add Expense',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _categoryController,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(color: Colors.red)),
                    errorStyle: TextStyle(color: Colors.yellow),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(color: Colors.yellow)),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please Enter a category' : null,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(color: Colors.red)),
                    errorStyle: TextStyle(color: Colors.yellow),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(color: Colors.yellow)),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a description' : null,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _amountController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(color: Colors.red)),
                    errorStyle: TextStyle(color: Colors.yellow),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(color: Colors.yellow)),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty || double.tryParse(value) == null
                          ? 'Please enter a valid amount'
                          : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    'Add Expense',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
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
              } else if (index == 1) {
                _openAnalytics(expenses);
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
