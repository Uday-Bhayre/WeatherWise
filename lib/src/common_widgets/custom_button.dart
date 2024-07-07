import 'package:flutter/material.dart';

// Custom button widget extending StatelessWidget
class customButton extends StatelessWidget {
  // Constructor with required text and function parameters
  const customButton({
    super.key,
    required this.text,
    required this.func,
  });

  // Text to be displayed on the button
  final String text;

  // Function to be executed when the button is pressed
  final void Function() func;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), // Rounded corners
      label: SizedBox(
        child: Text(
          text, // Display the text on the button
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'openSans',
            color: Color.fromARGB(255, 255, 255, 255), // White text color
            fontSize: 18, // Font size of 18
            fontWeight: FontWeight.w500, // Medium font weight
          ),
        ),
      ),
      backgroundColor: Colors.black, // Black background color
      onPressed: func, // Execute the passed function when pressed
    );
  }
}
