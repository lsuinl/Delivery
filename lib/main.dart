import 'package:flutter/material.dart';

void main() {
  runApp(
  _App()
  );
}

class _App extends StatelessWidget { //_:private
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(

        ),
      )
    );
  }
}
