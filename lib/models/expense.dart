import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work, products }

const categoryIcons = {
  Category.food: Icons.lunch_dining_outlined,
  Category.travel: Icons.airplanemode_active_outlined,
  Category.leisure: Icons.local_movies_outlined,
  Category.work: Icons.work_outline_outlined,
  Category.products: Icons.shopping_cart_sharp
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id; //id for expense
  final String title; //Title of the Expenese
  final double amount; //9.00
  final DateTime date; //01.01.2024
  final Category category; //leisure,work,food,travel

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
