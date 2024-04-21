import 'package:flutter/material.dart';
import 'package:car_sharing_app/screens/booking_screen.dart';
import 'package:car_sharing_app/screens/home_screen.dart';
import 'package:car_sharing_app/screens/login_screen.dart';
import 'package:car_sharing_app/screens/profile_screen.dart';
import 'package:car_sharing_app/screens/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Sharing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Set initial route to login screen
      routes: {
        '/signup': (context) => SignupScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/book-car': (context) => BookingScreen(),
        '/profile': (context) => ProfileScreen(token: '',), // Provide the user's ID here
      },
    );
  }
}
