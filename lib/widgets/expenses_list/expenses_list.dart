import 'package:expenses_tracker_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/expense_data.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: Theme.of(context).cardTheme.margin,
            ),
            onDismissed: (direction){
              onRemoveExpense(expenses[index]);
            },
            child: ExpensesItem(expenses[index])));
  }
}
