import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urban_hive_test/Config/Repositories/firestore_repository.dart';
import 'package:urban_hive_test/Helpers/constants.dart';
import 'package:urban_hive_test/Helpers/sharedPrefs.dart';
import 'package:urban_hive_test/Screens/discover_test.dart';

import 'package:urban_hive_test/Widgets/constant_widget.dart';

import '../Config/Repositories/notification_repository.dart';
import '../Helpers/colors.dart';
import '../Models/models.dart';

class DiscoverScreenWidget extends StatefulWidget {
  const DiscoverScreenWidget(
      {Key? key,
      required this.imageUrl,
      required this.pageCount,
      required this.pageNumber,
      required this.pageController,
      required this.buddyUser,
      required this.mainUser})
      : super(key: key);

  final String imageUrl;
  final AppUser? buddyUser, mainUser;
  final int pageNumber;
  final int? pageCount;
  final PageController pageController;

  @override
  State<DiscoverScreenWidget> createState() => _DiscoverScreenWidgetState();
}

class _DiscoverScreenWidgetState extends State<DiscoverScreenWidget> {
  @override
  Widget build(BuildContext context) {
    bool loading = false;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            verticalSpacer(40),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 7,
                          offset: Offset(-7, -7),
                          color: Colors.white),
                    ],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        verticalSpacer(25),
                        CustomSubTitleText(
                          title:
                              '${widget.buddyUser?.lastName} ${widget.buddyUser?.firstName}',
                          color: Colors.black,
                          size: 25,
                        ),
                        verticalSpacer(10),
                        CustomSubTitleText(
                          fontWeight: FontWeight.w100,
                          title: widget.buddyUser?.skills?[0],
                          color: Colors.black,
                          size: 19,
                        ),
                        verticalSpacer(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SmallCustomRowButton(
                                icon: FontAwesomeIcons.locationDot,
                                title: 'Nigeria'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -30,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Yellow,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Yellow,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(widget.buddyUser!.imageUrl),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                color: Colors.white,
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DiscoveredColumn(
                          title: 'Technical',
                          child: widget.buddyUser!.technical == "1"
                              ? Icon(
                                  FontAwesomeIcons.circleCheck,
                                  color: Yellow,
                                )
                              : Icon(
                                  FontAwesomeIcons.circle,
                                  color: Yellow,
                                )),
                      horizontalSpacer(10),
                      const VerticalDivider(
                        indent: 20,
                        endIndent: 20,
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      horizontalSpacer(10),
                      DiscoveredColumn(
                        title: 'Commitment (hrs)',
                        child: CustomSubTitleText(
                            title: '20', color: Yellow, size: 19),
                      ),
                      horizontalSpacer(20),
                    ],
                  ),
                )),
            verticalSpacer(20),
            CustomSubTitleText(
              align: true,
              title: 'General Information',
              color: Colors.black,
            ),
            verticalSpacer(15),
            SingleChildScrollView(
              child: SizedBox(
                height: 100,
                child: CustomBioText(
                  align: true,
                  title: widget.buddyUser!.bio!,
                  color: Colors.black,
                ),
              ),
            ),
            verticalSpacer(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallCustomLoadingButton(
                    onTap: (() async {
                      print(loading);
                      setState(() {
                        loading = true;
                      });
                      print(loading);

                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Loading'),
                                content:
                                    SizedBox(height: 100, child: loaderBlack()),
                                backgroundColor: Colors.white.withOpacity(0.6),
                              ));

                      List<String> matchedId = [];
                      List<String> buddyId = [];
                      String message =
                          'Hello, I will like to connect with you. Kindly accept my invite. Cheers!';
                      await FirestoreRepository().initializeMatches(
                        currentUserId: widget.mainUser!.id!,
                        invitedUserId: widget.buddyUser!.id!,
                        time: DateTime.now(),
                      );
                      final id = widget.buddyUser!.id;
                      matchedId.add(id!);

                      final buddyid = widget.buddyUser!.id!;
                      buddyId.add(buddyid);
                      FirestoreRepository().saveMatched(matchedId);
                      FirestoreRepository().saveMatchedBuddy(buddyid, buddyId);
                      await sendInviteMessage(
                          message, widget.mainUser!, widget.buddyUser!);
                      Future.delayed(Duration.zero, () {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text(
                                "Invite sent to ${widget.buddyUser!.lastName} has been sent successfully"),
                            backgroundColor: Colors.black,
                          ));
                      });
                      int? initialPage =
                          await SharedPreferenceHelper().getPageIndex() ?? 0;
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => DiscoverTestScreen(
                              currentUser: widget.mainUser!,
                              initialPage: initialPage),
                        ),
                      );
                    }),
                    title: CustomSubTitleText(
                      fontWeight: FontWeight.w100,
                      title: 'Invite',
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  horizontalSpacer(25),
                  SmallCustomAcceptButton1(
                      onTap: (() async {
                        SharedPreferenceHelper()
                            .savePageIndex(widget.pageNumber);
                        if (widget.pageNumber == widget.pageCount! - 1) {
                          widget.pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 10),
                              curve: Curves.easeOutQuart);
                        } else {
                          widget.pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        }
                      }),
                      title: 'Skip'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> sendInviteMessage(
    String message, AppUser currentUser, AppUser invitedUser) async {
  DateTime time = DateTime.now();

  String chatRoomId = await FirestoreRepository()
      .createChatRoomId(currentUser.id!, invitedUser.id!);

  await FirestoreRepository().sendMessage(
      message: message,
      currentUserId: currentUser.id!,
      chatRoomId: chatRoomId,
      time: time);
  Map<String, dynamic> lastMessageInfoMap = {
    "chatRoomId": chatRoomId,
    "lastMessage": message,
    "lastMessageSendTime": time,
    "lastMessageSendBy": currentUser.id!,
    "users": [currentUser.id!, invitedUser.id!]
  };
  UnreadModel? unreadDetails = await FirestoreRepository().getUserunreadbyid(
      currentUserId: currentUser.id!, invitedUserId: invitedUser.id!);
  FirestoreRepository().updateLastMessageSend(chatRoomId, lastMessageInfoMap);
  FirestoreRepository().updateUnreadCount(
      unreadBy: currentUser.id!, chatRoomId: chatRoomId, unreadCount: 1);

  var token = await FirestoreRepository().getUserTokenbyid(invitedUser.id!);
  await NotificationRepository().sendInboxNotification(
      message, token, '${currentUser.lastName} ${currentUser.firstName}');
  print('done');
}

Container _UserInfoCard(String title) {
  return Container(
    height: 70,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.user,
                  color: Colors.grey,
                  size: 19,
                ),
                horizontalSpacer(10),
                CustomSubTitleText(
                  title: 'Personal Information',
                  color: Colors.grey,
                  size: 19,
                ),
                horizontalSpacer(10),
              ],
            ),
            const Icon(
              FontAwesomeIcons.angleRight,
              color: Colors.grey,
            )
          ],
        ),
      ),
    ),
  );
}

class DiscoveredColumn extends StatelessWidget {
  const DiscoveredColumn({Key? key, required this.child, required this.title})
      : super(key: key);
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSubTitleText(
          title: title,
          color: Colors.black,
          size: 20,
        ),
        verticalSpacer(9),
        child,
      ],
    );
  }
}

Future<dynamic> _showBottomSheet(BuildContext context, {AppUser? buddyUser}) {
  return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSubTitleText(
                title: 'About ${buddyUser?.lastName}',
                color: const Color(0xFF2B2E4A),
              ),
              CustomSubTitleText(
                align: true,
                title: buddyUser!.bio!,
                color: Colors.grey,
                size: 16,
              )
            ],
          ),
        );
      });
}
