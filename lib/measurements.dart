import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors/sensors.dart';
//import 'package:proximity_sensor/proximity_sensor.dart';
//import 'package:light/light.dart';
import 'package:flutter_barometer/flutter_barometer.dart';
//import 'package:heart_rate_flutter/heart_rate_flutter.dart';
//import 'package:pedometer/pedometer.dart';

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
  double proximity = 0.0;
  double light = 0.0;
  double pressure = 0.0;
  double heartRate = 0.0;
  double stepCount = 0.0;

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

    // Initialize sensor listeners for selected sensors
    initializeSensors();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
/*
    if (widget.selectedSensors.contains('Proximity')) {
      proximityEvents.listen((ProximityEvent event) {
        setState(() {
          proximity = event.getValue();
        });
      });
    }*/

   /* if (widget.selectedSensors.contains('Ambient light')) {
      lightEvents.listen((LightEvent event) {
        setState(() {
          light = event.light;
        });
      });
    }
*/
    if (widget.selectedSensors.contains('Barometer')) {
      flutterBarometerEvents.listen((FlutterBarometerEvent event) {
        setState(() {
          pressure = event.pressure;
        });
      });
    }

    /*if (widget.selectedSensors.contains('Heart Rate')) {
      HeartRateMonitor heartRateMonitor = HeartRateMonitor();
      heartRateMonitor.startSensor().then((HeartRatePulseEvent event) {
        setState(() {
          heartRate = event.heartRate!;
        });
      });
    }*/

    /*if (widget.selectedSensors.contains('Pedometer')) {
      Pedometer pedometer = Pedometer();
      pedometer.pedometerStream.listen((PedometerEvent event) {
        setState(() {
          stepCount = event.steps!.toDouble();
        });
      });
    }*/
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
                        Text('Value: 0.000'),
                        Text('Latitude: 0.000'),
                        Text('Longitude: Location'),
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
                                if (sensor == 'Proximity') Text('Value: $proximity'),
                                if (sensor == 'Ambient light') Text('Value: $light'),
                                if (sensor == 'Barometer') Text('Pressure: $pressure'),
                                if (sensor == 'Heart Rate') Text('Heart Rate: $heartRate'),
                                if (sensor == 'Pedometer') Text('Step Count: $stepCount'),
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
