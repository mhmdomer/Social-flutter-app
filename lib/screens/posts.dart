import 'package:flutter/material.dart';
import 'package:social/widgets/post.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/post'),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, top: 15),
        child: ListView(
          children: <Widget>[
            PostItem(post: {'name' : 'post1', 'image' : 'post1.jpg', 'body' : 'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set'},),
            PostItem(post: {'name' : 'post2', 'image' : 'post2.jpg', 'body' : 'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set'},),
            PostItem(post: {'name' : 'post3', 'image' : 'post3.jpg', 'body' : 'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set'},),
            PostItem(post: {'name' : 'post4', 'image' : 'post4.jpg', 'body' : 'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set'},),
          ],
        ),
      ),
    );
  }
}
