import 'package:expense_tracker_ui/ui_widgets/filterModel.dart';
import 'package:flutter/material.dart';

Widget filter_button(BuildContext context) {
  return IconButton(
    icon: const Icon(
      Icons.filter_list,
      color: Colors.white,
    ),
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) => FilterModel(),
      );
    },
  );
}
