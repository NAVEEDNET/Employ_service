import 'package:cached_network_image/cached_network_image.dart';
import 'package:eploy/HomeScreen.dart';
import 'package:eploy/payment.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'HomeScreem1.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.reference().child('Information');
  }

  Widget buildPaymentWidget() {
    return Payment();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: "https://img.freepik.com/free-vector/abstract-blue-geometric-shapes-background_1035-17545.jpg?w=2000",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _header(context),
                    _inputFields(context),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => buildPaymentWidget()),
                          );
                        }
                      },
                      child: const Text(
                        "Proceed to Payment",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: const [
        Text(
          "Details",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your details"),
      ],
    );
  }

  _inputFields(context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Name",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email id",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              if (!_isValidEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              hintText: "Address",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.home_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
            obscureText: false,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: dateController,
            decoration: InputDecoration(
              hintText: "Date (dd/mm)",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.date_range_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the date';
              }
              if (!_isValidDate(value)) {
                return 'Please enter a valid date in the format dd/mm';
              }
              return null;
            },
            obscureText: false,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: phoneNumberController,
            decoration: InputDecoration(
              hintText: "Phone Number",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.phone_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your phone number';
              }
              if (!_isValidPhoneNumber(value)) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
            obscureText: false,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Get the values from the text controllers
                String Name = nameController.text;
                String Email = emailController.text;
                String Address = addressController.text;
                String Date = dateController.text;
                String PhoneNumber = phoneNumberController.text;

                // Create a new entry in the "Information" node with a unique key
                DatabaseReference newCustomerRef = dbRef.push();

                // Set the values for the new entry
                newCustomerRef.set({
                  'name': Name,
                  'email': Email,
                  'address': Address,
                  'date': Date,
                  'phone number': PhoneNumber,
                }).then((_) {
                  // Data successfully inserted
                  // Navigate to the sign-in screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }).catchError((error) {
                  // Error occurred while inserting data
                  // Handle the error here
                  print('Error inserting data: $error');
                });
              }
            },
            child: const Text(
              "Submit",
              style: TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Use a regular expression to validate the email format
    final emailRegex =
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    return RegExp(emailRegex).hasMatch(email);
  }

  bool _isValidDate(String date) {
    // Use a regular expression to validate the date format
    final dateRegex = r'^\d{2}/\d{2}$';
    return RegExp(dateRegex).hasMatch(date);
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters from the phone number
    String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Check if the phone number has at least 10 digits
    if (digitsOnly.length >= 10) {
      return true;
    } else {
      return false;
    }
  }
}
