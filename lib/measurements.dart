import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors/sensors.dart';
import 'package:flutter_barometer/flutter_barometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';

class MeasurementPage extends StatefulWidget {
  final List<String> selectedSensors;

  const MeasurementPage({Key? key, required this.selectedSensors}) : super(key: key);

  @override
  _MeasurementPageState createState() => _MeasurementPageState();
}

class _MeasurementPageState extends State<MeasurementPage> {
  List<String> activities = [];
  String activityInput = '';
  bool isTimerRunning = false;
  int secondsElapsed = 0;
  late Timer timer;

  // Sensor data variables
  double accelerometerX = 0.0;
  double accelerometerY = 0.0;
  double accelerometerZ = 0.0;
  double gyroscopeX = 0.0;
  double gyroscopeY = 0.0;
  double gyroscopeZ = 0.0;
  double pressure = 0.0;
  double latitude = 0.0;
  double longitude = 0.0;
  double locationValue = 0.0;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (isTimerRunning) {
        setState(() {
          secondsElapsed++;
        });
      }
    });
    initializeSensors();
    requestLocationPermission();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> requestLocationPermission() async {
    final PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Location Permission'),
            content: Text('Please grant location permission to continue.'),
            actions: [
              CupertinoDialogAction(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: Text('Open Settings'),
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings();
                },
              ),
            ],
          );
        },
      );
    } else if (permissionStatus.isGranted) {
      retrieveLocationData();
    }
  }

  double calculateLocationValue() {
    double distance = sqrt(pow(latitude, 2) + pow(longitude, 2));
    return distance;
  }

  void retrieveLocationData() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      locationValue = calculateLocationValue(); // Calculate the location value

    });
  }

  void addActivity() {
    if (activities.length < 12 && activityInput.isNotEmpty) {
      setState(() {
        activities.add(activityInput);
        activityInput = '';
      });
    }
  }

  void toggleSensorSelection(String sensor) {
    setState(() {
      if (widget.selectedSensors.contains(sensor)) {
        widget.selectedSensors.remove(sensor);
      } else {
        widget.selectedSensors.add(sensor);
      }
    });
  }

  void startTimer() {
    setState(() {
      isTimerRunning = true;
    });
  }

  void stopTimer() {
    setState(() {
      isTimerRunning = false;
    });
  }

  void initializeSensors() {
    if (widget.selectedSensors.contains('Accelerometer')) {
      accelerometerEvents.listen((AccelerometerEvent event) {
        setState(() {
          accelerometerX = event.x;
          accelerometerY = event.y;
          accelerometerZ = event.z;
        });
      });
    }

    if (widget.selectedSensors.contains('Gyroscope')) {
      gyroscopeEvents.listen((GyroscopeEvent event) {
        setState(() {
          gyroscopeX = event.x;
          gyroscopeY = event.y;
          gyroscopeZ = event.z;
        });
      });
    }

    if (widget.selectedSensors.contains('Barometer')) {
      flutterBarometerEvents.listen((FlutterBarometerEvent event) {
        setState(() {
          pressure = event.pressure;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Measurement'),
        backgroundColor: Color(0xFF217EB9),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add Activity'),
                    content: TextField(
                      onChanged: (value) {
                        setState(() {
                          activityInput = value;
                        });
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: addActivity,
                        child: Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Add Activity'),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: activities.map((activity) {
              return ElevatedButton(
                onPressed: () {
                  toggleSensorSelection(activity);
                },
                style: ElevatedButton.styleFrom(
                  primary: widget.selectedSensors.contains(activity)
                      ? Colors.green
                      : Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(activity),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('GPS'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Latitude: ${latitude.toStringAsFixed(3)}'),
                        Text('Longitude: ${longitude.toStringAsFixed(3)}'),
                        Text('Value: ${locationValue.toStringAsFixed(3)}'), // Display the location value

                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.selectedSensors.length,
                    itemBuilder: (context, index) {
                      String sensor = widget.selectedSensors[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(sensor),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (sensor == 'Accelerometer') Text('X: $accelerometerX'),
                                if (sensor == 'Accelerometer') Text('Y: $accelerometerY'),
                                if (sensor == 'Accelerometer') Text('Z: $accelerometerZ'),
                                if (sensor == 'Gyroscope') Text('X: $gyroscopeX'),
                                if (sensor == 'Gyroscope') Text('Y: $gyroscopeY'),
                                if (sensor == 'Gyroscope') Text('Z: $gyroscopeZ'),
                                if (sensor == 'Barometer') Text('Pressure: $pressure'),
                                if (sensor == 'GPS') Text('${longitude.toStringAsFixed(3)}'),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: startTimer,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF156EB7),
                ),
                child: Text('Start'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: stopTimer,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF94144),
                ),
                child: Text('Stop'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('Timer: $secondsElapsed seconds'),
        ],
      ),
    );
  }
}
