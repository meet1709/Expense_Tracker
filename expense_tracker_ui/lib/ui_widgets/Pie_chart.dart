import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class PieChartWithHover extends StatefulWidget {
  final List<Expense> expenses;

  const PieChartWithHover({Key? key, required this.expenses}) : super(key: key);

  @override
  State<PieChartWithHover> createState() => _PieChartWithHoverState();
}

class _PieChartWithHoverState extends State<PieChartWithHover> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    double totalExpense = widget.expenses.fold(0, (sum, item) => sum + item.amount);

    Map<String, double> categoryExpenses = {};
    for (var expense in widget.expenses) {
      categoryExpenses[expense.category] =
          (categoryExpenses[expense.category] ?? 0) + expense.amount;
    }


  final List<Color> pieChartColors = [
    Colors.indigo.shade100,
    Colors.green.shade400,
    Colors.purple.shade400,
    Colors.orange.shade400,
    Colors.red.shade400,
    Colors.pink.shade400,
    Colors.yellow.shade400,
    Colors.lime.shade400,
    Colors.teal.shade400,
    Colors.amberAccent.shade400,
    Colors.lightGreen.shade400
  ];

    return PieChart(
      PieChartData(
        sections: List.generate(categoryExpenses.length, (index) {
          final isTouched = index == touchedIndex;
          final double percentage = (categoryExpenses.values.elementAt(index) / totalExpense) * 100;

          return PieChartSectionData(
            color: pieChartColors[index % pieChartColors.length],
            value: categoryExpenses.values.elementAt(index),
            title: '${percentage.toStringAsFixed(1)}%',
            radius: isTouched ? 90 : 70, // Expand radius if touched
            titleStyle: TextStyle(
              fontSize:isTouched ? 25 : 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }),
        sectionsSpace: 2,
        centerSpaceRadius: 50,
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, PieTouchResponse? response) {
            if (!event.isInterestedForInteractions ||
                response == null ||
                response.touchedSection == null) {
              setState(() {
                touchedIndex = null;
              });
              return;
            }

            setState(() {
              touchedIndex = response.touchedSection!.touchedSectionIndex;
            });
          },
        ),
      ),
    );
  }
}
