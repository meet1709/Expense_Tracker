// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:expense_tracker_ui/models/budget.dart';
import 'package:expense_tracker_ui/models/expense.dart';
import 'package:expense_tracker_ui/providers/budget_provider.dart';
import 'package:expense_tracker_ui/ui_widgets/MyGradientAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';
import '../ui_widgets/navigation_bar.dart';
import 'addExpenseScreen.dart';
import 'analyticScreen.dart';
import 'expense_list_screen.dart';
import 'settingsScreen.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<Expense> expenses = [];
  final _budgetController = TextEditingController();
  final _monthController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;

  // Form validation function
  String? _validateBudget(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a budget';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid budget';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _fetchBudget();
  }

  Future<void> _fetchBudget() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<BudgetProvider>(context, listen: false).fetchBudget();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Budget not found for this month, Please set the budget first: $error')),
      );
      throw Exception("NO budget Found");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Form submission function
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final budget = double.parse(_budgetController.text);
      final month = int.parse(_monthController.text);
      try {
        await Provider.of<BudgetProvider>(context, listen: false)
            .setBudget(Budget(month: month, budget: budget));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Budget set successfully')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to set budget: $error')),
        );
      }
    }
  }

  // Navigation functions
  void _openSettingsScreen() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => const SettingScreen()),
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
      CupertinoPageRoute(builder: (_) => const ExpenseListScreen()),
    );
  }

  void _openAddExpenseScreen() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => const AddExpenseScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    expenses = Provider.of<ExpenseProvider>(context).getExpenses();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const MyGradientAppBar(title: "Add Budget"),
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          _buildCurrentBudget(),
          const SizedBox(
            height: 20,
          ),
          _buildEditBudgetForm(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  // Build current budget
  Widget _buildCurrentBudget() {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        : Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Current Budget',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Month: ${Provider.of<BudgetProvider>(context).getBudget().month}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Budget: ${Provider.of<BudgetProvider>(context).getBudget().budget}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
  }

  // Build edit budget form
  Widget _buildEditBudgetForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildMonthField(),
          const SizedBox(
            height: 20,
          ),
          _buildBudgetField(),
          const SizedBox(
            height: 20,
          ),
          _buildSubmitButton(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  // Build month field
  Widget _buildMonthField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: _monthController,
      decoration: const InputDecoration(
        labelText: 'Month',
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a month';
        }
        return null;
      },
    );
  }

  // Build budget field
  Widget _buildBudgetField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: _budgetController,
      decoration: const InputDecoration(
        labelText: 'Budget',
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
      validator: _validateBudget,
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
        'Set Budget',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Build bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return CustomBottomNavBar(
      currentIndex: 3,
      onTap: (index) {
        setState(() {
          if (index == 0) {
            _openExpenseListScreen();
          } else if (index == 1) {
            _openAnalyticsScreen(expenses);
          } else if (index == 2) {
            _openAddExpenseScreen();
          } else if (index == 4) {
            _openSettingsScreen();
          }
        });
      },
    );
  }
}
