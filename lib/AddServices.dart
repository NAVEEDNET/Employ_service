import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'HomeScreen.dart';

class AddServices extends StatefulWidget {
  const AddServices({Key? key}) : super(key: key);

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  File? _image;
  final picker = ImagePicker();

  // Define controllers for the text fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _serviceController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _contactNoController = TextEditingController();
  TextEditingController _accountNoController = TextEditingController();
  TextEditingController _locationController =
      TextEditingController(); // Location controller

  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  final _formKey = GlobalKey<FormState>(); // Form key for validation
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackgroundImage(),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _header(context),
                    _inputFields(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return CachedNetworkImage(
      imageUrl:
          "https://img.freepik.com/free-vector/abstract-blue-geometric-shapes-background_1035-17545.jpg?w=2000",
      // Replace with your actual image URL
      placeholder: (context, url) => Container(
        color: Colors.grey[200],
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _header(context) {
    return Column(
      children: const [
        Text(
          "Add services",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("your service info"),
      ],
    );
  }

  Widget _inputFields(context) {
    return Form(
      key: _formKey, // Assign form key
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
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
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _serviceController,
            decoration: InputDecoration(
              hintText: "Service",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.work_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a service';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _priceController,
            decoration: InputDecoration(
              hintText: "Price",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.price_change),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a price';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid price';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _contactNoController,
            decoration: InputDecoration(
              hintText: "Contact No",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.phone_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a contact number';
              }
              if (value.length != 10) {
                return 'Contact number should be 10 digits';
              }
              return null;
            },
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _accountNoController,
            decoration: InputDecoration(
              hintText: "Account No",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.payment_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an account number';
              }
              if (value.length > 12) {
                return 'Account number should be less than 12 digits';
              }
              return null;
            },
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _locationController, // Location field controller
            decoration: InputDecoration(
              hintText: "Location",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.location_on),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a location';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                builder: (BuildContext c) {
                  return SizedBox(
                    height: 140,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Container(
                          width: 60,
                          height: 6,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(
                                3.0),
                            color: Theme.of(context)
                                .brightness ==
                                Brightness.dark
                                ? Colors.grey.shade500
                                : const Color(
                                0xFFE0E0E0),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pop();
                                _pickImage(ImageSource
                                    .camera);
                              },
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    const Icon(Icons
                                        .camera_alt_rounded),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text('Camera',
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                width: 2,
                                height: 60,
                                color: Theme.of(context)
                                    .brightness ==
                                    Brightness
                                        .dark
                                    ? Colors
                                    .grey.shade500
                                    : const Color(
                                    0xFFE0E0E0)),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pop();
                                _pickImage(ImageSource
                                    .gallery);
                              },
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons
                                          .photo_library_rounded,
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text("Gallery",
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.image),
                  const SizedBox(width: 10),
                  Text(
                    _image == null ? "Select Image" : "Image Selected",
                    style: TextStyle(
                      color: _image == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: !_isLoading ? _submitData : null,
            child: Visibility(
              visible: !_isLoading,
              replacement: CircularProgressIndicator(),
              child: const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }

  void _pickImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      // Form validation successful
      // Upload image to Firebase Storage
      setState(() {
        _isLoading = true;
      });
      CollectionReference users =
          FirebaseFirestore.instance.collection('services');
      if (_image != null) {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('services/${DateTime.now()}.jpg');
        UploadTask uploadTask = storageReference.putFile(_image!);
        await uploadTask.whenComplete(() {
          storageReference.getDownloadURL().then((fileURL) {
            // Save data to Firebase Realtime Database
            users.add({
              'name': _nameController.text,
              'service': _serviceController.text,
              'price': double.parse(_priceController.text),
              'contactNo': _contactNoController.text,
              'accountNo': _accountNoController.text,
              'location': _locationController.text,
              'image': fileURL, // Save image URL
            }).then((_) {
              setState(() {
                _isLoading = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            });
          });
        });
      } else {
        // Save data to Firebase Realtime Database without image
        users.add({
          'name': _nameController.text,
          'service': _serviceController.text,
          'price': double.parse(_priceController.text),
          'contactNo': _contactNoController.text,
          'accountNo': _accountNoController.text,
          'location': _locationController.text,
        }).then((_) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        });
      }
    }
  }
}
