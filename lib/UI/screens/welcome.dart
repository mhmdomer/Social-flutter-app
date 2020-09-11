import 'package:flutter/material.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/helpers/curved_painter.dart';
import 'package:social/UI/screens/login.dart';
import 'package:social/UI/screens/register.dart';
import 'package:social/UI/widgets/button.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/app_store.png'),
                    radius: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Social',
                    style: TextStyle(fontSize: 40, fontFamily: 'Mont'),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: CustomPaint(
                painter: CurvedPainter(curve: 0.1),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Button(
                          color: mediumBlue,
                          text: 'Register',
                          onPress: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      Button(
                        color: mediumBlue,
                        text: 'Loin',
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
