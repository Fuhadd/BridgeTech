import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:urban_hive_test/Models/models.dart';

import '../Config/Repositories/user_repository.dart';
import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Widgets/navigation_drawer.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AppUser? currentUser;

  Future<AppUser> getMyInfoFromSharedPreference() async {
    currentUser = await UserRepository().fetchCurrentUser();
    return currentUser!;
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
  }

  @override
  void initState() {
    UserRepository().fetchCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      right: false,
      left: false,
      bottom: false,
      child: Scaffold(
          drawer: NavigationDrawer(
            pageIndex: 4,
          ),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: buildUserPage(context, currentUser!)),
    );
  }
}

Widget buildUserPage(BuildContext context, AppUser user) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      user.imageUrl,
                    ),
                  ),
                  verticalSpacer(5),
                  Text(
                    "${user.lastName} ${user.firstName}",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.purple,
                  Yellow,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0)),
              ),
            ),
            // Positioned(
            //   bottom: 20,
            //   right: 20,
            //   child: GestureDetector(
            //     onTap: (() {}),
            //   ),
            // ),
          ],
        ),
        verticalSpacer(20),
        UserFields(
          context,
          icon: Icons.mail,
          title: 'Email',
          details: user.email,
        ),
        verticalSpacer(20),
        UserFields(context,
            icon: Icons.phone,
            title: 'Phone Number',
            details: "(+234) ${user.phone}"),
        verticalSpacer(20),
        UserFields(context,
            icon: Icons.phone,
            title: 'Technical',
            details: user.looking == "0" ? "No" : "Yes"),
        verticalSpacer(20),
        UserFields(context,
            icon: Icons.phone,
            title: 'Looking For',
            details: user.looking == "0" ? "Non Technical" : "Technical"),
        verticalSpacer(20),
        UserFields(
          context,
          icon: Icons.people,
          title: 'About You',
          details: user.bio!,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              const Icon(
                Icons.data_usage,
                size: 17,
              ),
              horizontalSpacer(10),
              verticalSpacer(20),
              const Text(
                'Skills / Job Decription',
                textAlign: TextAlign.left,
              ),
              verticalSpacer(40),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
              children: user.skills!
                  .map((interest) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.purple, Yellow],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(interest),
                        ),
                      ))
                  .toList()),
        )
      ],
    ),
  );
}

Widget UserFields(BuildContext context,
    {required IconData icon, required String title, required String details}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Column(
      children: [
        Container(
          child: Column(
            children: [
              (Row(
                children: [
                  Icon(
                    icon,
                    size: 17,
                  ),
                  horizontalSpacer(10),
                  verticalSpacer(20),
                  Text(
                    title,
                    textAlign: TextAlign.left,
                  ),
                  verticalSpacer(40),
                ],
              )),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 35),
                  child: Text(
                    details,
                    style: Theme.of(context).textTheme.headline5,
                  )),
              verticalSpacer(15)
            ],
          ),
          width: double.infinity - 50,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
