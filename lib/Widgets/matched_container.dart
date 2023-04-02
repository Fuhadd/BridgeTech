import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urban_hive_test/Screens/view_other_profiles.dart';

import '../Config/Repositories/firestore_repository.dart';
import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Models/models.dart';
import '../Screens/chat_screen.dart';
import 'constant_widget.dart';

class MatchContainer extends StatelessWidget {
  const MatchContainer({
    required this.matchTime,
    required this.buddyUser,
    required this.mainUser,
    required this.chatRoomId,
    required this.lastMessage,
    required this.myUsername,
    Key? key,
  }) : super(key: key);
  final String lastMessage, chatRoomId, myUsername;
  final AppUser? buddyUser, mainUser;
  final String matchTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                blurRadius: 7, offset: Offset(-7, -7), color: Colors.grey),
          ],
          borderRadius: BorderRadius.circular(15),
          // color: const Color(0xfff4a50c),
          color: Colors.white
          // gradient: LinearGradient(
          //     colors: [Colors.grey.shade400, Yellow],
          //     begin: Alignment.topRight,
          //     end: Alignment.bottomLeft),
          ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xfff4a50c),
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    buddyUser!.imageUrl,
                  ),
                ),
              ),
              horizontalSpacer(18),
              CustomSubTitleText(
                title: '${buddyUser!.lastName} ${buddyUser!.firstName}',
                color: const Color(0xFF2B2E4A),
                size: 25,
              ),
            ],
          ),
          verticalSpacer(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SubTitleText(title: buddyUser!.skills![0]),
                  ],
                ),
              ],
            ),
          ),
          verticalSpacer(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    buddyUser!.technical == "1"
                        ? const Icon(
                            FontAwesomeIcons.circleCheck,
                            color: Colors.grey,
                          )
                        : const Icon(
                            FontAwesomeIcons.circle,
                            color: Colors.grey,
                          ),
                    Text(
                      "Technical",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      FontAwesomeIcons.locationDot,
                      color: Colors.grey,
                    ),
                    Text(
                      "Nigeria",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ],
            ),
          ),
          verticalSpacer(25),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              buddyUser!.bio.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 17, fontWeight: FontWeight.normal),
            ),
          ),
          verticalSpacer(35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallCustomButton1(
                    onTap: (() async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ViewOtherProfiles(
                            buddyUser: buddyUser!,
                            mainUser: mainUser!,
                          ),
                        ),
                      );
                    }),
                    isaccept: false,
                    icon: FontAwesomeIcons.idCard,
                    title: 'Profile'),
                SmallCustomButton1(
                    onTap: (() async {
                      String chatRoomId = await FirestoreRepository()
                          .createChatRoomId(buddyUser!.id!, mainUser!.id!);

                      await FirestoreRepository()
                          .openChatroom(buddyUser!.id!, mainUser!.id!);
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
                    isaccept: true,
                    icon: FontAwesomeIcons.checkDouble,
                    title: 'Chat'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MatchRequestContainer extends StatelessWidget {
  const MatchRequestContainer({
    required this.matchTime,
    required this.buddyUser,
    required this.mainUser,
    required this.chatRoomId,
    required this.lastMessage,
    required this.myUsername,
    Key? key,
  }) : super(key: key);
  final String lastMessage, chatRoomId, myUsername;
  final AppUser? buddyUser, mainUser;
  final String matchTime;

  @override
  Widget build(BuildContext context) {
    FirestoreRepository firestoreRepository = FirestoreRepository();
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(blurRadius: 7, offset: Offset(-7, -7), color: Colors.grey),
        ],
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        // gradient: LinearGradient(
        //     colors: [Colors.grey.shade400, Yellow],
        //     begin: Alignment.topRight,
        //     end: Alignment.bottomLeft),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xfff4a50c),
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    buddyUser!.imageUrl,
                  ),
                ),
              ),
              horizontalSpacer(18),
              CustomSubTitleText(
                title: '${buddyUser!.lastName} ${buddyUser!.firstName}',
                color: const Color(0xFF2B2E4A),
                size: 25,
              ),
            ],
          ),
          verticalSpacer(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SubTitleText(title: buddyUser!.skills![0]),
                  ],
                ),
              ],
            ),
          ),
          verticalSpacer(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    buddyUser!.technical == "1"
                        ? const Icon(
                            FontAwesomeIcons.circleCheck,
                            color: Colors.grey,
                          )
                        : const Icon(
                            FontAwesomeIcons.circle,
                            color: Colors.grey,
                          ),
                    Text(
                      "Technical",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      FontAwesomeIcons.locationDot,
                      color: Colors.grey,
                      // color: Yellow,
                    ),
                    Text(
                      "Nigeria",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ],
            ),
          ),
          verticalSpacer(25),
          Text(
            buddyUser!.bio.toString(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 17, fontWeight: FontWeight.normal),
          ),
          verticalSpacer(35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallCustomButton1(
                    onTap: (() async {
                      String matchId = await FirestoreRepository()
                          .createChatRoomId(buddyUser!.id!, mainUser!.id!);
                      await firestoreRepository.rejectInvite(matchId);
                    }),
                    isaccept: false,
                    icon: FontAwesomeIcons.xmark,
                    title: 'Decline'),
                SmallCustomButton1(
                    onTap: (() async {
                      String matchId = await FirestoreRepository()
                          .createChatRoomId(buddyUser!.id!, mainUser!.id!);
                      await firestoreRepository.acceptInvite(matchId);
                    }),
                    isaccept: true,
                    icon: FontAwesomeIcons.checkDouble,
                    title: 'Accept'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MatchFailedContainer extends StatelessWidget {
  const MatchFailedContainer({
    required this.matchTime,
    required this.buddyUser,
    required this.mainUser,
    required this.chatRoomId,
    required this.lastMessage,
    required this.myUsername,
    Key? key,
  }) : super(key: key);
  final String lastMessage, chatRoomId, myUsername;
  final AppUser? buddyUser, mainUser;
  final String matchTime;

  @override
  Widget build(BuildContext context) {
    FirestoreRepository firestoreRepository = FirestoreRepository();
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(blurRadius: 7, offset: Offset(-7, -7), color: Colors.grey),
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
            colors: [Colors.grey.shade400, Yellow],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  buddyUser!.imageUrl,
                ),
              ),
              horizontalSpacer(18),
              CustomSubTitleText(
                title: '${buddyUser!.lastName} ${buddyUser!.firstName}',
                color: const Color(0xFF2B2E4A),
                size: 25,
              ),
            ],
          ),
          verticalSpacer(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SubTitleText(title: buddyUser!.skills![0]),
                  ],
                ),
              ],
            ),
          ),
          verticalSpacer(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    buddyUser!.technical == "1"
                        ? const Icon(
                            FontAwesomeIcons.circleCheck,
                            color: Colors.grey,
                          )
                        : const Icon(
                            FontAwesomeIcons.circle,
                            color: Colors.grey,
                          ),
                    Text(
                      "Technical",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.locationDot,
                      color: Yellow,
                    ),
                    Text(
                      "Nigeria",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ],
            ),
          ),
          verticalSpacer(25),
          Text(
            buddyUser!.bio.toString(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 17, fontWeight: FontWeight.normal),
          ),
          verticalSpacer(35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallCustomAcceptButton(
                    onTap: (() async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ViewOtherProfiles(
                            buddyUser: buddyUser!,
                            mainUser: mainUser!,
                          ),
                        ),
                      );
                    }),
                    isaccept: false,
                    icon: FontAwesomeIcons.xmark,
                    title: 'Profile'),
                SmallCustomAcceptButton(
                    onTap: (() async {
                      firestoreRepository.initializeMatches(
                        currentUserId: mainUser!.id!,
                        invitedUserId: buddyUser!.id!,
                        time: DateTime.now(),
                      );
                    }),
                    isaccept: true,
                    icon: FontAwesomeIcons.checkDouble,
                    title: 'Retry'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TestContainer extends StatelessWidget {
  TestContainer({
    required this.snapshot,
    required this.index,
    Key? key,
  }) : super(key: key);
  AsyncSnapshot<QuerySnapshot> snapshot;
  int index;

  @override
  Widget build(BuildContext context) {
    FirestoreRepository firestoreRepository = FirestoreRepository();
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(blurRadius: 7, offset: Offset(-7, -7), color: Colors.grey),
        ],
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xfff4a50c),
        // gradient: LinearGradient(
        //     colors: [Colors.grey.shade400, Yellow],
        //     begin: Alignment.topRight,
        //     end: Alignment.bottomLeft),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage(snapshot.data!.docs[index].get("imageUrl")),
              ),
              horizontalSpacer(18),
              CustomSubTitleText(
                title:
                    '${snapshot.data!.docs[index].get("lastName")} ${snapshot.data!.docs[index].get("firstName")}',
                color: const Color(0xFF2B2E4A),
                size: 25,
              ),
            ],
          ),
          verticalSpacer(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SubTitleText(
                        title: snapshot.data!.docs[index].get("skills")[0]),
                  ],
                ),
              ],
            ),
          ),
          verticalSpacer(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    snapshot.data!.docs[index].get("technical") == "1"
                        ? const Icon(
                            FontAwesomeIcons.circleCheck,
                            color: Colors.grey,
                          )
                        : const Icon(
                            FontAwesomeIcons.circle,
                            color: Colors.grey,
                          ),
                    Text(
                      "Technical",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.locationDot,
                      color: Yellow,
                    ),
                    Text(
                      "Nigeria",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ],
            ),
          ),
          verticalSpacer(25),
          Text(
            snapshot.data!.docs[index].get("bio").toString(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 17, fontWeight: FontWeight.normal),
          ),
          verticalSpacer(35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallCustomAcceptButton(
                    onTap: (() async {}),
                    isaccept: false,
                    icon: FontAwesomeIcons.xmark,
                    title: 'Profile'),
                SmallCustomAcceptButton(
                    onTap: (() async {}),
                    isaccept: true,
                    icon: FontAwesomeIcons.checkDouble,
                    title: 'Retry'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SentRequestContainer extends StatelessWidget {
  const SentRequestContainer({
    required this.matchTime,
    required this.buddyUser,
    required this.mainUser,
    required this.chatRoomId,
    required this.lastMessage,
    required this.myUsername,
    Key? key,
  }) : super(key: key);
  final String lastMessage, chatRoomId, myUsername;
  final AppUser? buddyUser, mainUser;
  final String matchTime;

  @override
  Widget build(BuildContext context) {
    FirestoreRepository firestoreRepository = FirestoreRepository();
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(blurRadius: 7, offset: Offset(-7, -7), color: Colors.grey),
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
            colors: [Colors.grey.shade400, Yellow],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  buddyUser!.imageUrl,
                ),
              ),
              horizontalSpacer(18),
              CustomSubTitleText(
                title: '${buddyUser!.lastName} ${buddyUser!.firstName}',
                color: const Color(0xFF2B2E4A),
                size: 25,
              ),
            ],
          ),
          verticalSpacer(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SubTitleText(title: buddyUser!.skills![0]),
                  ],
                ),
              ],
            ),
          ),
          verticalSpacer(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    buddyUser!.technical == "1"
                        ? const Icon(
                            FontAwesomeIcons.circleCheck,
                            color: Colors.grey,
                          )
                        : const Icon(
                            FontAwesomeIcons.circle,
                            color: Colors.grey,
                          ),
                    Text(
                      "Technical",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.locationDot,
                      color: Yellow,
                    ),
                    Text(
                      "Nigeria",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ],
            ),
          ),
          verticalSpacer(25),
          Text(
            buddyUser!.bio.toString(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 17, fontWeight: FontWeight.normal),
          ),
          verticalSpacer(35),
        ],
      ),
    );
  }
}
