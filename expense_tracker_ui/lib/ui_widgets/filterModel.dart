import 'package:expense_tracker_ui/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FilterModel extends StatefulWidget {
  const FilterModel({super.key});

  @override
  State<FilterModel> createState() => _FilterModelState();
}

class _FilterModelState extends State<FilterModel> {
  DateTime? _startDate = DateTime.now();
  DateTime? _endDate = DateTime.now();
  String? _selectedCategory;
  String? _sortBy = 'amount';
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  final List<String> _categories = [
    "Food",
    "Transportation",
    "Entertainment",
    "Utilities",
    "Shopping",
    "Clothes",
    "Electronics",
    "Jwellary",
    "Restaurant",
    "Grocery",
    "Others"
  ];
  final List<String> _sortOptions = ['amount', 'date'];

  void _applyFilters() {
    Provider.of<ExpenseProvider>(context, listen: false).fetchFilteredExpenses(
        category: _selectedCategory,
        startDate: _startDate,
        endDate: _endDate,
        sortBy: _sortBy);
    Navigator.pop(context);
  }

  Future<void> _pickStartDate() async {
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: _startDate ?? DateTime.now());

    if (pickedDate != null) {
      setState(() {
        _startDate = pickedDate;
      });
    }
    print('startDate: ' + _startDate.toString());
  }

  Future<void> _pickEndDate() async {
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: _endDate ?? DateTime.now());

    if (pickedDate != null && pickedDate != _endDate) {
      setState(() {
        _endDate = pickedDate;
      });
    }

    print('endDate: ' + _endDate.toString());
  }

  void _resetFilters() {
    // setState(() {
    //   _selectedCategory = null;
    //   _startDate = null;
    //   _endDate = null;
    //   _sortBy = 'amount';
    // });

    Provider.of<ExpenseProvider>(context, listen: false).fetchExpenses();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade900,
      title: const Text(
        'Filter Expenses',
        style: TextStyle(color: Colors.white),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                dropdownColor: Colors.blue.shade900,
                value: _selectedCategory,
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                decoration: const InputDecoration(
                   contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  labelText: 'Category',
                  fillColor: Colors.blue,
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.red)),
                  errorStyle: TextStyle(color: Colors.yellow),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.yellow)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Start Date : ',
                    style: TextStyle(color: Colors.white),
                  )),
                  
                  Expanded(
                    child: GestureDetector(
                      onTap: _pickStartDate,
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: _dateFormat.format(_startDate!).toString(),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
        
                   SizedBox(width: 5,), 
                   const Icon(Icons.calendar_today, size: 14 , color: Colors.white70),
        
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'End Date : ',
                    style: TextStyle(color: Colors.white),
                  )),
                  Expanded(
                    child: GestureDetector(
                      onTap: _pickEndDate,
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: _dateFormat.format(_endDate!).toString(),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                                   SizedBox(width: 5,), 
                   const Icon(Icons.calendar_today, size: 14 , color: Colors.white70),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                dropdownColor: Colors.blue.shade800,
                value: _sortBy,
                onChanged: (value) {
                  setState(() {
                    _sortBy = value;
                  });
                },
                decoration: const InputDecoration(
                   contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  labelText: 'Sort By',
                  fillColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.red)),
                  errorStyle: TextStyle(color: Colors.yellow),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.yellow)),
                ),
                items: _sortOptions.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(
                      option,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      actions: [
         ElevatedButton(
          onPressed: _applyFilters,
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
          child: Text('Apply', style: TextStyle(color: Colors.white),),
        ),
        TextButton(
            onPressed: _resetFilters,
            child: Text(
              'Reset',
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
