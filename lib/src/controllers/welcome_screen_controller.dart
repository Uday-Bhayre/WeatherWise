import 'package:get/get.dart';
import 'package:weather_wise/src/screens/home_screen.dart';

// Controller for the welcome screen
class welcomeScreenController extends GetxController {
  // Method to navigate to the home screen
  void goToHomeScreen() {
    Get.to(() => homeScreen());
  }
}
