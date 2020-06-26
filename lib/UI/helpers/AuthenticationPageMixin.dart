import 'package:flutter/material.dart';
import 'package:social/bloc/login_bloc/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:social/bloc/register_bloc/register_bloc.dart';

mixin AuthenticationPageMixin {
  final formKey = GlobalKey<FormState>();


  String emailValidator(value) {
    if (RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(
      value.trim(),
    )) return null;
    return 'email not valid';
  }

  String passwordValidator(String value) {
    if (value.trim().length < 6) {
      return 'password must be at least 6 characters';
    }
    return null;
  }

  String nameValidator(String value) {
    if (value.trim().length < 4) {
      return 'length must be at least 4';
    }
    if (RegExp(r"^[A-Za-z][A-Za-z0-9]{4,31}$").hasMatch(value.trim())) {
      return null;
    }
    return 'name not valid (only characters and numbers are allowed)';
  }

  String passwordConfirmationValidator(String value, String original) {
    if (value.trim() != original) {
      return 'passwords does not match!';
    }
    return null;
  }

  showAlert(error, context) {
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

  Future setPreferences(state) async {
    if(state is LoginSuccess || state is RegisterSuccess) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('id', state.user.id);
      prefs.setString('name', state.user.name);
      prefs.setString('email', state.user.email);
      prefs.setString('imageUrl', state.user.imageUrl);
    }
  }

}