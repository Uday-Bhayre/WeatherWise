import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Service to handle network connectivity checks
class networkService {
  // Variable to store the current connectivity status
  var connectivityResult = ConnectivityResult.none;

  // Method to check the current network connectivity status
  Future<void> checkConnectivity() async {
    ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } catch (e) {
      return; // Handle any exceptions by simply returning
    }
    connectivityResult = result; // Update the connectivity result
  }

  // Method to get the current connectivity status and return a boolean
  Future<bool> getConnectivity() async {
    await checkConnectivity(); // Check the connectivity status
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        return true; // Return true if connected to WiFi or mobile data
      case ConnectivityResult.none:
      default:
        return false; // Return false if not connected
    }
  }

  // Method to show a snackbar notification when there's no internet
  void snackbar() {
    Get.snackbar(
      'No Internet', // Title of the snackbar
      'Check your internet connection', // Message of the snackbar
      icon: const Icon(
        Icons.wifi_off,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
      backgroundColor: Colors.black, // Background color of the snackbar
      colorText: Colors.white, // Text color of the snackbar
    );
  }
}
