import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  // List of car image URLs
  final List<String> carImages = [
    'https://img.freepik.com/free-vector/modern-urban-adventure-suv-vehicle-illustration_1344-200.jpg?w=740',
    'https://img.freepik.com/free-vector/red-sedan-car-isolated-white-vector_53876-64366.jpg?w=826',
    'https://img.freepik.com/free-vector/hand-drawn-muscle-car-illustration_23-2149432254.jpg?w=900',
    'https://img.freepik.com/free-vector/blue-sports-car-isolated-white-vector_53876-67354.jpg?w=826',
    'https://img.freepik.com/free-vector/blue-car_23-2147517001.jpg?w=740',
  ];

  // List of car names
  final List<String> carNames = [
    'SUV',
    'Sedan',
    'Muscle Car',
    'Sports Car',
    'Alto',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Sharing App', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194), // San Francisco coordinates
                zoom: 12.0,
              ),
              markers: Set.from([
                Marker(
                  markerId: MarkerId('marker_1'),
                  position: LatLng(37.7749, -122.4194),
                  infoWindow: InfoWindow(title: 'San Francisco'),
                ),
              ]),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Available Cars',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: carImages.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      carImages[index],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(carNames[index]),
                    subtitle: Text('Description of ${carNames[index]}'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Replace with logic to navigate to car details screen
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _bookCar(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Book a Car',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showAddCarDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Add Car',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _bookCar(BuildContext context) {
    Navigator.pushNamed(context, '/book-car');
  }

  Future<void> _showAddCarDialog(BuildContext context) async {
    Map<String, dynamic> carDetails = {
      'brand': '',
      'model': '',
      'year': '',
      'price': '',
      'image': '',
      'description': '',
      'owner': '', // You need to set the owner ID here
      'isSold': false,
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Car'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Brand'),
                  onChanged: (value) => carDetails['brand'] = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Model'),
                  onChanged: (value) => carDetails['model'] = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Year'),
                  onChanged: (value) {
                    try {
                      carDetails['year'] = int.parse(value);
                    } catch (e) {
                      print('Error parsing year: $e');
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Price'),
                  onChanged: (value) {
                    try {
                      carDetails['price'] = double.parse(value);
                    } catch (e) {
                      print('Error parsing price: $e');
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Image URL'),
                  onChanged: (value) => carDetails['image'] = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Description'),
                  onChanged: (value) => carDetails['description'] = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _addCar(context, carDetails);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addCar(BuildContext context, Map<String, dynamic> carDetails) async {
    final response = await http.post(
      Uri.parse('https://flutter-backend-jxnp.onrender.com/api/v1/car/add-car'),
      body: carDetails,
    );

    if (response.statusCode == 200) {
      // Car added successfully
      // You can add your logic here, such as showing a success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Car added successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Error adding car
      // You can handle the error here, such as showing an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add car. Error: ${response.body}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
