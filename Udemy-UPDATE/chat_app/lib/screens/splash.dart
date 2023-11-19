import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              'assets/images/chat.png',
            ),
          ),
        ),
      ),
    );
  }
}
