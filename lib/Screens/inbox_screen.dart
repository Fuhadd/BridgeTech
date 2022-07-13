import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:urban_hive_test/Helpers/constants.dart';
import 'package:urban_hive_test/Models/models.dart';
import 'package:urban_hive_test/Widgets/constant_widget.dart';
import 'package:urban_hive_test/Widgets/navigation_drawer.dart';

import '../Config/Repositories/firestore_repository.dart';
import '../Helpers/colors.dart';
import '../Widgets/shimmer_widget.dart';
import 'chat_screen.dart';

class Inboxscreen extends StatefulWidget {
  const Inboxscreen({
    Key? key,
    required this.currentUser,
  }) : super(key: key);
  final AppUser currentUser;
  static const routeName = '/usermatches';

  @override
  State<Inboxscreen> createState() => _InboxscreenState();
}

class _InboxscreenState extends State<Inboxscreen> {
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

  // Widget ChatMessagePage() {
  //   QueryDocumentSnapshot<Map<String, dynamic>>? chatDetails;
  //   return FutureBuilder(
  //     future: FirestoreRepository().getAllChats(),
  //     builder: (BuildContext context,
  //         AsyncSnapshot<List<QueryDocumentSnapshot<Object?>>> snapshot) {
  //       if (snapshot.hasData) {
  //         print(121);
  //         print(snapshot);
  //         print(snapshot.data?[0].get("chatRoomId"));
  //         // snapshot.data!.docs[0].reference
  //         //         .collection("chats")
  //         //         .get()
  //         //         .then((value) {
  //         //   print(value.docs[0].get("time"));
  //         // })

  //         // .docs("80rI4pS5e0N7YoqAp2g3RrINVCK2_DgXHnycP8vZpPQSYo9FU0Fnd23j1")
  //         // .get('time')

  //         // print(snapshot.data!.docs[0].get("time"));

  //         {
  //           // print(chatDetails!.get("time"));
  //           return snapshot.hasData
  //               ? InboxPage(firstSnapshot: snapshot)
  //               // ContainsChatScreen(
  //               //     snapshot: snapshot,
  //               //     currentUser: widget.currentUser,
  //               //   )
  //               : Expanded(child: Container());
  //         }
  //       }
  //       return Container();
  //     },
  //   );
  // }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                //reverse: true,
                itemCount: snapshot.data?.docs.length ?? 6,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  int? count = snapshot.data?.docs.length;
                  return count == 0
                      ? NoContentWidget(mainText: 'Chat Screen')
                      : FutureBuilder<AppUser?>(
                          future: FirestoreRepository().getThisUserInfo(
                              ds.id, widget.currentUser.id.toString()),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return buildChatShimmer();
                            }

                            if (snapshot.data == null) {
                              return buildChatShimmer();
                            }

                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData &&
                                snapshot.data != null) {
                              final user = snapshot.data!;
                              print(17778);
                              print(user);
                              final time = DateTime.now().difference(
                                  ds["lastMessageSendTime"].toDate());
                              print("This is time");
                              final convertedTime = (time.inSeconds);

                              // print(convertedTime.fromNow());
                              DateTime formattedDate =
                                  (ds["lastMessageSendTime"].toDate());
                              print(formattedDate);

                              String? finalTime;
                              if (convertedTime < 60) {
                                finalTime = "${time.inSeconds} seconds ago";
                              } else if (convertedTime > 60 &&
                                  convertedTime < 3600) {
                                finalTime = "${time.inMinutes} minutes ago";
                              } else if (convertedTime > 3600 &&
                                  convertedTime < 86400) {
                                finalTime = "${time.inHours} hours ago";
                              } else if (convertedTime <= 24 &&
                                  convertedTime > 48) {
                                finalTime = "yesterday";
                              } else {
                                finalTime = "${time.inDays} days ago";
                              }
                              // final time = DateFormat.format(
                              //  ,
                              // );

                              return InboxPage(
                                  buddyUser: user,
                                  mainUser: widget.currentUser,
                                  lastMessage: ds["lastMessage"],
                                  lastMessageTime: finalTime,
                                  chatRoomId: ds.id,
                                  myUsername: widget.currentUser.lastName);

                              //DiscoverWidget(imageUrl: imageUrl, widget: widget);
                            }
                            return buildChatShimmer();
                          });
                })
            : buildChatShimmer();
      },
    );
  }

  getChatRooms() async {
    chatRoomsStream =
        await FirestoreRepository().getChatRooms(widget.currentUser.id!);
    setState(() {});
  }

  onScreenLoaded() async {
    getChatRooms();
  }

  @override
  void initState() {
    print(234);
    getChatRooms();

    // FirestoreRepository().getAllChats().then((val) {
    //   setState(() {
    //     test = val;
    //   });
    // });
    // FirestoreRepository().getChatsPlusUser().then((val) {
    //   setState(() {
    //     userMap = val;
    //     val.forEach((element) async {
    //       String id = element.chatRoomId;
    //       chats = await FirestoreRepository().getChats(id);
    //     });
    //   });
    // }));
    super.initState();
  }

  //final AppUser currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        drawer: NavigationDrawer(
          pageIndex: 6,
          // user: widget.currentUser,
        ),
        appBar: MessageAppar(context, 'Messages', widget.currentUser.imageUrl),
        body: chatRoomsList()
        // Padding(
        //   padding: const EdgeInsets.only(top: 20.0),
        //   child: isloading == false
        //       ? loader()
        //       : InboxPage(
        //           chatMap: userMap,
        //         ),
        // ),
        );
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
  // AsyncSnapshot<List<QueryDocumentSnapshot<Object?>>> firstSnapshot;
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
          //decoration: BoxDecoration(border: Border.all()),
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
                //Text(Conversation.conversations[index].name),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(buddyUser!.imageUrl),
                ),
                // subtitle: Text("Conversation.conversations[index].content"),
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
          // horizontalTitleGap: 20,
          contentPadding: EdgeInsets.all(10),

          title: ShimmerWidget.rectangular(height: 16),
          subtitle: Align(
            alignment: Alignment.centerLeft,
            child: ShimmerWidget.rectangular(
              height: 10,
              width: 100,
            ),
          ),
          //Text(Conversation.conversations[index].name),
          leading: ShimmerWidget.circular(
            height: 64,
            width: 64,
            // shapeBorder:
            //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          // subtitle: Text("Conversation.conversations[index].content"),
          // trailing: ShimmerWidget.rectangular(height: 14),
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
