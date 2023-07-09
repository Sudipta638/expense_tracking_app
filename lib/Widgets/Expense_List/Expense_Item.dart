

import 'package:expense_traker/model/Expense.dart';
import 'package:flutter/material.dart';


class Expense_Item extends StatelessWidget {
const   Expense_Item(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                
                Text(expense.title,style: Theme.of(context).textTheme.titleLarge,),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text('\$${expense.amount.toStringAsFixed(2)}'),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(CategryIcon[expense.category]),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(expense.formattedate)
                      ],
                    )
                  ],
                )
              ],
            )));
  }
}
