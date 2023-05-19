import 'package:flutter/material.dart';

class MeasurementPage extends StatelessWidget {
  const MeasurementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Measurement'),
      ),
      body: Center(
        child: Text('Measurement Screen'),
      ),
    );
  }
}
