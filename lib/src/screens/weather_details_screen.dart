import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_wise/src/common_widgets/exception_widget.dart';
import 'package:weather_wise/src/common_widgets/info_card.dart';
import 'package:weather_wise/src/controllers/weather_details_screen_controller.dart';

// Weather details screen widget
class weatherDetailsScreen extends StatelessWidget {
  const weatherDetailsScreen({
    super.key,
    required this.cityName,
  });

  final String cityName;

  @override
  Widget build(BuildContext context) {
    // Initialize weather details screen controller
    weatherDetailsScreenController weatherController =
        Get.put(weatherDetailsScreenController());

    // Fetch weather information for the given city
    weatherController.getWeatherInfo(cityName);

    // Get screen dimensions
    double height = Get.mediaQuery.size.height;
    double width = Get.mediaQuery.size.width;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("WeatherWise"), // App bar title
          centerTitle: true, // Center align the title
          backgroundColor: Colors.blueGrey, // App bar background color
          actions: [
            // Refresh button to fetch weather data again
            IconButton(
              onPressed: () {
                weatherController.getWeatherInfo(cityName);
              },
              icon: const Icon(Icons.refresh), // Refresh icon
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Bg.jpg'), // Background image
              fit: BoxFit.cover,
            ),
          ),
          child: weatherController.isLoading.value
              ? Center(
                  child: weatherController.isError.value
                      ? const exceptionWidget() // Show error widget if error occurs
                      : const CircularProgressIndicator(), // Show loading indicator
                )
              : Padding(
                  padding: EdgeInsets.all(height * 0.0133), // Padding around the content
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.01), // Vertical space
                        // City name and location icon
                        Row(
                          children: [
                            Text(
                              weatherController.city.value,
                              style: TextStyle(
                                fontSize: height * 0.035,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 5), // Space between text and icon
                            Image(
                              image: const AssetImage('assets/location.png'),
                              height: height * 0.035,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01), // Vertical space
                        // Current time
                        Text(
                          weatherController.time.value,
                          style: TextStyle(
                            fontSize: height * 0.0215,
                            color: const Color.fromARGB(255, 218, 217, 217),
                          ),
                        ),
                        // Date and day
                        Text(
                          weatherController.dateDay.value,
                          style: TextStyle(
                            fontSize: height * 0.0215,
                            color: const Color.fromARGB(255, 218, 217, 217),
                          ),
                        ),
                        SizedBox(height: height * 0.044), // Vertical space
                        // Weather condition card
                        Container(
                          width: width,
                          height: height * 0.27,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.center,
                              colors: [
                                Color(0xffa9c1f5),
                                Color(0xff6696f5),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 78, 150, 201)
                                    .withOpacity(.5),
                                offset: const Offset(0, 25),
                                blurRadius: 10,
                                spreadRadius: -12,
                              ),
                            ],
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // Weather condition icon
                              Positioned(
                                top: height * (-0.053),
                                left: 0,
                                child: Image(
                                  height: height * 0.25,
                                  image: weatherController.weatherConditionIcon.value!,
                                ),
                              ),
                              // Weather description text
                              Positioned(
                                bottom: height * 0.02,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        weatherController.weatherDescription.value,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 223, 223, 223),
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Temperature text
                              Positioned(
                                top: height * 0.04,
                                right: width * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    weatherController.temperature.toString(),
                                    style: TextStyle(
                                      fontSize: height * 0.07,
                                      color: const Color.fromARGB(162, 255, 255, 255),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.053), // Vertical space
                        // Info cards for wind speed and humidity
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InfoCard(
                              cardTitle: 'Wind Speed',
                              image: 'assets/windspeed.png',
                              value: '${weatherController.windSpeed.value}km/h',
                            ),
                            InfoCard(
                              cardTitle: 'Humidity',
                              image: 'assets/humidity.png',
                              value: '${weatherController.humidity.value}%',
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.027), // Vertical space
                        // Info cards for max and min temperatures
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InfoCard(
                              cardTitle: 'Max Temp',
                              image: 'assets/max-temp.png',
                              value: weatherController.tempMax.value,
                            ),
                            InfoCard(
                              cardTitle: 'Min Temp',
                              image: 'assets/min-temp.png',
                              value: weatherController.tempMin.value,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
