import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/helpers/AuthenticationPageMixin.dart';
import 'package:social/UI/helpers/curved_painter.dart';
import 'package:social/UI/helpers/loading_indicator.dart';
import 'package:social/UI/screens/home.dart';
import 'package:social/UI/screens/login.dart';
import 'package:social/UI/widgets/button.dart';
import 'package:social/bloc/register_bloc/register_bloc.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> with AuthenticationPageMixin {
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

  checkPasswords(String value) {
    return passwordConfirmationValidator(value, password.text.trim());
  }  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: Scaffold(
        body: BlocConsumer(
          bloc: bloc,
          listener: (context, state) async {
            if (state is RegisterError) {
              showAlert(state.error, context);
            } else if (state is RegisterSuccess) {
              await setPreferences(state);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HomePage(
                    id: state.user.id,
                    userName: state.user.name,
                    email: state.user.email,
                    imageUrl: state.user.imageUrl,
                  ),
                ),
              );
            }
          },
          buildWhen: (previous, current) => current is! RegisterSuccess,
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is RegisterLoading,
              dismissible: false,
              progressIndicator: getLoadingIndicator(),
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
                                      validator: emailValidator,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        email.text = value;
                                      },
                                      decoration: kTextFieldDecoration.copyWith(
                                          hintText: 'Email'),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      validator: nameValidator,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        name.text = value;
                                      },
                                      decoration: kTextFieldDecoration.copyWith(
                                          hintText: 'Username'),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      validator: passwordValidator,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        password.text = value;
                                      },
                                      decoration: kTextFieldDecoration.copyWith(
                                          hintText: 'Password'),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      validator: (value) => checkPasswords(value),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        passwordConfirmation.text = value;
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
                                          bloc.add(
                                            RegisterSubmitted(
                                                credentials: credentials),
                                          );
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
