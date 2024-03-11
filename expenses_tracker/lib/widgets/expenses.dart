import 'package:expenses_tracker/widgets/chart/chart.dart';
import 'package:expenses_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses( { super.key} );

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpenses = [
    Expense(
      title: "Flutter course", 
      amount: 19.99, 
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema", 
      amount: 15.69, 
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openForm() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registerExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(child: Text('No expensses found. Start adding some!'),);

    if (_registerExpenses.isNotEmpty){
      mainContent = ExpensesList(
        expenses: _registerExpenses, 
        onRemove: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openForm, 
            icon: const Icon(Icons.add)
          ),
        ],
      ),
      body: width < 600 
        ? Column(
          children: [
            Chart(expenses: _registerExpenses),
            Expanded(child: 
              mainContent
            ),
          ],
        )
        : Row(
          children: [
            Expanded(child: Chart(expenses: _registerExpenses)),
            Expanded(child: 
              mainContent
            ),
          ],
        ),
    );
  }
}