import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    // Expense(
    //   title: 'Chicken',
    //   amount: 499,
    //   date: DateTime.now(),
    //   category: Category.food,
    // ),
    // Expense(
    //   title: 'Cinema',
    //   amount: 1500,
    //   date: DateTime.now(),
    //   category: Category.leisure,
    // ),
    // Expense(
    //   title: 'Zoho',
    //   amount: 0,
    //   date: DateTime.now(),
    //   category: Category.work,
    // ),
    // Expense(
    //   title: 'Cab',
    //   amount: 699,
    //   date: DateTime.now(),
    //   category: Category.travel,
    // ),
    // Expense(
    //   title: 'mouse',
    //   amount: 699,
    //   date: DateTime.now(),
    //   category: Category.products,
    // ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Expenese Found Start Adding Some'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Akhil\u0027s Expenese Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
