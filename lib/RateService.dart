import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'HomeScreen.dart';

class RateService extends StatefulWidget {
  const RateService({Key? key}) : super(key: key);

  @override
  State<RateService> createState() => _RateServiceState();
}

class _RateServiceState extends State<RateService> {
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.reference();

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://img.freepik.com/free-vector/abstract-blue-geometric-shapes-background_1035-17545.jpg?w=2000',
              ), // Replace with your image URL
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _header(),
                const SizedBox(height: 40),
                _ratingStars(),
                const SizedBox(height: 20),
                _submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        Text(
          "Rate the App",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "Rate our best services",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _ratingStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, size: 40, color: Colors.yellow),
        Icon(Icons.star, size: 40, color: Colors.yellow),
        Icon(Icons.star, size: 40, color: Colors.yellow),
        Icon(Icons.star, size: 40, color: Colors.yellow),
        Icon(Icons.star, size: 40, color: Colors.yellow),
      ],
    );
  }

  void insertData(int rating) {
    final data = {
      'rating': rating,
    };

    _databaseReference.child('ratings').push().set(data);
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        // Rating value can be obtained from your rating stars widget
        int rating = 5; // Example value, replace it with the actual rating value

        insertData(rating);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
      child: Text(
        "Submit",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
