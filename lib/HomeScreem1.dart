import 'package:eploy/Information.dart';
import 'package:flutter/material.dart';
class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            margin: const EdgeInsets.all(24),
            child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _header(context),
              _inputFields(context),

            ]),
          ),
        ));
  }
  _header(context) {
    return Column(
      children: const [
        Text(
          "Employee services",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Get your Employee"),
      ],
    );
  }


}_inputFields(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [

      ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Information()));
        },

        child: const Text(
          "Hire",
          style: TextStyle(fontSize: 20),

        ),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16),

        ),
      )

    ],
  );
}
