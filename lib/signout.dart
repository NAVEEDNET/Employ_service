import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eploy/SigninScreen.dart';
import 'package:flutter/rendering.dart';

class signout extends StatefulWidget {
  const signout({Key? key}) : super(key: key);

  @override
  State<signout> createState() => _signoutState();
}

class _signoutState extends State<signout> {
  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SigninScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://img.freepik.com/free-vector/abstract-blue-geometric-shapes-background_1035-17545.jpg?w=2000', // Replace with your image URL
              ),
              fit: BoxFit.cover,
            ),
          ),
          margin: const EdgeInsets.all(5),
          child: _inputFields(context),
        ),
      ),
    );
  }

  _inputFields(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          // SizedBox(height: 10.0),
          const Text(
            'Current User',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: RenderErrorBox.minimumWidth,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(5.8),
            ),
            padding: EdgeInsets.all(16.10),
            child: Text(
              FirebaseAuth.instance.currentUser?.email ?? '',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          SizedBox(height: 55,),
          ElevatedButton(
            onPressed: signOut,
            child: const Text(
              "Sign out",
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
}
