import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_wise/src/consts.dart';
import 'package:weather_wise/src/utils/network_service.dart';

// Controller for the weather details screen
class weatherDetailsScreenController extends GetxController {
  // Observable variables for loading state and error state
  Rx<bool> isLoading = true.obs;
  Rx<bool> isError = false.obs;

  // WeatherFactory instance for fetching weather data
  WeatherFactory wf = WeatherFactory(OPENWEATHER_API_KEY);

  // Observable variable for storing the weather data
  Rx<Weather?> weather = Rx<Weather?>(null);

  // Observable variables for storing various weather details
  RxString time = ''.obs;
  RxString dateDay = ''.obs;
  RxString city = ''.obs;
  RxString windSpeed = ''.obs;
  RxString temperature = ''.obs;
  RxString humidity = ''.obs;
  RxString weatherCondition = ''.obs;
  RxString weatherDescription = ''.obs;
  Rx<NetworkImage?> weatherConditionIcon = Rx<NetworkImage?>(null);
  RxString tempMax = ''.obs;
  RxString tempMin = ''.obs;
  RxBool isNetConnected = true.obs;

  // Network service for checking connectivity and displaying snackbars
  networkService netService = networkService();

  // Method to fetch weather information for a given city name
  Future<void> getWeatherInfo(String cityName) async {
    isLoading.value = true; // Set loading state to true

    // Check network connectivity
    isNetConnected.value = await netService.getConnectivity();
    if (!isNetConnected.value) {
      netService.snackbar(); // Show snackbar if no connectivity
      await Future.delayed(const Duration(seconds: 1));
      isError.value = true; // Set error state to true
      return;
    }

    try {
      isError.value = false; // Reset error state
      weather.value = await wf.currentWeatherByCityName(cityName); // Fetch weather data

      if (weather.value == null) {
        isError.value = true; // Set error state if no weather data
      } else {
        // Update weather details if data is available
        city.value = weather.value!.areaName!;
        DateTime now = weather.value!.date!;
        time.value = DateFormat("h:mm a").format(now);
        dateDay.value =
            "${DateFormat("d MMM").format(now)}, ${DateFormat("EEEE").format(now)}";
        weatherConditionIcon.value = NetworkImage(
            "http://openweathermap.org/img/wn/${weather.value!.weatherIcon}@4x.png");
        weatherDescription.value = weather.value!.weatherDescription!;
        temperature.value =
            "${weather.value!.temperature!.celsius!.toStringAsFixed(0)}°C";
        windSpeed.value = weather.value!.windSpeed.toString();
        humidity.value = weather.value!.humidity.toString();
        tempMax.value =
            "${weather.value!.tempMax!.celsius!.toStringAsFixed(0)}°C";
        tempMin.value =
            "${weather.value!.tempMin!.celsius!.toStringAsFixed(0)}°C";

        isLoading.value = false; // Set loading state to false
        isError.value = false; // Reset error state
      }
    } catch (error) {
      await Future.delayed(const Duration(seconds: 1));
      isError.value = true; // Set error state in case of an exception
    }
  }
}
