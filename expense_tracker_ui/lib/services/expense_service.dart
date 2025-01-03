import 'dart:convert';

import 'package:expense_tracker_ui/models/expense.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ExpenseService {
  final String baseUrl = "http://localhost:8080/api/expenses";

  Future<List<Expense>> fetchExpenses() async {
    try {
      final resposne = await http.get(Uri.parse(baseUrl));

      if (resposne.statusCode == 200) {
        List jsonData = jsonDecode(resposne.body);
        return jsonData.map((expense) => Expense.fromJson(expense)).toList();
      } else {
        throw Exception("Failed to load expenses");
      }
    } catch (error) {
      print('Error fetching expenses: $error');
      rethrow;
    }
  }

  Future<Expense> addExpense(Expense expense) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(expense.toJson()),
    );

    if (response.statusCode == 200) {
      return Expense.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to add expense. Status code: ${response.statusCode}');
    }
  }

  Future<bool> deleteExpense(int id) async {
    final url = baseUrl + "/$id";

    try {
      final resposne = await http.delete(Uri.parse(url));

      if (resposne.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete expense: ${resposne.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to delete expense: $error');
    }
  }

  Future<Expense> updateExpense(int id, Expense expense) async {
    final url = baseUrl + "/$id";

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(expense.toJson()),
      );

      if (response.statusCode == 200) {
        return  Expense.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update expense: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to update expense: $error');
    }
  }

  Future<List<Expense>> fetchFilteredExpenses({String? category, DateTime? startDate, DateTime? endDate, String? sortBy}) async {

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

     final url = Uri.parse(baseUrl+'/filter',).replace(queryParameters: {
        'category': category != null ? category : null,
        'startDate': _dateFormat.format(startDate!).toString(),
        'endDate': _dateFormat.format(endDate!).toString(),
        'sortBy': sortBy ?? '',
      }).toString();

     try {
      final response = await http.get(Uri.parse(url));
      print('response: ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        final List<dynamic> expenseData = json.decode(response.body);
        return expenseData.map((e) => Expense.fromJson(e)).toList(); // Update displayed list

      } else {
        throw Exception('Failed to fetch filtered expenses');
      }
    } catch (error) {
      throw Exception('Error fetching expenses: $error');
    }

  }

}
