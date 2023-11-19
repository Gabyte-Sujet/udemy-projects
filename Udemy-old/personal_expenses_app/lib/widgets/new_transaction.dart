import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({
    Key? key,
    required this.addTx,
  }) : super(key: key) {
    print('Constructor - NewTransaction Widget');
  }

  final Function addTx;

  @override
  State<NewTransaction> createState() {
    print('createState - NewTransaction Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  _NewTransactionState() {
    print('Constructor - NewTransaction State');
  }

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime? _selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      txTitle: enteredTitle,
      txAmount: enteredAmount,
      chosenDate: _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
                onSubmitted: (amount) {
                  submitData();
                  print('amount is: $amount');
                },
              ),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date chosen'
                            : DateFormat.yMd().format(_selectedDate!),
                      ),
                    ),
                    OutlinedButton(
                        onPressed: _presentDatePicker,
                        child: Text('Choose Date'))
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(primary: Colors.purple),
                onPressed: submitData,
                child: const Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
