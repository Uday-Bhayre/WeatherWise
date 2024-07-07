import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_wise/src/common_widgets/custom_button.dart';
import 'package:weather_wise/src/controllers/welcome_screen_controller.dart';

// Welcome screen widget
class welcomeScreen extends StatelessWidget {
  const welcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size; // Get screen size
    final welcomeScreenController welcomeController =
        Get.put(welcomeScreenController()); // Initialize controller

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Bg.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Image in the center
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: size.height * 0.4,
              child: Image.asset('assets/getStarted.png'),
            ),
          ),
          // Custom button at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: customButton(
                text: 'Get Started',
                func: welcomeController.goToHomeScreen, // Navigate to home screen on button press
              ),
            ),
          ),
        ],
      ),
    );
  }
}
