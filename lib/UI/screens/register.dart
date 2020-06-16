import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/helpers/curved_painter.dart';
import 'package:social/UI/screens/home.dart';
import 'package:social/UI/screens/login.dart';
import 'package:social/UI/widgets/button.dart';
import 'package:social/bloc/register_bloc/register_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  RegisterBloc bloc;
  TextEditingController email, name, password, passwordConfirmation;
  @override
  initState() {
    super.initState();
    bloc = RegisterBloc();
    email = TextEditingController();
    name = TextEditingController();
    password = TextEditingController();
    passwordConfirmation = TextEditingController();
  }

  String _emailValidator(value) {
    if (RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(
      value.trim(),
    )) return null;
    return 'email not valid';
  }

  String _nameValidator(String value) {
    if(value.trim().length < 4) {
      return 'length must be at least 4';
    }
    if(RegExp(r"^[A-Za-z][A-Za-z0-9]{4,31}$").hasMatch(value.trim())) {
      return null;
    }
    return 'name not valid (only characters and numbers are allowed)';
  }

  String _passwordValidator(String value) {
    if(value.trim().length < 6) {
      return 'password must be at least 6 characters';
    }
    return null;
  }

  String _passwordConfirmationValidator(String value) {
    if(value.trim() != password.text.trim()) {
      return 'passwords does not match!';
    }
    return null;
  }

  showAlert(error) {
    Alert(
      closeFunction: () {},
      context: context,
      type: AlertType.error,
      title: "Error!",
      desc: "$error.",
      buttons: [
        DialogButton(
          child: Text(
            "Retry",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: Scaffold(
        body: BlocConsumer(
          bloc: bloc,
          listener: (context, state) {
            if(state is RegisterError) {
              showAlert(state.error);
            } else if(state is RegisterSuccess) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
            }
          },
          buildWhen: (previous, current) => current is! RegisterSuccess,
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is RegisterLoading,
              dismissible: false,
              progressIndicator: SpinKitCubeGrid(color: mediumBlue),
              child: Container(
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
                                  style: TextStyle(
                                      fontSize: 40, fontFamily: 'Mont'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: _formKey,
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      validator: _emailValidator,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        setState(() {
                                          email.text = value;
                                        });
                                      },
                                      decoration: kTextFieldDecoration.copyWith(
                                          hintText: 'Email'),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      validator: _nameValidator,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        setState(() {
                                          name.text = value;
                                        });
                                      },
                                      decoration: kTextFieldDecoration.copyWith(
                                          hintText: 'Username'),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      validator: _passwordValidator,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        setState(() {
                                          password.text = value;
                                        });
                                      },
                                      decoration: kTextFieldDecoration.copyWith(
                                          hintText: 'Password'),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      validator: _passwordConfirmationValidator,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        setState(() {
                                          passwordConfirmation.text = value;
                                        });
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
                                        if (_formKey.currentState.validate()) {
                                          final credentials = {
                                            'email': email.text.trim(),
                                            'name': name.text.trim(),
                                            'password': password.text.trim()
                                          };
                                          bloc.add(RegisterSubmitted(
                                              credentials: credentials));
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
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
          },
        ),
      ),
    );
  }
}
