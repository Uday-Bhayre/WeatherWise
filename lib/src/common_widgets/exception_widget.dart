import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Widget to display an exception message
class exceptionWidget extends StatelessWidget {
  const exceptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    double height = Get.mediaQuery.size.height;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20), // Horizontal margin
      alignment: Alignment.center, // Center align the content
      height: height * 0.15, // Set the height to 15% of the screen height
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 0), // Black background color
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: const Text(
        'Something went wrong,\n please try again with valid city name..', // Exception message
        textAlign: TextAlign.center, // Center align the text
        style: TextStyle(
          fontSize: 20, // Font size of 20
          color: Color.fromARGB(205, 255, 253, 253), // Light text color
          fontWeight: FontWeight.w300, // Light font weight
        ),
      ),
    );
  }
}
