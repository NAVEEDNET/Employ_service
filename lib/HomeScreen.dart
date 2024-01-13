import 'package:eploy/AddServices.dart';
import 'package:eploy/HomeScreem1.dart';
import 'package:eploy/RateService.dart';
import 'package:eploy/SigninScreen.dart';
import 'package:eploy/signout.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:eploy/Home.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _page = 0;

  final Home _homeScreen =  new Home();
final AddServices _addServices = AddServices();
final RateService _rateservice = new RateService();
final signout _signout = new  signout();

Widget _showpage = new AddServices();

Widget _pagechooser (int page ){
  switch (page){
    case 0:
      return Home();
      break;
    case 1:
      return AddServices();
      break;
    case 2:
      return RateService();
      break;
    case 3:
      return signout();
      break;
    default:
      return new Container(
        child: new Center(
          child: new Text("page not found")
        ),
      );

  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(

        bottomNavigationBar: CurvedNavigationBar(
          index: _page,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.add, size: 30),
            Icon(Icons.reviews, size: 30),
            Icon(Icons.person,size:30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int tappedindex) {
            setState(() {
              _showpage = _pagechooser(tappedindex);
            });
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(

                //Text(_page.toString(), textScaleFactor: 10.0),
                child:_showpage,



          ),
        ));

  }





}



