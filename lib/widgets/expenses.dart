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
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter course', 
      amount: 19.99, 
      date: DateTime.now(), 
      category: Category.work
    ),
    Expense(
      title: 'Cinema', 
      amount: 13.19, 
      date: DateTime.now(), 
      category: Category.leisure
    )
  ];

  void _openAddExpenseOverlay() {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (context) => const NewExpense(),
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
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          )
        ]
      ),
    );
  }

}