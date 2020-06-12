import 'package:flutter/material.dart';
import 'package:social/constants.dart';
import 'package:social/helpers/curved_painter.dart';
import 'package:social/screens/home.dart';
import 'package:social/screens/login.dart';
import 'package:social/widgets/button.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 150,),
                    Row(
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
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                        child: Container(
                      child: Column(
                        children: <Widget>[
                          TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              // email = value.trim();
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Email'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              // email = value.trim();
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Username'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              // email = value.trim();
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Password'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              // email = value.trim();
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Confirm Password'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Button(
                            text: 'Register',
                            color: mediumBlue,
                            onPress: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                            },
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Container(
              child: CustomPaint(
                painter: CurvedPainter(curve: 0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text('Already have an account?'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
