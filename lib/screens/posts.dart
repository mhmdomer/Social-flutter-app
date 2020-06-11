import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
          child: Text('move'),
          onPressed: () {
            Navigator.pushNamed(context, '/post', arguments: 'post arguments');
          },
        ),
      ),
    );
  }
}
