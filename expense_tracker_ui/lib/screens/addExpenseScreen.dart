// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expense_tracker_ui/constants/constants.dart';
import 'package:expense_tracker_ui/models/expense.dart';
import 'package:expense_tracker_ui/providers/expense_provider.dart';
import 'package:expense_tracker_ui/screens/analyticScreen.dart';
import 'package:expense_tracker_ui/screens/budgetScreen.dart';
import 'package:expense_tracker_ui/screens/settingsScreen.dart';
import 'package:expense_tracker_ui/ui_widgets/MyGradientAppBar.dart';
import 'package:flutter/cupertino.dart';
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

  // Form validation functions
  String? _validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a category';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    return null;
  }

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid amount';
    }
    return null;
  }

  // Form submission function
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newExpense = Expense(
        category: _categoryController.text,
        description: _descriptionController.text,
        amount: double.parse(_amountController.text),
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );

      try {
        await Provider.of<ExpenseProvider>(context, listen: false)
            .addExpense(newExpense);
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add expense: $error')),
        );
      }
    }
  }

  // Navigation functions
  void _openSettingsScreen() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => SettingScreen()),
    );
  }

  void _openBudgetScreen() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => BudgetScreen()),
    );
  }

  void _openAnalyticsScreen(List<Expense> expenses) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (_) => AnalyticScreen(
          expenses: expenses,
        ),
      ),
    );
  }

  void _openExpenseListScreen() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => ExpenseListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<ExpenseProvider>(context).getExpenses();
    int currentIndex = 2;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const MyGradientAppBar(title: "Add Expenses"),
      body: SafeArea(child: _buildBody()),
      bottomNavigationBar: _buildBottomNavigationBar(expenses),
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _buildCategoryField(),
            const SizedBox(
              height: 20,
            ),
            _buildDescriptionField(),
            const SizedBox(
              height: 20,
            ),
            _buildAmountField(),
            const SizedBox(
              height: 20,
            ),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  // Build category field
  Widget _buildCategoryField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: _categoryController,
      decoration: const InputDecoration(
        labelText: 'Category',
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorStyle: TextStyle(color: Colors.yellow),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.yellow),
        ),
      ),
      validator: _validateCategory,
    );
  }

  // Build description field
  Widget _buildDescriptionField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: _descriptionController,
      decoration: const InputDecoration(
        labelText: 'Description',
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorStyle: TextStyle(color: Colors.yellow),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.yellow),
        ),
      ),
      validator: _validateDescription,
    );
  }

  // Build amount field
  Widget _buildAmountField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: _amountController,
      decoration: const InputDecoration(
        labelText: 'Amount',
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorStyle: TextStyle(color: Colors.yellow),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.yellow),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: _validateAmount,
    );
  }

  // Build submit button
  Widget _buildSubmitButton() {
    return ElevatedButton(
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
          color: Colors.white,
        ),
      ),
    );
  }

  // Build bottom navigation bar
  Widget _buildBottomNavigationBar(List<Expense> expenses) {
    return CustomBottomNavBar(
      currentIndex: 2,
      onTap: (index) {
        setState(() {
          if (index == 0) {
            _openExpenseListScreen();
          } else if (index == 1) {
            _openAnalyticsScreen(expenses);
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
