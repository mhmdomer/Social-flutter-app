import 'package:flutter/material.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/helpers/curved_painter.dart';
import 'package:social/UI/screens/posts.dart';
import 'package:social/UI/screens/register.dart';
import 'package:social/UI/widgets/button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                    SizedBox(
                      height: 150,
                    ),
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
                                hintText: 'Password'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Button(
                            text: 'Login',
                            color: mediumBlue,
                            onPress: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PostsPage()));
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
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Don\'t have an account?'),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
