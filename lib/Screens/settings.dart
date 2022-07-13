import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Config/Repositories/user_repository.dart';
import '../Helpers/constants.dart';
import '../Widgets/navigation_drawer.dart';
import 'forgot_password_screen.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(
        pageIndex: 8,
      ),
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          verticalSpacer(20),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ForgotPassword.routeName);
            },
            child: Card(
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.mode_edit),
                    horizontalSpacer(20),
                    Text('Change/Reset Password')
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.remove('user');
              UserRepository().logOut();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    horizontalSpacer(10),
                    Text('Logout')
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
