import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:weather_wise/src/screens/welcome_screen.dart';

void main() async {
  // Ensure Flutter binding is initialized before any other code executes
  WidgetsFlutterBinding.ensureInitialized();
  
  // Simulate a brief delay (e.g., for splash screen)
  await Future.delayed(const Duration(seconds: 1));
  
  // Remove the splash screen after the delay
  FlutterNativeSplash.remove();
  
  // Run the main app
  runApp(const MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Weather-Wise',
      debugShowCheckedModeBanner: false,  // Disable the debug banner
      home: welcomeScreen(),  // Set the welcome screen as the home page
    );
  }
}
