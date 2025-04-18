import 'package:expense_tracker_ui/models/expense.dart';
import 'package:expense_tracker_ui/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../screens/analyticScreen.dart';

class AnalyticWidget extends StatelessWidget {
  final List<Expense> expenses;

  const AnalyticWidget({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {

    void _openAnalytics(List<Expense> expenses) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AnalyticScreen(expenses: expenses)),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.black45],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        blurRadius: 10,
        offset: Offset(4, 6),
      ),
    ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            icon: const Icon(
              Icons.bar_chart,
              color: Colors.white,
              size: 30,
            ),
            tooltip: "View Analytics",
          )
        ],
      ),
    );
  }
}
