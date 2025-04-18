import 'package:expense_tracker_ui/services/budget_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker_ui/models/budget.dart';

class BudgetProvider with ChangeNotifier {
  Budget _budget = Budget();

  Budget getBudget() {
    return _budget;
  }

  Future<void> setBudget(Budget budget) async {
    _budget = await BudgetService().setBudget(budget);
    if(_budget.month == DateTime.now().month){
      notifyListeners();
    }

  }

  int currentMonth = DateTime.now().month;

  Future<void> fetchBudget() async {
    int currentMonth = DateTime.now().month;
    try {
      _budget = await BudgetService().getBudget(currentMonth);

      notifyListeners();
    } catch (error) {
      print('Error fetching expenses: $error');
      rethrow;
    }
  }

  void updateBudget(Budget budget) {
    _budget = budget;
    notifyListeners();
  }

  void deleteBudget() {
    _budget = Budget(month: 0, budget: 0.0);
    notifyListeners();
  }
}
