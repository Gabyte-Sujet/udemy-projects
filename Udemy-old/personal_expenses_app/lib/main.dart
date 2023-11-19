import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/transaction_list.dart';

class User {
  const User(this.name, this.id);
  final String name;
  final int id;

  static List<User> users = [
    User('user1', 1),
    User('user1', 2),
    User('user1', 3),
  ];
}

class CustomStyle extends InheritedWidget {
  const CustomStyle({super.key, required super.child, required this.color});

  final Color color;

  static CustomStyle? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomStyle>();
  }

  static CustomStyle of(BuildContext context) {
    final CustomStyle? result = maybeOf(context);
    assert(result != null);
    return result!;
  }

  @override
  bool updateShouldNotify(CustomStyle oldWidget) {
    return oldWidget.color != this.color;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: CustomStyle(
        color: Colors.green,
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'Shoes',
      amount: 16.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Groceries',
      amount: 1222225.45,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Grocheyheyeries',
      amount: 100.60,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'blabla',
      amount: 50.10,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction({
    required String txTitle,
    required double txAmount,
    required DateTime chosenDate,
  }) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: false,
      builder: (bCtx) {
        return FractionallySizedBox(
          // heightFactor: 0.7,
          child: NewTransaction(addTx: _addNewTransaction),
        );
      },
    );
  }

  bool _showChart = true;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text('Personal Expenses App'),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'testing',
              style: TextStyle(color: CustomStyle.of(context).color),
              textAlign: TextAlign.center,
            ),
            isLandscape
                ? Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                : SizedBox.shrink(),
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.3,
                    child: Chart(recentTransactions: _recentTransactions),
                  )
                : SizedBox.shrink(),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: TransactionList(
                transactions: _userTransactions,
                deleteTx: _deleteTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: Platform.isIOS
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
