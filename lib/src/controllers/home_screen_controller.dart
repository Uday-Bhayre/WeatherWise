import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_wise/src/screens/weather_details_screen.dart';
import 'package:weather_wise/src/utils/network_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Controller for the home screen
class homeScreenController extends GetxController {
  // Controller for the search text field
  TextEditingController controller = TextEditingController();

  // Network service for checking connectivity and displaying snackbars
  networkService netService = networkService();

  // Observable variables for loading state and network connectivity status
  RxBool isLoading = false.obs;
  Rx<bool> isNetConnected = true.obs;

  // Observable lists for recent searches and search results
  var recentSearches = <String>[].obs;
  var searchResults = <String>[].obs;

  // Observable variable for the current search text
  final searchText = ''.obs;

  // Load recent searches from shared preferences
  void loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var searches = prefs.getStringList('recentSearches') ?? [];
    recentSearches.assignAll(searches);
  }

  // Add a search query to the recent searches list and save to shared preferences
  void addSearch(String query) async {
    if (query.isNotEmpty && !recentSearches.contains(query)) {
      recentSearches.add(query);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('recentSearches', recentSearches);
    }
  }

  // Update the search text and filter search results based on the text
  void updateSearchText(String text) {
    searchText.value = text;
    searchResults.assignAll(
      recentSearches.where((city) => city.toLowerCase().contains(text.toLowerCase())),
    );
  }

  // Search for weather information for the entered city
  void searchWeather() async {
    isLoading.value = true;
    String city = controller.text;

    if (city.trim().isEmpty) {
      return;
    }

    // Check network connectivity
    isNetConnected.value = await netService.getConnectivity();

    if (!isNetConnected.value) {
      netService.snackbar();
      return;
    }

    // Add city to recent searches if not already present
    if (city.isNotEmpty && !recentSearches.contains(city)) {
      recentSearches.add(city);
    }

    // Navigate to the weather details screen for the entered city
    Get.to(weatherDetailsScreen(cityName: city));
    isLoading.value = false;
  }

  // Load recent searches when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    loadRecentSearches();
  }
}
