import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final String token; // Assuming you pass the JWT token from the login screen

  ProfileScreen({required this.token});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _userId;
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
  final response = await http.get(
    Uri.parse('https://flutter-backend-jxnp.onrender.com/api/v1/user/profile'),
    headers: {'Authorization': 'Bearer ${widget.token}'},
  );

  if (response.statusCode == 200) {
    // Successfully fetched user profile
    final userProfile = json.decode(response.body);
    setState(() {
      _userId = userProfile['id'];
    });
  } else {
    // Failed to fetch user profile, handle error
    print('Failed to fetch user profile: ${response.body}');
  }
}

  Future<void> _updatePassword(BuildContext context) async {
    final response = await http.put(
      Uri.parse('https://flutter-backend-jxnp.onrender.com/api/v1/user/updateuser/$_userId/password'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
      body: {
        'password': _passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Password update successful
      Navigator.pop(context); // Close the profile screen
    } else {
      // Password update failed, handle error
      print('Failed to update password: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your new password',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _updatePassword(context),
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
