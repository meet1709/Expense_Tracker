import 'dart:convert';

import '../models/budget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BudgetService {
  final String baseUrl = "http://localhost:8080/api/budget";

  Future<Budget> setBudget(Budget budget) async {
    String monthBudgetToGet = budget.month.toString();

    try {
      final response = await http.post(
        Uri.parse(baseUrl + "/$monthBudgetToGet"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(budget.toJson()),
      );

      if (response.statusCode == 200) {
        return Budget.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load Budget");
      }
    } catch (error) {
      print('Error fetching Budget: $error');
      rethrow;
    }
  }



    Future<Budget> getBudget(int month) async {

      String monthString = month.toString();
    try {
      final response = await http.get(
        Uri.parse(baseUrl + "/$monthString"),
      );

      if (response.statusCode == 200) {
        return Budget.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load Budget");
      }
    } catch (error) {
      print('Error fetching Budget: $error');
      rethrow;
    }
  }
}
