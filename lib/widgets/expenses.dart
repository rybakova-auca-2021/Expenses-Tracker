import 'package:expense_tracker/widgets/expenses-list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void _openAddExpenseOverlay() {
  showModalBottomSheet(
    context: context,
    builder: (context) => NewExpense(onAddExpense: _addExpense),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        AppBar(
          title: const Text("Expense Tracker"),
          backgroundColor: Colors.pink, 
          actions: [
            IconButton(
              onPressed: () {_openAddExpenseOverlay();}, 
              icon: const Icon(Icons.add)
            )
          ],
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text("The chart"),
          const SizedBox(height: 10),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense),
          )
        ]
      ),
    );
  }

}