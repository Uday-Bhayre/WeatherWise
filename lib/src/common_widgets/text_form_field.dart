import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_wise/src/controllers/home_screen_controller.dart';

// Custom text form field widget
class textFormField extends StatelessWidget {
  // Constructor with required hint text, prefix icon, and controller parameters
  const textFormField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    required this.homecontroller,
  });

  // Controller to manage the text field's state
  final homeScreenController homecontroller;

  // Hint text for the text field
  final String hint;

  // Icon to be displayed at the beginning of the text field
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    double height = Get.mediaQuery.size.height;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5), // Vertical padding
      alignment: Alignment.center, // Center align the content
      height: height * 0.08, // Set the height to 8% of the screen height
      child: TextFormField(
        style: const TextStyle(color: Colors.white), // Text style
        cursorHeight: height * 0.03, // Cursor height relative to screen height
        cursorColor: const Color.fromARGB(255, 198, 194, 194), // Cursor color
        controller: homecontroller.controller, // Text field controller
        keyboardType: TextInputType.emailAddress, // Keyboard type
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontSize: height * 0.02, // Font size relative to screen height
            color: const Color.fromARGB(255, 206, 203, 203), // Label text color
          ),
          labelText: hint, // Hint text
          floatingLabelAlignment: FloatingLabelAlignment.center, // Center align the floating label
          prefixIcon: Icon(
            prefixIcon,
            color: const Color.fromARGB(255, 255, 255, 255), // Prefix icon color
          ),
          contentPadding: const EdgeInsets.only(bottom: 50), // Content padding
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(height * 0.02), // Border radius relative to screen height
            ),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 149, 148, 148), // Border color when enabled
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(height * 0.02), // Border radius relative to screen height
            ),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 255, 255), // Border color when focused
            ),
          ),
        ),
        onChanged: homecontroller.updateSearchText, // Update search text on change
        onFieldSubmitted: homecontroller.addSearch, // Add search on field submission
      ),
    );
  }
}
