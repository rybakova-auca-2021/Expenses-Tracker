import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final Function(Expense expense) onAddExpense;

  
  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;


  Future<void> _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: now
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData(BuildContext context) {
  final enteredAmount = double.tryParse(_amountController.text);
  final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
  
  if (_titleController.text.trim().isEmpty) {
    _showErrorDialog(context, 'Title cannot be empty.');
  } else if (_amountController.text.trim().isEmpty || amountIsInvalid) {
    _showErrorDialog(context, 'Amount cannot be empty.');
  } else {
    final selectedDate = _selectedDate ?? DateTime.now();
    final selectedCategory = _selectedCategory ?? Category.food;

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount.toDouble(),
        date: selectedDate,
        category: selectedCategory,
      ),
    );
  }
}


void _showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK', style: TextStyle(color: Colors.pink)),
          ),
        ],
      );
    },
  );
}


  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  
 @override
Widget build(BuildContext context) {
  final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

  return Stack(
    children: [
      SingleChildScrollView(
        child: Container (
          width: double.infinity,
          decoration: const ShapeDecoration(color: Color.fromARGB(255, 255, 235, 244), shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 30, 16, 30 + keyboardSpace),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  maxLength: 70, 
                  decoration: InputDecoration(
                    label: const Text("Title"),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: 
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixText: "\$ ",
                          label: const Text("Amount"),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null ? "No date selected" : formatter.format(_selectedDate!),
                            style: const TextStyle(color: Colors.black)
                          ),
                          IconButton(
                            onPressed: () {_presentDatePicker();}, 
                            icon: const Icon(Icons.calendar_month), color: const Color.fromARGB(255, 104, 16, 46),),
                        ],
                      )
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values.map(
                        (category) => DropdownMenuItem(
                          value: category,
                            child: Text(category.name.toUpperCase())
                          )
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          }
                        );
                      },
                      style: const TextStyle(color: Colors.black),
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container (height: 2, color: const Color.fromARGB(255, 45, 45, 45)),
                      dropdownColor: Colors.white,
                    ), 
                    const Spacer(),  
                    ElevatedButton(
                      onPressed: () {_submitExpenseData(context);},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50)), 
                      child: const Text("Save"),
                    ),
                    const SizedBox(width: 30),
                    TextButton(
                      onPressed: () {Navigator.pop(context);}, 
                      child: const Text("Cancel", style: TextStyle(color: Colors.pink),)
                    )
                  ],
                )
              ]   
            ),
          ),
        ),
      ),
    ],
  );
}
}