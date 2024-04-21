import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final response = await http.post(
      Uri.parse('https://flutter-backend-jxnp.onrender.com/api/v1/user/login'),
      body: {
        'email': _emailController.text,
        'password': _passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Successfully logged in, navigate to home screen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Login failed, handle error
      print('Login failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)), // Text color
        backgroundColor: Colors.purple, // App bar color
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
                onPressed: () => _login(context),
                child: Text('Login'),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
