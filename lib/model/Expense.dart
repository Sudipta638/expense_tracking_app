import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category { food, lesiure, travel, work }

const CategryIcon = {
  Category.food: Icons.lunch_dining,
  Category.lesiure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

final fromatdater = DateFormat.yMd();

class Expense {
  Expense(
      {required this.date,
      required this.title,
      required this.amount,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final Category category;

  String get formattedate {
    return fromatdater.format(date);
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

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; 
    }

    return sum;
  }
}