// ignore_for_file: prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urban_hive_test/Helpers/colors.dart';
import 'package:urban_hive_test/Helpers/constants.dart';
import 'package:urban_hive_test/Screens/requests_screen.dart';
import 'package:urban_hive_test/Screens/view_other_profiles.dart';
import 'package:urban_hive_test/Widgets/navigation_drawer.dart';

import '../Config/Repositories/firestore_repository.dart';
import '../Config/Repositories/user_repository.dart';
import '../Config/Services/local_push_notification.dart';
import '../Models/models.dart';
import '../Widgets/constant_widget.dart';
import 'matched_users_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppUser? currentUser;
  List<AppUser> users = [];
  Stream<QuerySnapshot<Object?>>? userRequestStream;
  Stream<QuerySnapshot<Object?>>? userMessagesStream;
  Stream<QuerySnapshot<Object?>>? matchedUsersStream;

  Future<AppUser> getMyInfoFromSharedPreference() async {
    currentUser = await UserRepository().fetchCurrentUser();
    return currentUser!;
  }

  getChatRooms() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid.toString();
    matchedUsersStream =
        await FirestoreRepository().getMatchedConnections(uid!);
    setState(() {});
  }

  doThisOnLaunch() async {
    await FirestoreRepository().storeNotificationToken();
  }

  @override
  void initState() {
    UserRepository().fetchCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();

    FirestoreRepository().getMatchedConnections(uid).then((value) {
      setState(() {
        matchedUsersStream = value;
      });
    });

    FirestoreRepository().getAllRequest(uid).then((value) {
      setState(() {
        userRequestStream = value;
      });
    });

    FirestoreRepository().getChatRooms(uid).then((value) {
      setState(() {
        userMessagesStream = value;
      });
    });
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((event) {
      // //Step 1 debug
      // print('FCM message received');
      //Step 7 here
      LocalNotificationService.display(event);
    });

    doThisOnLaunch();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return currentUser == null
        ? Scaffold(body: Center(child: loader()))
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              backgroundColor: background,
              drawer: const NavigationDrawer(
                pageIndex: 1,
              ),
              appBar: MessageAppar(context, 'Dashboard', currentUser!.imageUrl),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      verticalSpacer(26),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 7,
                                offset: Offset(-7, -7),
                                color: Colors.grey),
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xfff4a50c),
                          // color: const Color.fromRGBO(255, 189, 89, 1),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SubTitleText(
                                      title: 'Active Users',
                                    ),
                                    verticalSpacer(5),
                                    const Text(
                                      "Number of users online",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    verticalSpacer(15),
                                    Row(
                                      children: [
                                        const TitleText(title: '645'),
                                        horizontalSpacer(10),
                                        Text(
                                          "+5.25%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  fontSize: 17,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            verticalSpacer(15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      SubTitleText(title: "9.5k"),
                                      Text(
                                        "Users",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SubTitleText(title: "6.8k"),
                                      Text(
                                        "Requests",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SubTitleText(title: "1.2k"),
                                      Text(
                                        "Matches",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpacer(15),
                      const Divider(
                        thickness: 1,
                        endIndent: 30,
                        indent: 30,
                        color: Colors.black,
                      ),
                      verticalSpacer(15),
                      StreamBuilder(
                        stream: matchedUsersStream,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data?.docs.length != 0) {
                            return ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot ds = snapshot.data!.docs[0];
                                  int? count = snapshot.data?.docs.length;
                                  return FutureBuilder<AppUser?>(
                                      future: FirestoreRepository()
                                          .getThisUserInfo(ds.id,
                                              currentUser!.id.toString()),
                                      builder:
                                          (BuildContext context, snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              "Something went wrong");
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          print("waiting");
                                          return UserDropdownBox(
                                              "Co-Founder Matches",
                                              [],
                                              currentUser!,
                                              '');
                                        }

                                        if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.hasData &&
                                            snapshot.data != null) {
                                          final user = snapshot.data!;
                                          users = [];
                                          users.add(user);

                                          final time = DateTime.now()
                                              .difference(
                                                  ds["sentAt"].toDate());
                                          print("This is time");
                                          final convertedTime =
                                              (time.inSeconds);

                                          DateTime formattedDate =
                                              (ds["sentAt"].toDate());
                                          print(formattedDate);

                                          String? finalTime;
                                          if (convertedTime < 60) {
                                            finalTime =
                                                "${time.inSeconds} seconds ago";
                                          } else if (convertedTime > 60 &&
                                              convertedTime < 3600) {
                                            finalTime =
                                                "${time.inMinutes} minutes ago";
                                          } else if (convertedTime > 3600 &&
                                              convertedTime < 86400) {
                                            finalTime =
                                                "${time.inHours} hours ago";
                                          } else if (convertedTime <= 24 &&
                                              convertedTime > 48) {
                                            finalTime = "yesterday";
                                          } else {
                                            finalTime =
                                                "${time.inDays} days ago";
                                          }

                                          return UserDropdownBox(
                                            "Co-Founder Matches",
                                            users,
                                            currentUser!,
                                            finalTime,
                                          );
                                        }
                                        return UserDropdownBox(
                                            "Co-Founder Matches",
                                            [],
                                            currentUser!,
                                            '');
                                      });
                                });
                          } else if (snapshot.data?.docs.length == 0) {
                            return UserDropdownBox(
                                "Co-Founder Matches", [], currentUser!, '');
                          } else {
                            return UserDropdownBox(
                                "Co-Founder Matches", [], currentUser!, '');
                          }
                        },
                      ),
                      verticalSpacer(25),
                      StreamBuilder(
                        stream: userRequestStream,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data?.docs.length != 0) {
                            return ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot ds = snapshot.data!.docs[0];
                                  int? count = snapshot.data?.docs.length;
                                  return FutureBuilder<AppUser?>(
                                      future: FirestoreRepository()
                                          .getThisUserInfo(ds.id,
                                              currentUser!.id.toString()),
                                      builder:
                                          (BuildContext context, snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              "Something went wrong");
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return RequestDropdownBox(
                                              "Co-Founder Requests",
                                              [],
                                              currentUser!,
                                              '');
                                        }

                                        if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.hasData &&
                                            snapshot.data != null) {
                                          final user = snapshot.data!;
                                          users = [];
                                          users.add(user);

                                          final time = DateTime.now()
                                              .difference(
                                                  ds["sentAt"].toDate());
                                          print("This is time");
                                          final convertedTime =
                                              (time.inSeconds);

                                          DateTime formattedDate =
                                              (ds["sentAt"].toDate());
                                          print(formattedDate);

                                          String? finalTime;
                                          if (convertedTime < 60) {
                                            finalTime =
                                                "${time.inSeconds} seconds ago";
                                          } else if (convertedTime > 60 &&
                                              convertedTime < 3600) {
                                            finalTime =
                                                "${time.inMinutes} minutes ago";
                                          } else if (convertedTime > 3600 &&
                                              convertedTime < 86400) {
                                            finalTime =
                                                "${time.inHours} hours ago";
                                          } else if (convertedTime <= 24 &&
                                              convertedTime > 48) {
                                            finalTime = "yesterday";
                                          } else {
                                            finalTime =
                                                "${time.inDays} days ago";
                                          }

                                          return RequestDropdownBox(
                                            "Co-Founder Requests",
                                            users,
                                            currentUser!,
                                            finalTime,
                                          );
                                        }
                                        return RequestDropdownBox(
                                          "Co-Founder Requests",
                                          [],
                                          currentUser!,
                                          '',
                                        );
                                      });
                                });
                          } else if (snapshot.data?.docs.length == 0) {
                            return RequestDropdownBox(
                                "Co-Founder Requests", [], currentUser!, '');
                          } else {
                            return RequestDropdownBox(
                                "Co-Founder Requests", [], currentUser!, '');
                          }
                        },
                      ),
                      verticalSpacer(40),
                      StreamBuilder(
                        stream: userMessagesStream,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data?.docs.length != 0) {
                            return ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot ds = snapshot.data!.docs[0];
                                  int? count = snapshot.data?.docs.length;
                                  return FutureBuilder<AppUser?>(
                                      future: FirestoreRepository()
                                          .getThisUserInfo(ds.id,
                                              currentUser!.id.toString()),
                                      builder:
                                          (BuildContext context, snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              "Something went wrong");
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const LoadingRecentMessageContainer();
                                        }

                                        if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.hasData &&
                                            snapshot.data != null) {
                                          final user = snapshot.data!;
                                          users = [];
                                          users.add(user);

                                          final time = DateTime.now()
                                              .difference(
                                                  ds["lastMessageSendTime"]
                                                      .toDate());
                                          print("This is time");
                                          final convertedTime =
                                              (time.inSeconds);

                                          DateTime formattedDate =
                                              (ds["lastMessageSendTime"]
                                                  .toDate());
                                          print(formattedDate);

                                          String? finalTime;
                                          if (convertedTime < 60) {
                                            finalTime =
                                                "${time.inSeconds} seconds ago";
                                          } else if (convertedTime > 60 &&
                                              convertedTime < 3600) {
                                            finalTime =
                                                "${time.inMinutes} minutes ago";
                                          } else if (convertedTime > 3600 &&
                                              convertedTime < 86400) {
                                            finalTime =
                                                "${time.inHours} hours ago";
                                          } else if (convertedTime <= 24 &&
                                              convertedTime > 48) {
                                            finalTime = "yesterday";
                                          } else {
                                            finalTime =
                                                "${time.inDays} days ago";
                                          }

                                          return RecentMessageContainer(
                                              buddyUser: user,
                                              mainUser: currentUser,
                                              lastMessage: ds["lastMessage"],
                                              lastMessageTime: finalTime,
                                              chatRoomId: ds.id,
                                              myUsername:
                                                  currentUser!.lastName);
                                        }
                                        return const EmptyRecentMessageContainer();
                                      });
                                });
                          } else if (snapshot.data?.docs.length == 0) {
                            return const EmptyRecentMessageContainer();
                          } else {
                            return const LoadingRecentMessageContainer();
                          }
                        },
                      ),
                      verticalSpacer(30),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Container UserDropdownBox(String title, List<AppUser> users,
      AppUser currentUser, String? finalTime) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 5, offset: Offset(2, 5), color: Colors.grey),
          ]),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: DropdownButton<dynamic>(
            isExpanded: true,
            icon: const Icon(
              FontAwesomeIcons.caretDown,
              size: 25,
            ),
            itemHeight: 230,
            hint: SubTitleText(
              title: title,
              size: 18,
            ),
            onChanged: (value) => setState(() {}),
            items: users
                .map(
                  (user) => CustomDropdownMenu(user, currentUser, finalTime),
                )
                .toList(),
          )),
    );
  }

  DropdownMenuItem<dynamic> CustomDropdownMenu(
      AppUser user, AppUser currentUser, String? finalTime) {
    return DropdownMenuItem(
        value: user,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SubTitleText(
                                title: "${user.lastName} ${user.firstName}"),
                            verticalSpacer(6),
                            Text("Matched $finalTime"),
                            verticalSpacer(15),
                            Text(
                              user.bio!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                            ),
                            verticalSpacer(20),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                verticalSpacer(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClickableSmallCustomButton(
                        title: "VIEW",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ViewOtherProfiles(
                                buddyUser: user,
                                mainUser: currentUser,
                              ),
                            ),
                          );
                        },
                      ),
                      ClickableSmallCustomButton(
                        title: "OTHERS",
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => MatchedUsersScreen(
                                    currentUser: currentUser)),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Container RequestDropdownBox(String title, List<AppUser> users,
      AppUser currentUser, String? finalTime) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 5, offset: Offset(2, 5), color: Colors.grey),
          ]),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: DropdownButton<dynamic>(
            isExpanded: true,
            icon: const Icon(
              FontAwesomeIcons.caretDown,
              size: 25,
            ),
            itemHeight: 230,
            hint: SubTitleText(
              title: title,
              size: 18,
            ),
            onChanged: (value) => setState(() {}),
            items: users
                .map(
                  (user) =>
                      RequestCustomDropdownMenu(user, currentUser, finalTime),
                )
                .toList(),
          )),
    );
  }

  DropdownMenuItem<dynamic> RequestCustomDropdownMenu(
      AppUser user, AppUser currentUser, String? finalTime) {
    return DropdownMenuItem(
        value: user,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SubTitleText(
                                title: "${user.lastName} ${user.firstName}"),
                            verticalSpacer(6),
                            Text("Sent $finalTime"),
                            verticalSpacer(15),
                            Text(
                              user.bio!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                            ),
                            verticalSpacer(20),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                verticalSpacer(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClickableSmallCustomButton(
                        title: "VIEW",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ViewOtherProfiles(
                                buddyUser: user,
                                mainUser: currentUser,
                              ),
                            ),
                          );
                        },
                      ),
                      ClickableSmallCustomButton(
                        title: "OTHERS",
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => UserRequestsScreen(
                                    currentUser: currentUser)),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class RecentMessageContainer extends StatelessWidget {
  const RecentMessageContainer({
    required this.lastMessageTime,
    required this.buddyUser,
    required this.mainUser,
    required this.chatRoomId,
    required this.lastMessage,
    required this.myUsername,
    Key? key,
  }) : super(key: key);
  final String lastMessage, chatRoomId, myUsername;
  final AppUser? buddyUser, mainUser;
  final String lastMessageTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        child: Column(
          children: [
            SubTitleText(
              title: "Recent Message",
              size: 20,
            ),
            verticalSpacer(20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(buddyUser!.imageUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubTitleText(
                            title:
                                '${buddyUser!.lastName} ${buddyUser!.firstName}',
                            size: 21,
                          ),
                          verticalSpacer(6),
                          SizedBox(
                            width: 200,
                            child: Text(
                              lastMessage,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                          verticalSpacer(30),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyRecentMessageContainer extends StatelessWidget {
  const EmptyRecentMessageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        child: Column(
          children: [
            SubTitleText(
              title: "Recent Message",
              size: 20,
            ),
            verticalSpacer(20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomSubTitleText(
                    title: 'No Available Chats',
                    color: Colors.grey,
                    fontWeight: FontWeight.w900,
                  ),
                  horizontalSpacer(15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingRecentMessageContainer extends StatelessWidget {
  const LoadingRecentMessageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        child: Column(
          children: [
            SubTitleText(
              title: "Recent Message",
              size: 20,
            ),
            verticalSpacer(20),
            Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: loader(size: 5)),
          ],
        ),
      ),
    );
  }
}
