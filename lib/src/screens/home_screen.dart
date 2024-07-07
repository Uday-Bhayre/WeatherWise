import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_wise/src/common_widgets/custom_button.dart';
import 'package:weather_wise/src/common_widgets/text_form_field.dart';
import 'package:weather_wise/src/controllers/home_screen_controller.dart';

// Home screen widget
class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the home screen controller
    final homeScreenController homescreencontroller = Get.put(homeScreenController());

    // Get the height of the screen
    double height = Get.mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey, // Set the AppBar background color
        title: const Text("WeatherWise"), // Set the title of the AppBar
        centerTitle: true, // Center the title
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Bg.jpg'), // Background image
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(10), // Padding around the container
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the column contents
              children: [
                // Custom text form field for city name input
                textFormField(
                  hint: 'Enter city name',
                  prefixIcon: Icons.location_on,
                  homecontroller: homescreencontroller,
                ),
                // Observe changes in search text and recent searches
                Obx(() {
                  var results = homescreencontroller.searchText.isEmpty
                      ? homescreencontroller.recentSearches.reversed.toList()
                      : homescreencontroller.searchResults.reversed.toList();
                  return Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(99, 0, 0, 0), // Semi-transparent background color
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: results.length, // Number of items in the list
                        itemBuilder: (context, index) {
                          return Container(
                            child: ListTile(
                              dense: true, // Reduce the height of the ListTile
                              contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                              title: Container(
                                padding: const EdgeInsets.all(0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.history, // History icon
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 10), // Space between icon and text
                                    Text(
                                      results[index], // Display the search result
                                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              // Set the text field and update search text on tap
                              onTap: () {
                                homescreencontroller.controller.text = results[index];
                                homescreencontroller.updateSearchText(results[index]);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
                SizedBox(height: height * 0.03), // Space between the ListView and button
                // Custom button for initiating the weather search
                customButton(
                  text: 'Search',
                  func: homescreencontroller.searchWeather,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
