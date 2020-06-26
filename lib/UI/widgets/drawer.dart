import 'package:flutter/material.dart';
import 'package:social/UI/constants.dart';
import 'package:social/bloc/user_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({@required this.userBloc});
  final UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userBloc.name),
            accountEmail: Text(userBloc.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: userBloc.imageUrl == null
                  ? AssetImage('assets/avatar1.jpg')
                  : CachedNetworkImage(
                      imageUrl: userBloc.imageUrl,
                    ),
            ),
            decoration: BoxDecoration(color: mediumBlue),
          ),
          ListTile(
            leading: Icon(Icons.home, color: cornflowerBlue),
            title: Text('Home Page'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.person_outline,
              color: cornflowerBlue,
            ),
            title: Text('Logout'),
            onTap: () async {},
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: cornflowerBlue,
            ),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: cornflowerBlue,
            ),
            title: Text('About'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
