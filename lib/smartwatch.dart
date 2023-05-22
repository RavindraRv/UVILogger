import 'package:flutter/material.dart';
import 'measurements.dart';

class SmartwatchScreen extends StatefulWidget {
  const SmartwatchScreen({Key? key}) : super(key: key);

  @override
  _SmartwatchScreenState createState() => _SmartwatchScreenState();
}

class _SmartwatchScreenState extends State<SmartwatchScreen> {
  List<String> selectedSensors = [];
  List<String> sensorSelections = [
    'Accelerometer',
    'Gyroscope',
    'Pedometer',
    'Oximetry Sensor',
    'Heart Rate',
    'Barometric pressure',
    'GSR Sensor',
    'Ambient Light',
    'Gesture',
    'GPS',
  ];

  String getImagePath(int index) {
    switch (index) {
      case 0:
        return 'assets/acce.png';
      case 1:
        return 'assets/gyro.png';
      case 2:
        return 'assets/pedo.png';
      case 3:
        return 'assets/oxy.png';
      case 4:
        return 'assets/heart.png';
      case 5:
        return 'assets/baro.png';
      case 6:
        return 'assets/gsr.png';
      case 7:
        return 'assets/ambi.png';
      case 8:
        return 'assets/gesture.png';
      case 9:
        return 'assets/gps.png';
      default:
        return 'assets/smartwatch.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smartwatch'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Open the side floating screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sensorSelections.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                    getImagePath(index),
                    width: 24,
                    height: 24,
                  ),
                  title: Text(sensorSelections[index]),
                  trailing: IconButton(
                    icon: Icon(
                      selectedSensors.contains(sensorSelections[index])
                          ? Icons.check_circle
                          : Icons.circle,
                      color: selectedSensors.contains(sensorSelections[index])
                          ? Colors.green
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        if (selectedSensors.contains(sensorSelections[index])) {
                          selectedSensors.remove(sensorSelections[index]);
                        } else {
                          selectedSensors.add(sensorSelections[index]);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedSensors.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MeasurementPage(selectedSensors: selectedSensors),
                  ),
                );
              } else {
                // Show a toast or snackbar indicating that sensors should be selected
              }
            },
            child: Text('Start Measurement'),
          ),
        ],
      ),
    );
  }
}
