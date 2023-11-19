import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Number with ChangeNotifier {
  int numb = 0;

  void incrementNumb() {
    numb += 1;
    notifyListeners();
  }
}

class ChangeMode with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  void toggle() {
    _isDark = !isDark;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider<ChangeMode>(
      create: (context) => ChangeMode(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = Provider.of<ChangeMode>(context).isDark;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      routes: <String, WidgetBuilder>{
        '/': (context) {
          return const MyHomePage(title: 'Provider');
        }
      },
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
  String _counter2 = '11';

  void _incrementCounter() {
    setState(() {
      _counter++;
      _counter2 = '22';
    });
    print(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Switch(
              value: Provider.of<ChangeMode>(context).isDark,
              onChanged: (val) {
                Provider.of<ChangeMode>(context, listen: false).toggle();
              },
            ),
            const Text('Pushed button this many times:'),
            const SizedBox(height: 20),
            // Provider(
            //   create: (context) => _counter,
            //   child: const CounterNumber(),
            // ),
            // Provider.value(
            //   value: _counter,
            //   child: const CounterNumber(),
            // ),
            // ProxyProvider0<int>(
            //   update: (context, value) {
            //     print('previous $value');
            //     return _counter;
            //   },
            //   child: const CounterNumber(),
            // ),
            MultiProvider(
              providers: [
                ProxyProvider0<int>(update: (context, value) => _counter),
                ProxyProvider0<String>(update: (context, value) => _counter2),
                ProxyProvider2<int, String, Translations>(
                  update: (context, value, val, previous) {
                    print('value $val');
                    print(
                        'previous ${previous != null ? previous.val : 'null'}');
                    return Translations(value: value);
                  },
                ),
              ],
              child: const CounterNumber(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Translations {
  Translations({required int value}) : _value = value;
  final int _value;

  String get val => 'You clicked $_value times';
}

class CounterNumber extends StatelessWidget {
  const CounterNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<int>(context).toString();
    final translation = Provider.of<Translations>(context);
    return Text(
      translation.val,
    );
  }
}
