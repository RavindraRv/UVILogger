import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _typingAnimation;
  late String _welcomeText = '';

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Define fade-in animation for the image
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    // Define typing animation for the text
    _typingAnimation = Tween<double>(begin: 0, end: 32).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Start animation
    _animationController.forward();

    // Navigate to login screen after the animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, 'login'); // Replace with your login screen route
      }
    });

    // Start the typing animation for the text
    _startTypingAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startTypingAnimation() async {
    const text = 'Welcome to UbiSys SaaS Platform';
    for (int i = 0; i < text.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _welcomeText = text.substring(0, i + 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo or background image
            FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                'assets/BACKGROUND.jpg', // Replace with your image asset path
                width: 300,
                height: 300,
              ),
            ),
            SizedBox(height: 20),
            // Beautiful text font with typing animation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: FadeTransition(
                opacity: _typingAnimation,
                child: Text(
                  _welcomeText,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF156EB7),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
