import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Widget to display an information card with a title, image, and value
class InfoCard extends StatelessWidget {
  // Constructor with required parameters for card title, image, and value
  const InfoCard({
    super.key,
    required this.cardTitle,
    required this.image,
    required this.value,
  });

  // Title to be displayed on the card
  final String cardTitle;

  // Image to be displayed on the card
  final String image;

  // Value to be displayed on the card
  final String value;

  @override
  Widget build(BuildContext context) {
    // Get the height and width of the screen
    double height = Get.mediaQuery.size.height;
    double width = Get.mediaQuery.size.width;

    return Container(
      padding: const EdgeInsets.all(2), // Padding inside the container
      height: height * 0.184, // Set the height to 18.4% of the screen height
      width: width * 0.3, // Set the width to 30% of the screen width
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 101, 170, 205), // Background color
        borderRadius: BorderRadius.all(Radius.circular(10)), // Rounded corners
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center align the children
        children: [
          // Display the card title
          Text(
            cardTitle,
            style: TextStyle(
              fontSize: 0.02 * height, // Font size relative to screen height
            ),
          ),
          const Divider(
            thickness: 2.4, // Thickness of the divider
          ),
          // Display the image
          Image(
            image: AssetImage(image),
            height: height * 0.08, // Image height relative to screen height
          ),
          SizedBox(
            height: height * 0.0015, // Spacer height relative to screen height
          ),
          // Display the value
          Text(
            value,
            style: TextStyle(
              fontSize: 0.024 * height, // Font size relative to screen height
              fontWeight: FontWeight.bold, // Bold font weight
            ),
          ),
        ],
      ),
    );
  }
}
