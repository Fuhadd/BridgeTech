import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_hive_test/Helpers/constants.dart';
import 'package:urban_hive_test/Models/models.dart';
import 'package:urban_hive_test/Screens/home_page.dart';
import 'package:urban_hive_test/Screens/verifyuserbio_screen.dart';

import '../Helpers/colors.dart';
import '../Widgets/constant_widget.dart';
import 'login_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key, required this.user}) : super(key: key);
  static const routeName = '/verifyEmail';
  final AppUser user;

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    print(isEmailVerified);

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    print(isEmailVerified);

    Future sendVerificationEmail() async {
      try {
        final user = FirebaseAuth.instance.currentUser!;
        await user.sendEmailVerification();
      } catch (e) {}
    }

    Future checkEmailVerified() async {
      await FirebaseAuth.instance.currentUser!.reload();
      setState(() {
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
        if (isEmailVerified) timer?.cancel();
      });
    }

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified);
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? VerifyBioScreen(
          user: widget.user,
        )
      : Scaffold(
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const _CustomCurvedBar(),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 40,
                    right: 40,
                    bottom: 40,
                  ),
                  child: Text(
                    'A verification link has been sent to your mail, Click on the link to continue with your registration. Don\'t forget to check Spam Folders',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Column(
                    children: [
                      const Text(
                          ' If you are not automatically directed to the homepage after verification, click button below'),
                      verticalSpacer(30),
                      CustomButton(
                        color: Yellow,
                        onTap: () {
                          setState(() {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyEmailScreen(
                                        user: widget.user,
                                      )), // this mainpage is your page to refresh
                              (Route<dynamic> route) => false,
                            );
                          });
                        },
                        title: 'Reload',
                      ),
                    ],
                  ),
                ),
                verticalSpacer(10),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: CustomButton(
                    textcolor: Yellow,
                    color: Colors.white,
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    title: 'Cancel',
                  ),
                ),
                verticalSpacer(10),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: CustomButton(
                    textcolor: Yellow,
                    color: Colors.white,
                    onTap: () {
                      setState(() {
                        isEmailVerified = true;
                      });
                    },
                    title: 'Change Email',
                  ),
                )
              ],
            ),
          ),
        );
}

class _CustomCurvedBar extends StatelessWidget {
  const _CustomCurvedBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 210,
            decoration: BoxDecoration(color: Yellow),
          ),
        ),
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Yellow, background],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80, left: 30),
              child: Row(
                children: [
                  Text(
                    'Verify your Email',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.insert_emoticon)
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);
    var firstController = Offset(0, size.height - 90);
    var firstEnd = Offset(size.width / 4, size.height - 90);
    path.quadraticBezierTo(
      firstController.dx,
      firstController.dy,
      firstEnd.dx,
      firstEnd.dy,
    );
    path.lineTo(size.width - 100, size.height - 90);
    var SecondController = Offset(size.width - 55, size.height - 90);
    var SecondEnd = Offset(size.width, size.height - 140);
    path.quadraticBezierTo(
      SecondController.dx,
      SecondController.dy,
      SecondEnd.dx,
      SecondEnd.dy,
    );
    path.lineTo(size.width, 0);
    path.close;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

InputDecoration formDecoration = const InputDecoration(
    floatingLabelStyle: TextStyle(color: Colors.pink),
    fillColor: Colors.pink,
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
    prefixIcon: Icon(
      Icons.mail,
      size: 20,
    ),
    labelText: 'Gender');
