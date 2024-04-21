import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? selectedCar; // To store the selected car

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Car'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a Car:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedCar,
              onChanged: (newValue) {
                setState(() {
                  selectedCar = newValue!;
                });
              },
              items: <String?>[
                null,
                'Car 1',
                'Car 2',
                'Car 3',
                'Car 4',
                'Car 5'
              ].map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value ?? 'Select a car'),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _confirmBooking(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Confirm Booking',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmBooking(BuildContext context) {
    if (selectedCar != null) {
      // If a car is selected, show a dialog confirming the booking
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Booking Confirmation'),
            content: Text('You have successfully booked $selectedCar.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Pop the dialog and the booking screen
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // If no car is selected, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a car.'),
        ),
      );
    }
  }
}