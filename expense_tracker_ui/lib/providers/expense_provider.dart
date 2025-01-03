import 'package:expense_tracker_ui/models/expense.dart';
import 'package:expense_tracker_ui/services/expense_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> getExpenses() {
    _expenses.sort((c1, c2) {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");

      DateTime d1 = dateFormat.parse(c1.date);
      DateTime d2 = dateFormat.parse(c2.date);

      return d2.compareTo(d1);
    });
    return _expenses;
  }

  Future<void> fetchExpenses() async {
    try {
      _expenses = await ExpenseService().fetchExpenses();
      notifyListeners();
    } catch (error) {
      print('Error fetching expenses: $error');
      rethrow;
    }
  }

  Future<void> addExpense(Expense expense) async {
    final newExpense = await ExpenseService().addExpense(expense);
    _expenses.add(newExpense);
    notifyListeners();
  }

  Future<void> deleteExpense(int id) async {
    final isDeleted = await ExpenseService().deleteExpense(id);

    if (isDeleted) {
      _expenses.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }

  Future<void> updateExpense(int id, Expense expense) async {
    final updatedExpense = await ExpenseService().updateExpense(id, expense);

    final expenseIndex = _expenses.indexWhere((exp) => exp.id == id);
    if (expenseIndex >= 0) {
      _expenses[expenseIndex] = updatedExpense;
      notifyListeners();
    }
  }

  double calculateTotalExpense() {
    return _expenses.fold(
        0.0, (previousValue, element) => previousValue + element.amount);
  }

  Future<void> fetchFilteredExpenses({
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    String? sortBy,
  }) async {
    print("filter: " +
        category.toString() +
        " " +
        startDate.toString() +
        " " +
        endDate.toString() +
        " " +
        sortBy.toString());

    _expenses = await ExpenseService().fetchFilteredExpenses(
        category: category,
        startDate: startDate,
        endDate: endDate,
        sortBy: sortBy);

    print('expense : ' + _expenses.toString());

    notifyListeners();
  }
}
