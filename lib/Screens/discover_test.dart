import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:urban_hive_test/Config/Repositories/firestore_repository.dart';
import 'package:urban_hive_test/Helpers/constants.dart';
import 'package:urban_hive_test/Widgets/constant_widget.dart';

import '../Models/models.dart';
import '../Widgets/discover_screen_widget.dart';
import '../Widgets/matched_container.dart';
import '../Widgets/navigation_drawer.dart';
import 'failed_connection_screen.dart';

class DiscoverTestScreen extends StatefulWidget {
  const DiscoverTestScreen(
      {Key? key, required this.currentUser, required this.initialPage})
      : super(key: key);
  static const routeName = '/usermatches';

  final AppUser currentUser;
  final int initialPage;

  @override
  State<DiscoverTestScreen> createState() => _DiscoverTestScreenState();
}

class _DiscoverTestScreenState extends State<DiscoverTestScreen> {
  Stream<QuerySnapshot>? chats;
  final _formKey = GlobalKey<FormBuilderState>();

  Widget ChatMessagePage() {
    PageController pageController =
        PageController(initialPage: widget.initialPage);
    return StreamBuilder(
      stream: chats,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("waiting");
          return loader();
        }
        // if (snapshot.hasData == null) {
        //   return NoUserWidget(
        //     mainText: "No User Available",
        //     subText: "Try Again Later",
        //   );
        // }

        // ignore: prefer_is_empty
        if (snapshot.hasData && snapshot.data!.docs.length > 0) {
          return PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            dragStartBehavior: DragStartBehavior.down,
            itemCount: snapshot.data?.docs.length ?? 6,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              AppUser buddyUser = AppUser(
                firstName: ds.get("firstName"),
                email: ds.get("email"),
                phone: ds.get("phoneNumber"),
                lastName: ds.get("lastName"),
                imageUrl: ds.get("imageUrl"),
                bio: ds.get("bio"),
                id: ds.get("id"),
                looking: ds.get("looking"),
                skills: ds.get("skills"),
                technical: ds.get("technical"),
                matchedUsers: ds.get("matchedUsers"),
              );
              print(snapshot.data?.docs.length);
              //pri
              //   print(user?[index]!.technical);
              return DiscoverScreenWidget(
                pageCount: snapshot.data?.docs.length,
                pageNumber: index,
                pageController: pageController,
                imageUrl: widget.currentUser.imageUrl,
                buddyUser: buddyUser,
                mainUser: widget.currentUser,
              );
            },
          );
          // ignore: prefer_is_empty
        } else if (snapshot.data?.docs.length == 0) {
          return const NoUserWidget(
            mainText: "No User Available",
            subText: "Try Again Later",
          );
        }

        return loader();
      },
    );
  }

  @override
  void initState() {
    FirestoreRepository().getUsersCredentialsbyid(widget.currentUser.id!).then(
        (value) => FirestoreRepository()
                .getTheUsers(value!.matchedUsers!, widget.currentUser.id!)
                .then((val) {
              setState(() {
                chats = val;
              });
            }));
    // FirestoreRepository()
    //     .getTheUsers(widget.currentUser.matchedUsers!, widget.currentUser.id!)
    //     .then((val) {
    //   setState(() {
    //     chats = val;
    //   });
    // });
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
          drawer: const NavigationDrawer(
            pageIndex: 5,
            // user: widget.currentUser,
          ),
          appBar:
              MessageAppar(context, 'Candidates', widget.currentUser.imageUrl),
          body: ChatMessagePage()
          // Column(
          //   children: [
          //     ChatMessagePage(),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          //       child: Row(
          //         children: [
          //           FormBuilder(
          //             key: _formKey,
          //             child: Expanded(
          //               child: customMessageField(
          //                   "text",
          //                   FontAwesomeIcons.message,
          //                   FontAwesomeIcons.accessibleIcon,
          //                   " Message...."),
          //             ),
          //           ),
          //           horizontalSpacer(10),
          //           GestureDetector(
          //             onTap: () async {
          //               // DateTime time = DateTime.now();
          //               // var validate = _formKey.currentState?.validate();
          //               // if (validate == true) {
          //               //   _formKey.currentState?.save();
          //               //   var message =
          //               //       _formKey.currentState?.fields['text']?.value;
          //               //   String chatRoomId = await FirestoreRepository()
          //               //       .createChatRoomId(
          //               //           widget.currentUser.id!, widget.invitedUser.id!);

          //               //   await FirestoreRepository().sendMessage(
          //               //       message: message,
          //               //       currentUserId: widget.currentUser.id!,
          //               //       chatRoomId: chatRoomId,
          //               //       time: time);
          //               //   Map<String, dynamic> lastMessageInfoMap = {
          //               //     "lastMessage": message,
          //               //     "lastMessageSendTime": time,
          //               //     "lastMessageSendBy": widget.currentUser.id!,
          //               //   };
          //               //   FirestoreRepository().updateLastMessageSend(
          //               //       chatRoomId, lastMessageInfoMap);
          //               //   setState(() {
          //               //     _formKey.currentState?.reset();
          //               //     FocusScope.of(context).unfocus();
          //               // });
          //               // }
          //             },
          //             child: Container(
          //               height: 45,
          //               width: 45,
          //               decoration:
          //                   BoxDecoration(color: Yellow, shape: BoxShape.circle),
          //               child: Icon(
          //                 FontAwesomeIcons.paperPlane,
          //                 color: Colors.white,
          //                 size: 24,
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          ),
    );

    // StreamBuilder(
    //   stream: chats,
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasData) {
    //       var userInfo = Message.fromJson(snapshot.data!.docs);
    //       print(12);
    //       print(userInfo);
    //       // print(snapshot.data);

    //     }

    //     return snapshot.hasData
    //         ? ContainsChatScreen(snapshot: snapshot, messages: [])
    //         // ListView.builder(
    //         //   itemCount: snapshot.data!.docs.length,
    //         //     itemBuilder: (context, index){
    //         //       return MessageTile(
    //         //         message: snapshot.data.documents[index].data["message"],
    //         //         sendByMe: Constants.myName == snapshot.data.documents[index].data["sendBy"],
    //         //       );
    //         //     })

    //         : Container();
    //   },
    // );
  }
  // ChatMessagesScreen(messages: messages);
}

// class ChatMessagesScreen extends StatelessWidget {
//   ChatMessagesScreen({
//     Key? key,
//     required this.messages,
//   }) : super(key: key);

//   final List<Message> messages;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         //ContainsChatScreen(messages: messages),
//         customFormBuilderTextField("text", FontAwesomeIcons.a,
//             FontAwesomeIcons.accessibleIcon, "Type your message here"),
//       ],
//     );
//   }
// }

class ContainsChatScreen extends StatelessWidget {
  ContainsChatScreen({
    Key? key,
    required this.currentUser,
    required this.snapshot,
  }) : super(key: key);

  AsyncSnapshot<QuerySnapshot> snapshot;
  AppUser currentUser;

  @override
  Widget build(BuildContext context) {
    bool sentByMe;
    return Expanded(
        child: ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 6,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              int? count = snapshot.data?.docs.length;
              return count == 0
                  ? const NoContentWidget(mainText: 'Chat Screen')
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 25),
                      child: TestContainer(
                        index: index,
                        snapshot: snapshot,
                      ),
                    );

              return buildChatShimmer();
            }));
  }
}
