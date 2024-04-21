import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import the dart:convert library

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _register(BuildContext context) async {
    // Create a map to represent the request body
    Map<String, dynamic> requestBody = {
      'username': _usernameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    final response = await http.post(
      Uri.parse('https://flutter-backend-jxnp.onrender.com/api/v1/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: json.encode(requestBody), // Encode the request body to JSON format
    );

    if (response.statusCode == 200) {
      // Registration successful, navigate to home screen or login screen
      // You may choose to navigate to the login screen after successful registration
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // Registration failed, handle error
      print('Registration failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyle(color: Colors.white)), // Text color
        backgroundColor: Colors.purple, // App bar color
        iconTheme: IconThemeData(color: Colors.white)
      ),
        
   
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://img.freepik.com/free-vector/taxi-app-concept_23-2148484842.jpg?w=900&t=st=1712305954~exp=1712306554~hmac=53d25be05b858fb4a77682baab0e242b3a2f1a60613ca0c8dea8eb47d53e7680', // Replace with your image URL
                height: 150, // Adjust height as needed
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _register(context),
                child: Text('Sign Up'),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
