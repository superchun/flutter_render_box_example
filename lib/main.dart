import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:render_box/hexagonal_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final _tapGestureRecognizer = TapGestureRecognizer()..onTap = _onTap;

  _onTap() {
    debugPrint('点击了开始。。。。');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HexagonalButton(
          color: Colors.lightBlueAccent,
          clipSize: 20,
          padding: const EdgeInsets.all(4),
          onTap: _onTap,
          onPointerDown: _tapGestureRecognizer.addPointer,
          child: const Text('自定义之旅'),
        ),
      ),
    );
  }
}
