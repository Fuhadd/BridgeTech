import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:urban_hive_test/Helpers/constants.dart';
import 'package:urban_hive_test/Models/models.dart';
import 'package:urban_hive_test/Widgets/constant_widget.dart';
import 'package:urban_hive_test/Widgets/matched_container.dart';
import 'package:urban_hive_test/Widgets/navigation_drawer.dart';

import '../Config/Repositories/firestore_repository.dart';
import '../Helpers/colors.dart';
import '../Widgets/shimmer_widget.dart';
import 'chat_screen.dart';
import 'failed_connection_screen.dart';

class MatchedUsersScreen extends StatefulWidget {
  const MatchedUsersScreen({
    Key? key,
    required this.currentUser,
  }) : super(key: key);
  final AppUser currentUser;
  static const routeName = '/matchedusers';

  @override
  State<MatchedUsersScreen> createState() => _MatchedUsersScreenState();
}

class _MatchedUsersScreenState extends State<MatchedUsersScreen> {
  List<ChatMap>? userMap;
  Stream<QuerySnapshot>? chats;
  List<QueryDocumentSnapshot<Object?>>? test;
  bool isloading = false;
  Stream<QuerySnapshot<Object?>>? chatRoomsStream;

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data?.docs.length != 0) {
          return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 6,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                int? count = snapshot.data?.docs.length;
                return FutureBuilder<AppUser?>(
                    future: FirestoreRepository().getThisUserInfo(
                        ds.id, widget.currentUser.id.toString()),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print("waiting");
                        return buildChatShimmer();
                      }

                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData &&
                          snapshot.data != null) {
                        final user = snapshot.data!;

                        final time =
                            DateTime.now().difference(ds["sentAt"].toDate());
                        print("This is time");
                        final convertedTime = (time.inSeconds);

                        DateTime formattedDate = (ds["sentAt"].toDate());
                        print(formattedDate);

                        String? finalTime;
                        if (convertedTime < 60) {
                          finalTime = "${time.inSeconds} seconds ago";
                        } else if (convertedTime > 60 && convertedTime < 3600) {
                          finalTime = "${time.inMinutes} minutes ago";
                        } else if (convertedTime > 3600 &&
                            convertedTime < 86400) {
                          finalTime = "${time.inHours} hours ago";
                        } else if (convertedTime <= 24 && convertedTime > 48) {
                          finalTime = "yesterday";
                        } else {
                          finalTime = "${time.inDays} days ago";
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 25),
                          child: MatchContainer(
                              buddyUser: user,
                              mainUser: widget.currentUser,
                              lastMessage: ds["sentBy"],
                              matchTime: finalTime,
                              chatRoomId: ds.id,
                              myUsername: widget.currentUser.lastName),
                        );
                      }
                      return buildChatShimmer();
                    });
              });
        } else if (snapshot.data?.docs.length == 0) {
          return NoUserWidget(
            mainText: "No Matched User",
            subText: "Try Again Later",
          );
        } else {
          return buildChatShimmer();
        }
      },
    );
  }

  getChatRooms() async {
    chatRoomsStream = await FirestoreRepository()
        .getMatchedConnections(widget.currentUser.id!);
    setState(() {});
  }

  @override
  void initState() {
    getChatRooms();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        drawer: NavigationDrawer(
          pageIndex: 9,
          // user: widget.currentUser,
        ),
        appBar:
            MessageAppar(context, 'Matched Users', widget.currentUser.imageUrl),
        body: chatRoomsList());
  }
}

class InboxPage extends StatelessWidget {
  InboxPage({
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
    return GestureDetector(
      onTap: (() async {
        String chatRoomId = await FirestoreRepository()
            .createChatRoomId(mainUser!.id!, buddyUser!.id!);

        await FirestoreRepository().openChatroom(mainUser!.id!, buddyUser!.id!);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(
                    currentUser: mainUser!,
                    invitedUser: buddyUser!,
                    chatRoomId: chatRoomId,
                  )),
        );
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          child: Card(
              color: background,
              child: ListTile(
                horizontalTitleGap: 20,
                contentPadding: EdgeInsets.all(10),
                title: CustomSubTitleText(
                  align: true,
                  title: "${buddyUser!.lastName} ${buddyUser!.firstName}",
                  color: Colors.black.withOpacity(0.8),
                  size: 19,
                ),
                subtitle: Text(
                  lastMessage,
                  softWrap: true,
                  style: TextStyle(fontSize: 15),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(buddyUser!.imageUrl),
                ),
                trailing: Text(lastMessageTime.toString(),
                    style: TextStyle(fontSize: 12)),
              )),
        ),
      ),
    );
  }
}

Widget buildChatShimmer() => const Padding(
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          title: ShimmerWidget.rectangular(height: 16),
          subtitle: Align(
            alignment: Alignment.centerLeft,
            child: ShimmerWidget.rectangular(
              height: 10,
              width: 100,
            ),
          ),
          leading: ShimmerWidget.circular(
            height: 64,
            width: 64,
          ),
        ),
      ),
    );

class NoContentWidget extends StatelessWidget {
  const NoContentWidget({
    Key? key,
    required this.mainText,
  }) : super(key: key);

  final String mainText;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          mainText,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.black),
        ),
        verticalSpacer(10),
        const Text('No Available Chats'),
        verticalSpacer(10),
        Container(
          height: 80,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Error1.png'))),
        )
      ],
    ));
  }
}
