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
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(
          pageIndex: 8,
        ),
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          backgroundColor: const Color(0xfff4a50c),
        ),
        body: Column(
          children: [
            verticalSpacer(20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ForgotPassword.routeName);
              },
              child: Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(Icons.mode_edit),
                      horizontalSpacer(15),
                      const Text(
                        'Change/Reset Password',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )
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
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(Icons.logout),
                      horizontalSpacer(15),
                      const Text(
                        'Logout',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
