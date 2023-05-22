import 'package:flutter/material.dart';
import 'measurements.dart';

class EarphoneScreen extends StatefulWidget {
  const EarphoneScreen({Key? key}) : super(key: key);

  @override
  _EarphoneScreenState createState() => _EarphoneScreenState();
}

class _EarphoneScreenState extends State<EarphoneScreen> {
  bool sensor1Selected = false;
  bool sensor2Selected = false;
  bool sensor3Selected = false;

  @override
  Widget build(BuildContext context) {
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
              setState(() {
                sensor1Selected = !sensor1Selected;
              });
            },
          ),
          SensorButton(
            image: 'assets/acce.png',
            name: 'Accelerometer',
            selected: sensor2Selected,
            onTap: () {
              setState(() {
                sensor2Selected = !sensor2Selected;
              });
            },
          ),
          SensorButton(
            image: 'assets/gyro.png',
            name: 'Gyroscope',
            selected: sensor3Selected,
            onTap: () {
              setState(() {
                sensor3Selected = !sensor3Selected;
              });
            },
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              List<String> selectedSensors = [];

              if (sensor1Selected) {
                selectedSensors.add('Audio Sensor');
              }
              if (sensor2Selected) {
                selectedSensors.add('Accelerometer');
              }
              if (sensor3Selected) {
                selectedSensors.add('Gyroscope');
              }

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MeasurementPage(selectedSensors: selectedSensors)),
              );
            },
            child: Text('Start Measurement'),
          ),
        ],
      ),
    );
  }
}

class SensorButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        image,
        width: 40,
        height: 40,
      ),
      title: Text(name),
      trailing: IconButton(
        icon: Icon(
          selected ? Icons.check_circle : Icons.radio_button_unchecked,
          color: selected ? Colors.green : null,
        ),
        onPressed: onTap,
      ),
    );
  }
}
