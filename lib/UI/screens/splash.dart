import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social/UI/screens/home.dart';
import 'package:social/UI/screens/welcome.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  checkToken() async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    await Future.delayed(Duration(seconds: 2));
    if(token == null || token == '') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Welcome()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/app_store.png'),
          radius: 30,
        ),
      ),
    );
  }
}