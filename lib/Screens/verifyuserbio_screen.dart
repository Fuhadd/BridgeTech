import 'dart:async';

import 'package:flutter/material.dart';
import 'package:urban_hive_test/Config/Repositories/firestore_repository.dart';
import 'package:urban_hive_test/Helpers/colors.dart';
import 'package:urban_hive_test/Models/models.dart';
import 'package:urban_hive_test/Screens/incomplete_profile_screen.dart';

import '../Widgets/constant_widget.dart';
import 'user_profile_test.dart';

class VerifyBioScreen extends StatefulWidget {
  const VerifyBioScreen({Key? key, required this.user}) : super(key: key);
  static const routeName = '/verifybio';
  final AppUser user;

  @override
  _VerifyBioScreenState createState() => _VerifyBioScreenState();
}

class _VerifyBioScreenState extends State<VerifyBioScreen> {
  bool? isVerified;

  @override
  void initState() {
    super.initState();

    FirestoreRepository().checkUserBio().then((value) {
      setState(() {
        isVerified = value;
      });
    });

    Future checkEmailVerified() async {
      //await FirebaseAuth.instance.currentUser!.reload();
      FirestoreRepository().checkUserBio().then((value) {
        setState(() {
          isVerified = value;
        });
      });
    }

    // if (!isVerified ==false) {
    //   checkEmailVerified();
    // }
    if (isVerified == false) {
      checkEmailVerified();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isVerified == true) {
      return const UserProfileTestScreen();

      // ProfileScreen(
      //     // currentUser: user,
      //     );
    } else if (isVerified == false) {
      return const IncompleteProfileScreen();
    } else {
      return Scaffold(
          body: Center(child: loader()), backgroundColor: background);
    }
  }
}







//   @override
//   Widget build(BuildContext context) {
//     if (isVerified == true) {
//       return const HomePage(
//           // currentUser: widget.user,//
//           );
//     } else if (isVerified == false) {
//       return MoreInfoScreen();
//     } else {
//       return Scaffold(
//           body: Center(child: loader()),
//           backgroundColor: Colors.grey.withOpacity(0.4));
//     }
//   }
// }


