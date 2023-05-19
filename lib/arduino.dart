import 'package:flutter/material.dart';

class ArduinoScreen extends StatelessWidget {
  const ArduinoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arduino'),
      ),
      body: Center(
        child: Text('Arduino Screen'),
      ),
    );
  }
}
