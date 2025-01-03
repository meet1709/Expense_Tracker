import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

class BarChartWidget extends StatelessWidget {
  final List<Expense> expenses;

  const BarChartWidget({Key? key, required this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    Map<String, double> monthExpenses = {};
    for (var expense in expenses) {
      String month =
          '${dateFormat.parse(expense.date).year}-${dateFormat.parse(expense.date).month.toString().padLeft(2, '0')}';
      monthExpenses[month] = (monthExpenses[month] ?? 0) + expense.amount;
    }

    List<String> months = monthExpenses.keys.toList();
    List<double> amounts = monthExpenses.values.toList();

    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              int idx = value.toInt();
              return (idx >= 0 && idx < months.length) ? months[idx] : '';
            },
            getTextStyles: (context, value) {
              return const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              );
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) {
              return const TextStyle(
                color: Colors.white,
                fontSize: 12,
              );
            },
          ),
          rightTitles: SideTitles(showTitles: false),
        ),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.white.withOpacity(0.3), // Grid color
            strokeWidth: 1,
            dashArray: [5, 5],
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: Colors.white.withOpacity(0.3), // Grid color
            strokeWidth: 1,
            dashArray: [5, 5],
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(width: 1, color: Colors.white),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blue.shade900,
            tooltipPadding: const EdgeInsets.all(16),
            tooltipMargin: 8,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${months[group.x.toInt()]}: \$${rod.y.toStringAsFixed(2)}',
                const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        barGroups: List.generate(months.length, (index) {
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                y: amounts[index],
                colors: [Colors.purple.shade400], // Bar color
                width: 16, // Bar width
                borderRadius: BorderRadius.zero, // Non-rounded bars
              ),
            ],
          );
        }),
      ),
    );
  }
}
