// import 'package:flutter/material.dart';
// import 'package:urban_hive_test/Helpers/constants.dart';
// import 'package:urban_hive_test/Models/models.dart';
// import 'package:urban_hive_test/Widgets/constant_widget.dart';
// import 'package:urban_hive_test/Widgets/navigation_drawer.dart';

// class CandidateScreen1 extends StatelessWidget {
//   const CandidateScreen1({Key? key,required this.imageUrl,
//       required this.pageCount,
//       required this.pageNumber,
//       required this.pageController,
//       required this.buddyUser,
//       required this.mainUser}) : super(key: key);
//        final String imageUrl;
//   final AppUser? buddyUser, mainUser;
//   final int pageNumber;
//   final int? pageCount;
//   final PageController pageController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const NavigationDrawer(
//         pageIndex: 5,
//       ),
//       appBar: CustomAppar(context, 'Cadidate'),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 55,
//                     backgroundImage: NetworkImage(mainUser.imageUrl),
//                   ),
//                   horizontalSpacer(60),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         const TitleText(title: 'Anita Ike'),
//                         verticalSpacer(5),
//                         BodyText(
//                           title: 'Last Active 3 days ago',
//                           color: Colors.grey,
//                         ),
//                         verticalSpacer(5),
//                         BodyText(title: 'Lekki, Lagos, Nigeria')
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               verticalSpacer(30),
//               Container(
//                 decoration: BoxDecoration(border: Border.all()),
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   children: [
//                     SubTitleText(title: 'Intro'),
//                     verticalSpacer(10),
//                     Text(mainUser!.bio!),
//                     verticalSpacer(10),
//                     Row(
//                       children: [
//                         SizedBox(
//                             width: 150,
//                             child: SubTitleText(title: 'Technical:')),
//                         horizontalSpacer(50),
//                         SubTitleText(
//                           title: mainUser.Techical!,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ],
//                     ),
//                     verticalSpacer(10),
//                     Row(
//                       children: [
//                         SizedBox(
//                             width: 150,
//                             child: SubTitleText(title: 'Has Idea:')),
//                         horizontalSpacer(50),
//                         SubTitleText(
//                           title: mainUser.,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ],
//                     ),
//                     verticalSpacer(10),
//                     Row(
//                       children: [
//                         SizedBox(
//                             width: 150,
//                             child: SubTitleText(title: 'Commitment:')),
//                         horizontalSpacer(50),
//                         SubTitleText(
//                           title: User.users[0].commitment,
//                           fontWeight: FontWeight.normal,
//                         ),
//                         verticalSpacer(10),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               verticalSpacer(1),
//               Container(
//                 decoration: BoxDecoration(border: Border.all()),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Container(
//                         height: 100,
//                         decoration: BoxDecoration(border: Border.all()),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                             width: 150,
//                             color: Colors.black,
//                             child: const CustomButton(title: 'INVITE')),
//                         horizontalSpacer(5),
//                         Container(
//                             width: 150,
//                             color: Colors.black,
//                             child: const CustomButton(title: 'SAVE'))
//                       ],
//                     ),
//                     verticalSpacer(5),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                             width: 150,
//                             color: Colors.black,
//                             child: const CustomButton(title: 'SKIP')),
//                         horizontalSpacer(5),
//                         Container(
//                             width: 150,
//                             color: Colors.black,
//                             child: const CustomButton(title: 'HIDE'))
//                       ],
//                     ),
//                     verticalSpacer(20),
//                   ],
//                 ),
//               ),
//               verticalSpacer(30)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



//////////////////////so this is it
           // verticalSpacer(50),
            // Stack(
            //   clipBehavior: Clip.none,
            //   children: [
            //     Container(
            //       //color: Colors.blue,
            //       width: double.infinity,
            //       height: 230,
            //       decoration: BoxDecoration(
            //         boxShadow: const [
            //           // BoxShadow(
            //           //     blurRadius: 5,
            //           //     offset: Offset(5, 5),
            //           //     color: Colors.grey),
            //           BoxShadow(
            //               blurRadius: 7,
            //               offset: Offset(-7, -7),
            //               color: Colors.grey),
            //           //BoxShadow(color: white, offset: const Offset(5, 0)),
            //         ],
            //         borderRadius: BorderRadius.circular(25),
            //         // gradient: LinearGradient(colors: [
            //         //   // Yellow.withOpacity(0.7),
            //         //   // Yellow,
            //         // ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            //         //border: Border.all(),
            //         color: const Color(0xfff4a50c),
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.only(bottom: 25),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             CustomSubTitleText(
            //               title:
            //                   '${widget.buddyUser?.lastName} ${widget.buddyUser?.firstName}',
            //               color: Colors.white,
            //               size: 25,
            //             ),
            //             verticalSpacer(10),
            //             CustomSubTitleText(
            //               fontWeight: FontWeight.w100,
            //               title: widget.buddyUser?.skills?[0],
            //               color: Colors.white,
            //               size: 19,
            //             ),
            //             verticalSpacer(20),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: const [
            //                 SmallCustomRowButton(
            //                     icon: FontAwesomeIcons.locationDot,
            //                     title: 'Nigeria'),
            //                 // SmallCustomRowButton(
            //                 //     icon: FontAwesomeIcons.phone,
            //                 //     title: (widget.buddyUser!.phone).toString()),
            //                 // horizontalSpacer(20),
            //               ],
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //     Positioned(
            //       top: -30,
            //       left: 0,
            //       right: 0,
            //       child: Center(
            //         child: Stack(
            //           alignment: AlignmentDirectional.center,
            //           children: [
            //             Container(
            //               height: 80,
            //               width: 80,
            //               decoration: BoxDecoration(
            //                 color: Yellow,
            //                 shape: BoxShape.circle,
            //               ),
            //             ),
            //             Container(
            //               height: 70,
            //               width: 70,
            //               decoration: BoxDecoration(
            //                 color: Yellow,
            //                 shape: BoxShape.circle,
            //                 image: DecorationImage(
            //                     image: NetworkImage(widget.buddyUser!.imageUrl),
            //                     fit: BoxFit.cover),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // verticalSpacer(30),
            // Container(
            //     height: 100,
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     width: double.infinity,
            //     color: Colors.white,
            //     child: FittedBox(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           DiscoveredColumn(
            //               title: 'Technical',
            //               child: widget.buddyUser!.technical == "1"
            //                   ? Icon(
            //                       FontAwesomeIcons.circleCheck,
            //                       color: Yellow,
            //                     )
            //                   : Icon(
            //                       FontAwesomeIcons.circle,
            //                       color: Yellow,
            //                     )),
            //           horizontalSpacer(10),
            //           const VerticalDivider(
            //             indent: 20,
            //             endIndent: 20,
            //             color: Colors.grey,
            //             thickness: 1,
            //           ),
            //           horizontalSpacer(10),
            //           DiscoveredColumn(
            //             title: 'Commitment (hrs)',
            //             child: CustomSubTitleText(
            //                 title: '20', color: Yellow, size: 19),
            //           ),
            //           horizontalSpacer(20),
            //         ],
            //       ),
            //     )),
            // verticalSpacer(20),
            // CustomSubTitleText(
            //   align: true,
            //   title: 'General Information',
            //   color: Colors.black,
            // ),
            // verticalSpacer(15),
            // CustomBioText(
            //   align: true,
            //   title: widget.buddyUser!.bio!,
            //   color: Colors.black,
            // ),
            // // GestureDetector(
            // //     onTap: (() =>
            // //         _showBottomSheet(context, buddyUser: widget.buddyUser)),
            // //     child: _UserInfoCard('title')),
            // verticalSpacer(30),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       SmallCustomAcceptButton(
            //           onTap: (() async {
            //             List<String> matchedId = [];
            //             List<String> buddyId = [];
            //             await FirestoreRepository().initializeMatches(
            //               currentUserId: widget.mainUser!.id!,
            //               invitedUserId: widget.buddyUser!.id!,
            //               time: DateTime.now(),
            //             );
            //             final id = widget.buddyUser!.id;
            //             matchedId.add(id!);

            //             final buddyid = widget.buddyUser!.id!;
            //             buddyId.add(buddyid);
            //             FirestoreRepository().saveMatched(matchedId);
            //             FirestoreRepository()
            //                 .saveMatchedBuddy(buddyid, buddyId);
            //             Future.delayed(Duration.zero, () {
            //               //Navigator.of(context).pop();
            //               ScaffoldMessenger.of(context)
            //                 ..removeCurrentSnackBar()
            //                 ..showSnackBar(SnackBar(
            //                   content: Text(
            //                       "Invite sent to ${widget.buddyUser!.lastName} has been sent successfully"),
            //                   backgroundColor: Yellow,
            //                 ));
            //             });
            //             int? initialPage =
            //                 await SharedPreferenceHelper().getPageIndex() ?? 0;
            //             Navigator.of(context).pushReplacement(
            //               MaterialPageRoute(
            //                 builder: (context) => DiscoverTestScreen(
            //                     currentUser: widget.mainUser!,
            //                     initialPage: initialPage),
            //               ),
            //             );

            //             // if (pageNumber == pageCount! - 1) {
            //             //   pageController.animateToPage(0,
            //             //       duration: Duration(milliseconds: 10),
            //             //       curve: Curves.easeOutQuart);
            //             // } else {
            //             //   pageController.nextPage(
            //             //       duration: Duration(milliseconds: 500),
            //             //       curve: Curves.easeIn);
            //             // }
            //           }),

            //           isaccept: true,
            //           icon: FontAwesomeIcons.checkDouble,
            //           title: 'Invite'),
            //       horizontalSpacer(25),
            //       SmallCustomAcceptButton(
            //           onTap: (() async {
            //             SharedPreferenceHelper()
            //                 .savePageIndex(widget.pageNumber);
            //             if (widget.pageNumber == widget.pageCount! - 1) {
            //               widget.pageController.animateToPage(0,
            //                   duration: const Duration(milliseconds: 10),
            //                   curve: Curves.easeOutQuart);
            //             } else {
            //               widget.pageController.nextPage(
            //                   duration: const Duration(milliseconds: 500),
            //                   curve: Curves.easeIn);
            //             }
            //           }),

            //           isaccept: false,
            //           icon: FontAwesomeIcons.xmark,
            //           title: 'Skip'),
            //     ],
            //   ),
            // ),