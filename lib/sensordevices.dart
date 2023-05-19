import 'package:flutter/material.dart';
import 'package:login/earphone.dart';
import 'package:login/smartwatch.dart';
import 'package:login/smartphone.dart';
import 'package:login/arduino.dart';

class SensorDevices extends StatelessWidget {
  const SensorDevices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset(
            'assets/user.png',
            width: 32,
            height: 29,
          ),
        ),
        title: Text(
          'Username',
          style: TextStyle(
            fontFamily: 'Iceberg',
            fontSize: 16,
            color: Color(0xFF156EB7),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Which device are you using?',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF156EB7),
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ImageButton(
                    image: AssetImage('assets/earphone.png'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EarphoneScreen(),
                        ),
                      );
                    },
                  ),
                  ImageButton(
                    image: AssetImage('assets/smartwatch.png'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SmartwatchScreen(),
                        ),
                      );
                    },
                  ),
                  ImageButton(
                    image: AssetImage('assets/smartphone.png'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SmartphoneScreen(),
                        ),
                      );
                    },
                  ),
                  ImageButton(
                    image: AssetImage('assets/camera.png'),
                    onPressed: () {},
                  ),
                  ImageButton(
                    image: AssetImage('assets/laptop.png'),
                    onPressed: () {},
                  ),
                  ImageButton(
                    image: AssetImage('assets/arduino.png'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArduinoScreen(),
                        ),
                      );
                    },
                  ),
                  ImageButton(
                    image: AssetImage('assets/plus.png'),
                    onPressed: () {},
                  ),
                  ImageButton(
                    image: AssetImage('assets/plus.png'),
                    onPressed: () {},
                  ),
                  ImageButton(
                    image: AssetImage('assets/plus.png'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Image.asset(
                'assets/BACKGROUND.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  final ImageProvider<Object> image;
  final VoidCallback onPressed;

  const ImageButton({
    required this.image,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        primary: null,
      ),
      child: Ink.image(
        image: image,
        fit: BoxFit.cover,
        child: InkWell(
          onTap: onPressed,
        ),
      ),
    );
  }
}
