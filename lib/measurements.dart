import 'package:flutter/material.dart';
import 'dart:async';

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
                                Text('X: 0.000'),
                                Text('Y: 0.000'),
                                Text('Z: 0.000'),
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
