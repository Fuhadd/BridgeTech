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
