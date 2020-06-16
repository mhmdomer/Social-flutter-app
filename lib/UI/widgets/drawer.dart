import 'package:flutter/material.dart';
import 'package:social/UI/constants.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Username'),
            accountEmail: Text('email@email.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar1.jpg'),
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
