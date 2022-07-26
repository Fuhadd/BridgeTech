import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:urban_hive_test/Config/Repositories/firestore_repository.dart';
import 'package:urban_hive_test/Config/Repositories/notification_repository.dart';
import 'package:urban_hive_test/Helpers/colors.dart';
import 'package:urban_hive_test/Helpers/constants.dart';
import 'package:urban_hive_test/Widgets/constant_widget.dart';

import '../Models/models.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {Key? key,
      required this.currentUser,
      required this.invitedUser,
      required this.chatRoomId})
      : super(key: key);
  static const routeName = '/usermatches';
  final String chatRoomId;
  final AppUser currentUser;
  final AppUser invitedUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Stream<QuerySnapshot>? chats;
  final _formKey = GlobalKey<FormBuilderState>();

  Widget ChatMessagePage() {
    return StreamBuilder(
      stream: chats,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          print(snapshot.data!.size);

          // print(snapshot.data!.docs[0].get("time"));

          {
            return snapshot.hasData && snapshot.data!.docs.isNotEmpty
                ? ContainsChatScreen(
                    snapshot: snapshot,
                    currentUser: widget.currentUser,
                  )
                : Expanded(child: Container());
          }
        }
        return Expanded(child: loader());
      },
    );
  }

  @override
  void initState() {
    FirestoreRepository().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });

    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((event) {
      // //Step 1 debug
      // print('FCM message received');
      //Step 7 here
      // LocalNotificationService.display(event);
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
        appBar: ChatAppar(
            context,
            "${widget.invitedUser.lastName} ${widget.invitedUser.firstName}",
            widget.invitedUser.imageUrl),
        body: Column(
          children: [
            ChatMessagePage(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  FormBuilder(
                    key: _formKey,
                    child: Expanded(
                      child: customMessageField(
                          "text",
                          FontAwesomeIcons.message,
                          FontAwesomeIcons.accessibleIcon,
                          " Message...."),
                    ),
                  ),
                  horizontalSpacer(10),
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      DateTime time = DateTime.now();
                      var validate = _formKey.currentState?.validate();
                      if (validate == true) {
                        _formKey.currentState?.save();
                        var message =
                            _formKey.currentState?.fields['text']?.value;
                        String chatRoomId = await FirestoreRepository()
                            .createChatRoomId(
                                widget.currentUser.id!, widget.invitedUser.id!);

                        await FirestoreRepository().sendMessage(
                            message: message,
                            currentUserId: widget.currentUser.id!,
                            chatRoomId: chatRoomId,
                            time: time);
                        Map<String, dynamic> lastMessageInfoMap = {
                          "lastMessage": message,
                          "lastMessageSendTime": time,
                          "lastMessageSendBy": widget.currentUser.id!,
                        };
                        FirestoreRepository().updateLastMessageSend(
                            chatRoomId, lastMessageInfoMap);
                        setState(() {
                          _formKey.currentState?.reset();
                        });
                        print('about to');
                        var token = await FirestoreRepository()
                            .getUserTokenbyid(widget.invitedUser.id!);
                        await NotificationRepository().sendInboxNotification(
                            message,
                            token,
                            '${widget.currentUser.lastName} ${widget.currentUser.firstName}');
                        print('done');
                      }
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration:
                          BoxDecoration(color: Yellow, shape: BoxShape.circle),
                      child: const Icon(
                        FontAwesomeIcons.paperPlane,
                        color: Colors.white,
                        size: 24,
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
      child: GroupedListView<QueryDocumentSnapshot<Object?>, DateTime>(
        padding: const EdgeInsets.all(8),
        reverse: true,
        order: GroupedListOrder.DESC,
        useStickyGroupSeparators: true,
        floatingHeader: true,
        elements: (snapshot.data!.docs),
        //(snapshot.data!.docs[0].get("message"))
        groupBy: (message) => DateTime(
          message.get("time").toDate().year,
          message.get("time").toDate().month,
          message.get("time").toDate().day,
        ),
        groupHeaderBuilder: (QueryDocumentSnapshot<Object?> snapshot) =>
            SizedBox(
          height: 40,
          child: Center(
            child: Card(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  DateFormat.yMMMd().format(snapshot.get("time").toDate()),
                  //style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        itemBuilder: (context, QueryDocumentSnapshot<Object?> snapshot) =>
            Align(
          alignment: currentUser.id == snapshot.get("sendBy")
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Padding(
            padding: currentUser.id == snapshot.get("sendBy")
                ? const EdgeInsets.only(left: 50, right: 8)
                : const EdgeInsets.only(right: 50, left: 8),
            child: Card(
              shape: currentUser.id == snapshot.get("sendBy")
                  ? const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25.0),
                          topLeft: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0)))
                  : const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25.0),
                          topLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0)),
                    ),
              //semanticContainer: false,
              color: currentUser.id == snapshot.get("sendBy")
                  ? Colors.white
                  : Yellow,
              elevation: 8,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Text(snapshot.get("message")),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
