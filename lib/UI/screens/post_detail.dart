import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/helpers/scrollable_list_mixin.dart';
import 'package:social/UI/helpers/showList.dart';
import 'package:social/UI/widgets/comment.dart';
import 'package:social/UI/widgets/post.dart';
import 'package:social/bloc/add_comment_bloc/add_comment_bloc.dart';
import 'package:social/bloc/scrollable_list_bloc/scrollable_list_bloc.dart';
import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/api_providers/base_list_provider.dart';
import 'package:social/data/models/comment.dart';
import 'package:social/data/models/post.dart';
import 'package:social/data/pagination.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostDetails extends StatefulWidget {
  PostDetails({@required this.post});
  final PostModel post;
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> with ScrollableListMixin {
  List<Comment> newComments = [];
  AddCommentBloc addCommentBloc = AddCommentBloc();
  TextEditingController commentTextController = TextEditingController();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScrollableListBloc>(
          create: (context) => bloc,
        ),
        BlocProvider<AddCommentBloc>(
          create: (context) => addCommentBloc,
        )
      ],
      child: BlocConsumer(
        bloc: bloc,
        listener: (context, state) {
          if (state is ListLoaded) {
            newComments = [];
            completeCompleter();
          }
        },
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    bloc.add(RefreshList());
                    return completerFuture();
                  },
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
                        BlocConsumer<AddCommentBloc, AddCommentState>(
                          listener: (context, state) {
                            if (state is AddCommentSuccess) {
                              newComments.insert(
                                  0,
                                  Comment(
                                    comment: state.comment,
                                  ));
                            }
                          },
                          builder: (context, state) => Column(
                            children: newComments,
                          ),
                        ),
                        showList(state, ScrollableType.comments),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10, left: 10),
                child: BlocConsumer<AddCommentBloc, AddCommentState>(
                  listener: (context, state) {
                    if (state is AddCommentSuccess) {
                      commentTextController.text = '';
                    } else if (state is AddCommentError) {}
                  },
                  builder: (context, state) => Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          autofocus: false,
                          controller: commentTextController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Leave a comment...'),
                        ),
                      ),
                      IconButton(
                        splashRadius: 1.0,
                        icon: Icon(Icons.send),
                        onPressed: state is AddCommentLoading
                            ? null
                            : () {
                                String text = commentTextController.text;
                                if (text.trim().length > 3) {
                                  addCommentBloc.add(
                                    new AddComment(
                                        postId: widget.post.id,
                                        comment: text.trim()),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg:
                                        'Sorry, The comment should be at least 3 characters.',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
