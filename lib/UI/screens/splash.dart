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
    await Future.delayed(Duration(seconds: 1));
    if (token == null || token == '') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Welcome()));
    } else {
      final id = preferences.getInt('id');
      final name = preferences.getString('name');
      final email = preferences.getString('email');
      final imageUrl = preferences.getString('imageUrl');
      print('navigating');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(
            id: id,
            userName: name,
            email: email,
            imageUrl: imageUrl,
          ),
        ),
      );
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
