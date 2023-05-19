import 'package:flutter/material.dart';

class SmartwatchScreen extends StatefulWidget {
  const SmartwatchScreen({Key? key}) : super(key: key);

  @override
  _SmartwatchScreenState createState() => _SmartwatchScreenState();
}

class _SmartwatchScreenState extends State<SmartwatchScreen> {
  bool isMeasurementStarted = false;
  List<bool> sensorSelections = List.filled(10, false);
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
    // Add more cases for the remaining images
      default:
        return 'assets/smartwatch.png';
    }
  }

  String getSensorName(int index) {
    switch (index) {
      case 0:
        return 'Accelerometer';
      case 1:
        return 'Gyroscope';
      case 2:
        return 'Pedometer';
      case 3:
        return 'Oximetry Sensor';
      case 4:
        return 'Heart Rate ';
      case 5:
        return 'Barometric pressure';
      case 6:
        return 'GSR Sensor';
      case 7:
        return 'Ambient Light';
      case 8:
        return 'Gesture';
      case 9:
        return 'GPS';
    // Add more cases for the remaining sensor names
      default:
        return 'Unknown Sensor';
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
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                    getImagePath(index), // Method to get the image path based on index
                    width: 24,
                    height: 24,
                  ),
                  title: Text(getSensorName(index)), // Method to get the sensor name based on index
                  trailing: IconButton(
                    icon: Icon(
                      sensorSelections[index]
                          ? Icons.check_circle
                          : Icons.circle,
                      color: sensorSelections[index]
                          ? Colors.green
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        sensorSelections[index] = !sensorSelections[index];
                      });
                    },
                  ),
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: () {
              if (sensorSelections.contains(true)) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MeasurementScreen()),
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

class MeasurementScreen extends StatelessWidget {
  const MeasurementScreen({Key? key}) : super(key: key);

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
