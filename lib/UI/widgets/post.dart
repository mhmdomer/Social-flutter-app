import 'package:flutter/material.dart';
import 'package:social/UI/constants.dart';
import 'package:social/data/models/post.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostItem extends StatelessWidget {
  PostItem({@required this.post, @required this.clickable})
      : assert(post != null && clickable != null);
  final bool clickable;
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    void _onPressed() {
      Navigator.pushNamed(context, '/post', arguments: post);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile', arguments: 1);
                  },
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        backgroundImage: post.user['image'] == null
                            ? AssetImage('assets/avatar1.jpg')
                            : CachedNetworkImage(imageUrl: post.user['image']),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(post.user['name'], style: TextStyle(fontSize: 17)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 5),
                  child: Text('4 minutes ago', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: InkWell(
                onTap: clickable ? _onPressed : null,
                child: Text(
                  post.body ?? '',
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
            ),
            post.imageUrl != null
                ? InkWell(
                    onTap: () => Navigator.pushNamed(context, '/photo',
                        arguments: post.imageUrl),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: CachedNetworkImage(
                        imageUrl: post.imageUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) {
                          return Container(
                            height: 300,
                            width: double.infinity,
                            child: Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.thumb_up,
                        color: post.isFavorited ? cornflowerBlue : Colors.grey,
                      ),
                      onPressed: () {}),
                  IconButton(
                    icon: Icon(
                      Icons.mode_comment,
                      color: Colors.grey,
                    ),
                    onPressed: () => clickable ? _onPressed : null,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    '${post.favoriteCount} Likes',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                    ),
                  ),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  FlatButton(
                    onPressed: clickable ? _onPressed : null,
                    child: Text(
                      '${post.commentCount} comments',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
