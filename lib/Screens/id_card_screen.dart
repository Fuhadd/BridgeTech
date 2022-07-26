import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:urban_hive_test/Helpers/colors.dart';
import '../Config/Repositories/firestore_repository.dart';
import '../Helpers/constants.dart';
import '../Models/models.dart';
import '../Widgets/constant_widget.dart';
import '../Widgets/navigation_drawer.dart';

class IDScreen extends StatefulWidget {
  const IDScreen({Key? key, required this.currentUser}) : super(key: key);
  final AppUser currentUser;

  @override
  State<IDScreen> createState() => _IDScreenState();
}

class _IDScreenState extends State<IDScreen> {
  Stream<DocumentSnapshot>? chats;

  Widget userIdPage() {
    return StreamBuilder(
      stream: chats,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          AppUser currentUser = AppUser(
            firstName: snapshot.data!.get('firstName'),
            email: snapshot.data!.get('email'),
            phone: snapshot.data!.get('phoneNumber'),
            lastName: snapshot.data!.get('lastName'),
            imageUrl: snapshot.data!.get('imageUrl'),
            bio: snapshot.data!.get('bio'),
            technical: snapshot.data!.get('technical'),
            looking: snapshot.data!.get('looking'),
            id: snapshot.data!.get('id'),
            skills: snapshot.data!.get('skills'),
          );
          {
            return snapshot.hasData
                ? _buildUserIdPage(context: context, user: currentUser)
                : Container();
          }
        }
        return loader();
      },
    );
  }

  @override
  void initState() {
    FirestoreRepository().getCurrentUserProfile().then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      drawer: const NavigationDrawer(
        pageIndex: 7,
        // user: currentUser,
      ),
      appBar: MessageAppar(context, 'ID', widget.currentUser.imageUrl),
      body: userIdPage(),
    );
  }
}

class _buildUserIdPage extends StatelessWidget {
  const _buildUserIdPage({
    required this.context,
    required this.user,
    Key? key,
  }) : super(key: key);

  final BuildContext context;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 5, offset: Offset(5, 5), color: Colors.grey),
                BoxShadow(
                    blurRadius: 5, offset: Offset(-5, -5), color: Colors.grey),
                //BoxShadow(color: white, offset: const Offset(5, 0)),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 30.0, left: 30, top: 30, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubTitleText(
                    title: "${user.lastName} ${user.firstName}".toUpperCase(),
                    size: 25,
                  ),
                  verticalSpacer(5),
                  Text(
                    user.skills?[0] ?? "Developer",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  verticalSpacer(30),
                  Row(
                    children: [
                      horizontalSpacer(10),
                      SizedBox(
                          width: 70,
                          child: Text(
                            "GITHUB:",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17),
                          )),
                      SubTitleText(
                        title: user.lastName,
                        size: 19,
                      ),
                    ],
                  ),
                  verticalSpacer(8),
                  Row(
                    children: [
                      horizontalSpacer(10),
                      SizedBox(
                          width: 70,
                          child: Text(
                            "EMAIL:",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17),
                          )),
                      FittedBox(
                        child: SubTitleText(
                          title: user.email,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                  verticalSpacer(8),
                  Row(
                    children: [
                      horizontalSpacer(10),
                      SizedBox(
                          width: 70,
                          child: Text(
                            "PHONE:",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17),
                          )),
                      SubTitleText(
                        title: "(+234) ${user.phone}",
                        size: 16,
                      ),
                    ],
                  ),
                  verticalSpacer(30),
                  Row(
                    children: [
                      Container(
                        width: 110,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/Logo.png'))),
                      ),
                      horizontalSpacer(5),
                      SubTitleText(
                        title: "BRIDGETECH ADVANCE",
                        size: 13,
                      ),
                    ],
                  ),
                  verticalSpacer(25)
                ],
              ),
            ),
          ),
          verticalSpacer(20),
          QrImage(
            data: user.firstName,
            backgroundColor: background,
            size: 150,
          )
        ],
      ),
    );
  }
}
