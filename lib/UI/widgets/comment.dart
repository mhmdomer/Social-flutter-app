import 'package:flutter/material.dart';
import 'package:social/bloc/like_bloc/like_bloc.dart';
import 'package:social/data/models/comment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Comment extends StatelessWidget {
  Comment({this.comment});
  final CommentModel comment;
  var bloc = LikeBloc();
  bool isFavorited;
  int likeMargin = 0;

  @override
  Widget build(BuildContext context) {
    if (isFavorited == null) {
      isFavorited = comment.isFavorited;
    }
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile',
                  arguments: comment.user['id']);
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: comment.user['image'] == null
                  ? AssetImage('assets/avatar1.jpg')
                  : NetworkImage(comment.user['image']),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: '${comment.user['name']} :  ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: comment.body,
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<LikeBloc, LikeState>(
                    bloc: bloc,
                    listener: (context, state) {
                      if (state is LikeSuccess) {
                        isFavorited = state.liked;
                        likeMargin += state.liked ? 1 : -1;
                      }
                    },
                    builder: (context, state) {
                      return Row(
                        children: [
                          IconButton(
                            splashRadius: 1.0,
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.thumb_up,
                              color: isFavorited ? Colors.blue : Colors.grey,
                            ),
                            onPressed: state is LikeLoading
                                ? null
                                : () {
                                    bloc.add(
                                      isFavorited
                                          ? SubmitDislike(
                                              type: Type.comment,
                                              id: comment.id)
                                          : SubmitLike(
                                              type: Type.comment,
                                              id: comment.id),
                                    );
                                  },
                            iconSize: 18,
                          ),
                          Text(
                            "${comment.favoriteCount + likeMargin}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      );
                    },
                  ),
                  Container(
                    child: Text(
                      comment.createAt,
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
