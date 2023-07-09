import 'package:expense_traker/Widgets/Expense_List/Expense_Item.dart';
import 'package:expense_traker/model/Expense.dart';
import 'package:flutter/material.dart';

class Expense_list extends StatelessWidget {
  const Expense_list(
      {super.key, required this.onswipeexpense, required this.expenselist});
  final List<Expense> expenselist;
  final void Function(Expense expense) onswipeexpense;
  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
        itemCount: expenselist.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenselist[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,
              ),
            ),
            onDismissed: (direction) => onswipeexpense(expenselist[index]),
            child: Expense_Item(expenselist[index])));
  }
}
