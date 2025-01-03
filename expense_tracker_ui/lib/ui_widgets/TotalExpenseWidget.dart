import 'package:expense_tracker_ui/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TotalExpenseWidget extends StatelessWidget {
  const TotalExpenseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            CrossAxisAlignment.start,
        children: [
          Text(
            'Total Expense',
            style: GoogleFonts.montserrat(
                color: Colors.grey[50],
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          Consumer<ExpenseProvider>(builder:
              (context, expenseProvider, child) {
            return Text(
              '\$${expenseProvider.calculateTotalExpense().toString()}',
              style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            );
          })
        ],
      ),
    );
  }
}