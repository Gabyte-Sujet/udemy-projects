import 'dart:io';

import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    Key? key,
    required this.onAddExpense,
  }) : super(key: key);

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  Category? _selectedCategory = Category.leisure;

  DateTime? _selectedDate;

  final _amountFocusNode = FocusNode();

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Check it!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Check it!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory!,
      ),
    );

    Navigator.pop(context);
  }

  void setFocus(_) {
    FocusScope.of(context).requestFocus(_amountFocusNode);
  }

  // void _amountFieldFocusLost() {
  //   if (!_amountFocusNode.hasFocus) {
  //     _presentDatePicker();
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // _amountFocusNode.addListener(_amountFieldFocusLost);

    // _amountFocusNode.addListener(() =>
    //     print('focusNode updated: hasFocus: ${_amountFocusNode.hasFocus}'));
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
    _amountFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width >= 600)
                  Row(children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value as Category;
                        });
                      },
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(
                              Icons.calendar_month,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text('Save Expense'),
                    ),
                  ])
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value as Category;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });

    // return SizedBox(
    //   height: double.infinity,
    //   child: SingleChildScrollView(
    //     child: Padding(
    //       padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
    //       child: Column(
    //         children: [
    //           TextField(
    //             maxLength: 50,
    //             decoration: const InputDecoration(
    //               label: Text('Title'),
    //             ),
    //             controller: _titleController,
    //             textInputAction: TextInputAction.next,
    //             onSubmitted: setFocus,
    //           ),
    //           Row(
    //             children: [
    //               Expanded(
    //                 child: TextField(
    //                   decoration: const InputDecoration(
    //                     label: Text('Amount'),
    //                     prefixText: '\$ ',
    //                   ),
    //                   keyboardType:
    //                       const TextInputType.numberWithOptions(signed: true),
    //                   textInputAction: TextInputAction.next,
    //                   focusNode: _amountFocusNode,
    //                   controller: _amountController,
    //                 ),
    //               ),
    //               const SizedBox(width: 16),
    //               Expanded(
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Text(
    //                       _selectedDate == null
    //                           ? 'No date selected'
    //                           : formatter.format(_selectedDate!),
    //                     ),
    //                     IconButton(
    //                       onPressed: _presentDatePicker,
    //                       icon: const Icon(Icons.calendar_month),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //           const SizedBox(height: 16),
    //           Row(
    //             children: [
    //               DropdownButton(
    //                 value: _selectedCategory,
    //                 items: Category.values
    //                     .map(
    //                       (category) => DropdownMenuItem(
    //                         value: category,
    //                         child: Text(
    //                           category.name.toUpperCase(),
    //                         ),
    //                       ),
    //                     )
    //                     .toList(),
    //                 onChanged: (value) {
    //                   if (value == null) {
    //                     return;
    //                   }
    //                   setState(() {
    //                     _selectedCategory = value as Category;
    //                   });
    //                 },
    //               ),
    //               const Spacer(),
    //               TextButton(
    //                 onPressed: () {
    //                   // Navigator.pop(context);
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: const Text('Cancel'),
    //               ),
    //               ElevatedButton(
    //                 onPressed: _submitExpenseData,
    //                 child: const Text('Save Expense'),
    //               ),
    //             ],
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
