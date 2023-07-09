import 'package:expense_traker/Widgets/Expense_List/Expense_list.dart';
import 'package:expense_traker/Widgets/New_Expense.dart';
import 'package:expense_traker/model/Expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_traker/Widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpense = [
    
  ];

  void _addexpense(Expense expense) {
    setState(() {
      _registerExpense.add(expense);
    });
  }

  void _removeexpense(Expense expense) {
    final expenseIndex = _registerExpense.indexOf(expense);
    setState(() {
      _registerExpense.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Expense deleted"),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registerExpense.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  void _showaddexpenseoverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => New_expense(onAddExpense: _addexpense),
        constraints: const BoxConstraints(maxHeight: double.infinity));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent =
        const Center(child: Text("No expense added !please add new expenses"));

    if (_registerExpense.isNotEmpty) {
      mainContent = Expense_list(
        expenselist: _registerExpense,
        onswipeexpense: _removeexpense,
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Expensetracker"),
        actions: [
          IconButton(
              onPressed: _showaddexpenseoverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width <= 600
          ? Column(children: [
              Chart(expenses: _registerExpense),
              Expanded(child: mainContent)
            ])
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registerExpense)),
                Expanded(child: mainContent)
              ],
            ),
    );
  }
}
