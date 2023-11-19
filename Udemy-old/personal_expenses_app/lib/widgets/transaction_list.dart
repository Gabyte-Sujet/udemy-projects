import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key? key,
    required this.transactions,
    required this.deleteTx,
  }) : super(key: key);

  final List<Transaction> transactions;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'No transactions added yet!',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 20),
              Icon(
                Icons.error,
                size: 50,
                color: Colors.red,
              )
            ],
          )
        : ListView(
            children: [
              ...transactions
                  .map((tx) => TransactionItem(
                        key: ValueKey(tx.id),
                        transactions: tx,
                        deleteTx: deleteTx,
                      ))
                  .toList(),
            ],
            // return Card(
            //   child: Row(
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.symmetric(
            //           vertical: 10,
            //           horizontal: 15,
            //         ),
            //         padding: const EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: Colors.purple,
            //             width: 2,
            //           ),
            //         ),
            //         child: Text(
            //           '\$${transactions[index].amount.toStringAsFixed(2)}',
            //           style: const TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 20,
            //             color: Colors.purple,
            //           ),
            //         ),
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             transactions[index].title,
            //             style: const TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 16,
            //             ),
            //           ),
            //           Text(
            //             // DateFormat('yyyy-MM-dd').format(tx.date),
            //             DateFormat.yMMMd().format(transactions[index].date),
            //             style: const TextStyle(
            //               color: Colors.grey,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // );
          );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SizedBox(
  //     height: 300,
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: transactions
  //             .map((tx) => Card(
  //                     child: Row(
  //                   children: [
  //                     Container(
  //                       margin: const EdgeInsets.symmetric(
  //                         vertical: 10,
  //                         horizontal: 15,
  //                       ),
  //                       padding: const EdgeInsets.all(10),
  //                       decoration: BoxDecoration(
  //                         border: Border.all(
  //                           color: Colors.purple,
  //                           width: 2,
  //                         ),
  //                       ),
  //                       child: Text(
  //                         '\$${tx.amount}',
  //                         style: const TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 20,
  //                           color: Colors.purple,
  //                         ),
  //                       ),
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           tx.title,
  //                           style: const TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                         Text(
  //                           // DateFormat('yyyy-MM-dd').format(tx.date),
  //                           DateFormat.yMMMd().format(tx.date),
  //                           style: const TextStyle(
  //                             color: Colors.grey,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 )))
  //             .toList(),
  //       ),
  //     ),
  //   );
  // }
}

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transactions,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transactions;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    super.initState();
    print('initState');

    const List<MaterialColor> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
    ];
    _bgColor = colors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
                child: Text(
              '\$${widget.transactions.amount}',
              style: TextStyle(color: Colors.black),
            )),
          ),
        ),
        title: Text(widget.transactions.title),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transactions.date),
        ),
        trailing: IconButton(
            onPressed: () => widget.deleteTx(widget.transactions.id),
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ),
    );
  }
}
