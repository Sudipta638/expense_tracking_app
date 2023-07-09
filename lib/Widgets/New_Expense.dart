import 'package:flutter/material.dart';
import 'package:expense_traker/model/Expense.dart';

class New_expense extends StatefulWidget {
  const New_expense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<New_expense> createState() {
    // TODO: implement createState
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<New_expense> {
  // var title = '';

  // void _savetitle(String input_text) {
  //   title = input_text;
  // }
  final _tittlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selecteddate;
  Category _selectedcategory = Category.lesiure;

  void _presentdatepicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);

    final pickeddate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: now);

    setState(() {
      _selecteddate = pickeddate;
    });
  }

  void _submitexpense() {
    final amount = double.tryParse(_amountcontroller.text);
    final Isamountinvalid = amount == null || amount <= 0;
    if (_tittlecontroller.text.trim().isEmpty ||
        Isamountinvalid ||
        _selecteddate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid Input"),
                content: const Text(
                    "Please check title ,amount , date and category was entered"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Okay"))
                ],
              ));
      return;
    }

    widget.onAddExpense(
      Expense(
          date: _selecteddate!,
          title: _tittlecontroller.text,
          amount: amount,
          category: _selectedcategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _amountcontroller.dispose();
    _tittlecontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardspace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _tittlecontroller,
                          maxLength: 50,
                          decoration: const InputDecoration(label: Text("Title")),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                    
                         Expanded(
                          child: TextField(
                            controller: _amountcontroller,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                label: Text("Amount"), prefixText: '₹'),
                          ),
                      
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _tittlecontroller,
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text("Title")),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedcategory,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedcategory = value;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selecteddate != null
                              ? fromatdater.format(_selecteddate!)
                              : "No date picked"),
                          IconButton(
                              onPressed: _presentdatepicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ))
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountcontroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text("Amount"), prefixText: '₹'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selecteddate != null
                              ? fromatdater.format(_selecteddate!)
                              : "No date picked"),
                          IconButton(
                              onPressed: _presentdatepicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ))
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(
                    children: [ const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      ElevatedButton(
                          onPressed: _submitexpense,
                          child: const Text("Save Expenses"))],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedcategory,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedcategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      ElevatedButton(
                          onPressed: _submitexpense,
                          child: const Text("Save Expenses"))
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
