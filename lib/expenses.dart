import 'package:expenses_tracker_app/new_expense.dart';
import 'package:expenses_tracker_app/widgets/chart/chart.dart';
import 'package:expenses_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/expense_data.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {

  final List<Expense> _registeredExpenses = [
    Expense(title: "Rona", amount: 19.99, date: DateTime.now(), category: Category.work),
    Expense(title: "Joy", amount: 19.99, date: DateTime.now(), category: Category.travel),
    Expense(title: "Yum", amount: 19.99, date: DateTime.now(), category: Category.food),
    Expense(title: "Gold", amount: 19.99, date: DateTime.now(), category: Category.leisure),
    Expense(title: "Mum", amount: 19.99, date: DateTime.now(), category: Category.food),
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense,)
    );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(duration: const Duration(seconds: 3),
            action: SnackBarAction(label: "Undo", onPressed: (){
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
            content: const Text("Expense deleted")));
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding some!"),
    );
    if(_registeredExpenses.isNotEmpty){
      mainContent = width < 600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,))
        ],
      ) : Row(
        children: [
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(child: ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,))
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expense Tracker"
        ),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: mainContent,
    );
  }
}