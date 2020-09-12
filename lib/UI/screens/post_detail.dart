import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/helpers/scrollable_list_mixin.dart';
import 'package:social/UI/helpers/showList.dart';
import 'package:social/UI/widgets/post.dart';
import 'package:social/bloc/scrollable_list_bloc/scrollable_list_bloc.dart';
import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/api_providers/base_list_provider.dart';
import 'package:social/data/models/comment.dart';
import 'package:social/data/models/post.dart';
import 'package:social/data/pagination.dart';

class PostDetails extends StatefulWidget {
  PostDetails({@required this.post});
  final PostModel post;
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> with ScrollableListMixin {
  @override
  initState() {
    super.initState();
    bloc = ScrollableListBloc(
      provider: BaseListProvider(
          paginator: Paginator(url: getCommentUrl(postId: widget.post.id)),
          listFromJson: CommentModel.listFromJson),
    )..add(LoadList());
    initScrollableList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  controller: getScrollController(),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: PostItem(
                          clickable: false,
                          post: widget.post,
                        ),
                      ),
                      showCommentList(state),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10, left: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Leave a comment...'),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
