// import 'dart:ui';

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:urban_hive_test/Config/Repositories/firestore_repository.dart';
// import 'package:urban_hive_test/Helpers/constants.dart';
// import 'package:urban_hive_test/Helpers/sharedPrefs.dart';
// import 'package:urban_hive_test/Screens/chat_screen.dart';
// import 'package:urban_hive_test/Widgets/constant_widget.dart';
// import 'package:urban_hive_test/Widgets/custom_curved_appbar.dart';

// import '../Helpers/colors.dart';
// import '../Models/models.dart';
// import '../Widgets/navigation_drawer.dart';
// import '../Widgets/shimmer_widget.dart';

// // class DiscoverScreen extends StatefulWidget {
// //   const DiscoverScreen({Key? key,required this.currentUser}) : super(key: key);
// //   final AppUser currentUser;

// //   @override
// //   State<DiscoverScreen> createState() => _DiscoverScreenState();
// // }

// class DiscoverScreen extends StatefulWidget {
//   DiscoverScreen({Key? key, required this.currentUser}) : super(key: key);
//   static const routeName = '/usermatches';
//   final AppUser currentUser;
//   int? pageIndex = 0;

//   @override
//   State<DiscoverScreen> createState() => _DiscoverScreenState();
// }

// class _DiscoverScreenState extends State<DiscoverScreen> {
//   int? pageNumber = 0;
//   PageController _pageController = PageController(initialPage: 0);

//   getMyInfoFromSharedPreference() async {
//     pageNumber = await SharedPreferenceHelper().getPageIndex();
//     final _pageController = PageController(initialPage: pageNumber ?? 0);

//     setState(() {});
//   }

//   onScreenLoaded() async {
//     await getMyInfoFromSharedPreference();
//   }

//   @override
//   void initState() {
//     onScreenLoaded();
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     String imageUrl =
//         'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDIwfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60';
//     FirestoreRepository firestoreRepository = FirestoreRepository();
//     return SafeArea(
//       child: Scaffold(
//           drawer: NavigationDrawer(
//             pageIndex: 5,
//             // user: widget.currentUser,
//           ),
//           appBar:
//               MessageAppar(context, 'Discover', widget.currentUser.imageUrl),
//           body: FutureBuilder<List<AppUser?>>(
//             future: firestoreRepository.getAllUsers(widget.currentUser.id!),
//             builder: (BuildContext context, snapshot) {
//               if (snapshot.hasError) {
//                 return Text("Something went wrong");
//               }

//               if (snapshot.data == null) {
//                 return loader();
//               }

//               if (snapshot.connectionState == ConnectionState.done &&
//                   snapshot.hasData &&
//                   snapshot.data != null) {
//                 final user = snapshot.data?.toList();

//                 return PageView.builder(
//                   onPageChanged: (value) =>
//                       print("${value}, totla: ${user?.length}"),
//                   physics: new NeverScrollableScrollPhysics(),
//                   controller: _pageController,
//                   dragStartBehavior: DragStartBehavior.down,
//                   itemCount: user?.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     //   print(user?[index]!.technical);
//                     return DiscoverWidget(
//                       pageCount: user?.length,
//                       pageNumber: index,
//                       pageController: _pageController,
//                       imageUrl: imageUrl,
//                       widget: widget,
//                       user: user?[index],
//                     );
//                   },
//                 );
//                 //DiscoverWidget(imageUrl: imageUrl, widget: widget);
//               }

//               return loader();
//             },
//           )),
//     );
//   }
// }

// class DiscoverWidget extends StatelessWidget {
//   const DiscoverWidget(
//       {Key? key,
//       required this.imageUrl,
//       required this.pageCount,
//       required this.widget,
//       required this.pageNumber,
//       required this.pageController,
//       required this.user})
//       : super(key: key);

//   final String imageUrl;
//   final AppUser? user;
//   final int pageNumber;
//   final int? pageCount;
//   final PageController pageController;
//   final DiscoverScreen widget;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           children: [
//             verticalSpacer(50),
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   //color: Colors.blue,
//                   width: double.infinity,
//                   height: 230,
//                   decoration: BoxDecoration(
//                     boxShadow: const [
//                       // BoxShadow(
//                       //     blurRadius: 5,
//                       //     offset: Offset(5, 5),
//                       //     color: Colors.grey),
//                       BoxShadow(
//                           blurRadius: 7,
//                           offset: Offset(-7, -7),
//                           color: Colors.grey),
//                       //BoxShadow(color: white, offset: const Offset(5, 0)),
//                     ],
//                     borderRadius: BorderRadius.circular(25),
//                     // gradient: LinearGradient(colors: [
//                     //   // Yellow.withOpacity(0.7),
//                     //   // Yellow,
//                     // ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//                     //border: Border.all(),
//                     color: const Color.fromRGBO(255, 189, 89, 1),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(bottom: 25),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         CustomSubTitleText(
//                           title: '${user?.lastName} ${user?.firstName}',
//                           color: Colors.white,
//                           size: 25,
//                         ),
//                         verticalSpacer(10),
//                         CustomSubTitleText(
//                           fontWeight: FontWeight.w100,
//                           title: user?.skills?[0],
//                           color: Colors.white,
//                           size: 19,
//                         ),
//                         verticalSpacer(20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             horizontalSpacer(20),
//                             const SmallCustomRowButton(
//                                 icon: FontAwesomeIcons.locationDot,
//                                 title: 'Nigeria'),
//                             SmallCustomRowButton(
//                                 icon: FontAwesomeIcons.phone,
//                                 title: (user!.phone).toString()),
//                             horizontalSpacer(20),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: -30,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: Stack(
//                       alignment: AlignmentDirectional.center,
//                       children: [
//                         Container(
//                           height: 80,
//                           width: 80,
//                           decoration: BoxDecoration(
//                             color: Yellow,
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         Container(
//                           height: 70,
//                           width: 70,
//                           decoration: BoxDecoration(
//                             color: Yellow,
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: NetworkImage(user!.imageUrl),
//                                 fit: BoxFit.cover),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             verticalSpacer(30),
//             Container(
//                 height: 100,
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 width: double.infinity,
//                 color: Colors.white,
//                 child: FittedBox(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       DiscoveredColumn(
//                           title: 'Technical',
//                           child: user!.technical == "1"
//                               ? Icon(
//                                   FontAwesomeIcons.circleCheck,
//                                   color: Yellow,
//                                 )
//                               : Icon(
//                                   FontAwesomeIcons.circle,
//                                   color: Yellow,
//                                 )),
//                       horizontalSpacer(10),
//                       VerticalDivider(
//                         indent: 20,
//                         endIndent: 20,
//                         color: Colors.grey,
//                         thickness: 1,
//                       ),
//                       horizontalSpacer(10),
//                       DiscoveredColumn(
//                         title: 'Commitment (hrs)',
//                         child: CustomSubTitleText(
//                             title: '20', color: Yellow, size: 19),
//                       ),
//                       horizontalSpacer(20),
//                     ],
//                   ),
//                 )),
//             verticalSpacer(30),
//             CustomSubTitleText(
//               align: true,
//               title: 'General Information',
//               color: Color(0xFF2B2E4A),
//             ),
//             verticalSpacer(25),
//             GestureDetector(
//                 onTap: (() => _showBottomSheet(context, user: user)),
//                 child: _UserInfoCard('title')),
//             verticalSpacer(30),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SmallCustomAcceptButton(
//                       onTap: (() async {
//                         List<String> matchedId = [];
//                         await FirestoreRepository().initializeMatches(
//                           currentUserId: widget.currentUser.id!,
//                           invitedUserId: user!.id!,
//                           time: DateTime.now(),
//                         );
//                         final id = user!.id;
//                         matchedId.add(id!);
//                         FirestoreRepository().saveMatched(matchedId);

//                         // String chatRoomId = await FirestoreRepository()
//                         //     .createChatRoomId(
//                         //         widget.currentUser.id!, user!.id!);

//                         // await FirestoreRepository()
//                         //     .openChatroom(widget.currentUser.id!, user!.id!);
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //       builder: (context) => ChatScreen(
//                         //             currentUser: widget.currentUser,
//                         //             invitedUser: user!,
//                         //             chatRoomId: chatRoomId,
//                         //           )),
//                         // );
//                       }),
//                       isaccept: true,
//                       icon: FontAwesomeIcons.checkDouble,
//                       title: 'Invite'),
//                   horizontalSpacer(25),
//                   SmallCustomAcceptButton(
//                       onTap: (() async {
//                         SharedPreferenceHelper().savePageIndex(pageNumber);
//                         if (pageNumber == pageCount! - 1) {
//                           pageController.animateToPage(0,
//                               duration: Duration(milliseconds: 10),
//                               curve: Curves.easeOutQuart);
//                         } else {
//                           pageController.nextPage(
//                               duration: Duration(milliseconds: 500),
//                               curve: Curves.easeIn);
//                         }

//                         // FirestoreRepository().getChatsPlusUser();
//                       }),
//                       isaccept: false,
//                       icon: FontAwesomeIcons.xmark,
//                       title: 'Skip'),
//                 ],
//               ),
//             ),
//             // SmallCustomAcceptButton(
//             //     onTap: (() async {
//             //       FirestoreRepository().initializeMatches(
//             //         currentUserId: widget.currentUser.id!,
//             //         invitedUserId: user!.id!,
//             //         time: DateTime.now(),
//             //       );
//             //       // FirestoreRepository().getChatsPlusUser();
//             //     }),
//             //     isaccept: false,
//             //     icon: FontAwesomeIcons.xmark,
//             //     title: 'Invite'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Container _UserInfoCard(String title) {
//   return Container(
//     height: 70,
//     width: double.infinity,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       color: Colors.white,
//     ),
//     child: Card(
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Icon(
//                   FontAwesomeIcons.user,
//                   color: Colors.grey,
//                   size: 19,
//                 ),
//                 horizontalSpacer(10),
//                 CustomSubTitleText(
//                   title: 'Personal Information',
//                   color: Colors.grey,
//                   size: 19,
//                 ),
//                 horizontalSpacer(10),
//               ],
//             ),
//             Icon(
//               FontAwesomeIcons.angleRight,
//               color: Colors.grey,
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }

// class DiscoveredColumn extends StatelessWidget {
//   const DiscoveredColumn({Key? key, required this.child, required this.title})
//       : super(key: key);
//   final String title;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CustomSubTitleText(
//           title: title,
//           color: Colors.grey,
//           size: 20,
//         ),
//         verticalSpacer(9),
//         child,
//       ],
//     );
//   }
// }

// Future<dynamic> _showBottomSheet(BuildContext context, {AppUser? user}) {
//   return showModalBottomSheet(
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       context: context,
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               CustomSubTitleText(
//                 title: 'About ${user?.lastName}',
//                 color: Color(0xFF2B2E4A),
//               ),
//               CustomSubTitleText(
//                 align: true,
//                 title: user!.bio!,
//                 color: Colors.grey,
//                 size: 16,
//               )
//             ],
//           ),
//         );
//       });
// }
