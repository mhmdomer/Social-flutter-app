import 'package:flutter/material.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/widgets/button.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: TextField(
                        maxLines: 10,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Post body here...'),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          height: 100,
                          width: 100,
                          child: RaisedButton(
                            color: Colors.grey[300],
                            onPressed: () {},
                            child: Center(
                              child: Icon(
                                Icons.image,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Button(text: 'Post', color: mediumBlue, onPress: () {}),
          ],
        ),
      ),
    );
  }
}
