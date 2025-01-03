
import 'package:expense_tracker_ui/models/expense.dart';
import 'package:expense_tracker_ui/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});

  final Expense expense;

@override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.black45],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          title: Text(
            expense.category,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                expense.description,
                style: GoogleFonts.roboto(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.white70),
                  const SizedBox(width: 5),
                  Text(
                    'Date: ${expense.date}',
                    style: GoogleFonts.roboto(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.monetization_on, size: 16, color: Colors.greenAccent),
                  const SizedBox(width: 5),
                  Text(
                    '\$${expense.amount}',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  _modifyExpense(context, expense);
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                splashRadius: 20,
              ),
              IconButton(
                onPressed: () {
                  _deleteExpense(context, expense);
                },
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  void _deleteExpense(BuildContext context, Expense expense) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.blue.shade900,
            title: const Text(
              'Delete Expense',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Are you sure you want to delete this expense?',
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Provider.of<ExpenseProvider>(context, listen: false)
                        .deleteExpense(expense.id!)
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Expense Deleted successfully!'),
                      ));
                    }).catchError((onError) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Failed to delete Expense')));
                    });

                    Navigator.of(ctx).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
            ],
          );
        });
  }

  void _modifyExpense(BuildContext context, Expense expense) {
    final _categoryController = TextEditingController(
      text: expense.category,
    );
    final _descriptionController =
        TextEditingController(text: expense.description);
    final _amountController =
        TextEditingController(text: expense.amount.toString());

    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.blue.shade900,
            title: const Text(
              'Modify Expense',
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: TextStyle(color: Colors.white),
                    errorStyle: TextStyle(color: Colors.yellow),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please Enter a category' : null,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.white),
                    errorStyle: TextStyle(color: Colors.yellow),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a description' : null,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(color: Colors.white),
                    errorStyle: TextStyle(color: Colors.yellow),
                  ),
                  validator: (value) =>
                      value!.isEmpty || double.tryParse(value) == null
                          ? 'Please enter a valid amount'
                          : null,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final updatedExpense = Expense(
                    id: expense.id, // Retain the same id
                    category: _categoryController.text,
                    description: _descriptionController.text,
                    amount: double.parse(_amountController.text),
                    date: expense.date, // No change to the date
                  );

                  Provider.of<ExpenseProvider>(context, listen: false)
                      .updateExpense(expense.id!, updatedExpense)
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Expense Updated successfully!'),
                    ));
                  }).catchError((onError) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Failed to update Expense')));
                  });

                  Navigator.of(ctx).pop();
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
            ],
          );
        });
  }
