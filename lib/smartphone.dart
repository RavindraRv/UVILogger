import 'package:flutter/material.dart';
import 'package:login/measurements.dart';

class SmartphoneScreen extends StatefulWidget {
  const SmartphoneScreen({Key? key}) : super(key: key);

  @override
  _SmartphoneScreenState createState() => _SmartphoneScreenState();
}

class _SmartphoneScreenState extends State<SmartphoneScreen> {
  List<String> selectedSensors = [];
  List<bool> sensorSelections = List.generate(19, (index) => false);

  String getImagePath(int index) {
    switch (index) {
      case 0:
        return 'assets/acce.png';
      case 1:
        return 'assets/gyro.png';
      case 2:
        return 'assets/magnetometer.png';
      case 3:
        return 'assets/proximity.png';
      case 4:
        return 'assets/ambient.png';
      case 5:
        return 'assets/barometer.png';
      case 6:
        return 'assets/gps.png';
      case 7:
        return 'assets/fingerprint.png';
      case 8:
        return 'assets/face.png';
      case 9:
        return 'assets/heart.png';
      case 10:
        return 'assets/irblaster.png';
      case 11:
        return 'assets/hall.png';
      case 12:
        return 'assets/pedo.png';
      case 13:
        return 'assets/humidity.png';
      case 14:
        return 'assets/gesture.png';
      case 15:
        return 'assets/uv.png';
      case 16:
        return 'assets/ircamera.png';
      case 17:
        return 'assets/imu.png';
      case 18:
        return 'assets/ecg.png';
      default:
        return 'assets/smartphone.png';
    }
  }

  String getSensorName(int index) {
    switch (index) {
      case 0:
        return 'Accelerometer';
      case 1:
        return 'Gyroscope';
      case 2:
        return 'Magnetometer';
      case 3:
        return 'Proximity Sensor';
      case 4:
        return 'Ambient Light';
      case 5:
        return 'Barometer';
      case 6:
        return 'GPS';
      case 7:
        return 'Fingerprint';
      case 8:
        return 'Face Recognition';
      case 9:
        return 'Heart Rate';
      case 10:
        return 'IR Blaster';
      case 11:
        return 'Hall Sensor';
      case 12:
        return 'Pedometer';
      case 13:
        return 'Humidity Sensor';
      case 14:
        return 'Gesture Sensor';
      case 15:
        return 'UV Sensor';
      case 16:
        return 'IR Camera Sensor';
      case 17:
        return 'IMU';
      case 18:
        return 'ECG';
      default:
        return 'Unknown Sensor';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smartphone'),
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
                  title: Text(getSensorName(index)),
                  trailing: IconButton(
                    icon: Icon(
                      selectedSensors.contains(getSensorName(index))
                          ? Icons.check_circle
                          : Icons.circle,
                      color: selectedSensors.contains(getSensorName(index))
                          ? Colors.green
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        if (selectedSensors.contains(getSensorName(index))) {
                          selectedSensors.remove(getSensorName(index));
                        } else {
                          selectedSensors.add(getSensorName(index));
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
