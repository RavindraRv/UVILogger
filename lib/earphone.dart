import 'package:flutter/material.dart';
import 'measurements.dart';

class EarphoneScreen extends StatelessWidget {
  const EarphoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool sensor1Selected = false;
    bool sensor2Selected = false;
    bool sensor3Selected = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Earphone'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Open floating screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          SensorButton(
            image: 'assets/audio.png',
            name: 'Audio Sensor',
            selected: sensor1Selected,
            onTap: () {
              sensor1Selected = !sensor1Selected;
            },
          ),
          SensorButton(
            image: 'assets/acce.png',
            name: 'Accelerometer',
            selected: sensor2Selected,
            onTap: () {
              sensor2Selected = !sensor2Selected;
            },
          ),
          SensorButton(
            image: 'assets/gyro.png',
            name: 'Gyroscope',
            selected: sensor3Selected,
            onTap: () {
              sensor3Selected = !sensor3Selected;
            },
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MeasurementPage()),
              );
            },
            child: Text('Start Measurement'),
          ),
        ],
      ),
    );
  }
}

class SensorButton extends StatefulWidget {
  final String image;
  final String name;
  final bool selected;
  final VoidCallback onTap;

  const SensorButton({
    required this.image,
    required this.name,
    required this.selected,
    required this.onTap,
  });

  @override
  _SensorButtonState createState() => _SensorButtonState();
}

class _SensorButtonState extends State<SensorButton> {
  bool selected = false;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        widget.image,
        width: 40,
        height: 40,
      ),
      title: Text(widget.name),
      trailing: IconButton(
        icon: Icon(
          selected ? Icons.check_circle : Icons.radio_button_unchecked,
          color: selected ? Colors.green : null,
        ),
        onPressed: () {
          setState(() {
            selected = !selected;
            widget.onTap();
          });
        },
      ),
    );
  }
}

