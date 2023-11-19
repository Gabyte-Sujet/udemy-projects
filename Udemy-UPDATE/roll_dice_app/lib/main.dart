import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GradientContainer(
        number: _counter,
        color1: Colors.green,
        color2: Colors.pink,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
      ),
    );
  }
}

class GradientContainer extends StatefulWidget {
  const GradientContainer(
      {super.key,
      required this.color1,
      required this.color2,
      required this.number});

  // const GradientContainer.purple({key})
  //     : this(key: key, color1: Colors.purple, color2: Colors.greenAccent);

  const GradientContainer.purple({key})
      : this(
            key: key,
            color1: Colors.purple,
            color2: Colors.greenAccent,
            number: 0);

  final int number;
  final Color color1;
  final Color color2;

  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  late int randomNumber;

  void rollDice() {
    setState(() {
      randomNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  void initState() {
    super.initState();
    rollDice();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [widget.color1, widget.color2],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.number.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            InkWell(
              onLongPress: rollDice,
              child: Image.asset(
                'assets/images/dice-$randomNumber.png',
                width: 200,
              ),
            ),
            Text(
              randomNumber.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: rollDice,
              child: const Text('Roll Dice'),
            ),
          ],
        ),
      ),
    );
  }
}
