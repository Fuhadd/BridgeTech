// import 'package:flutter/material.dart';
// import 'package:urban_hive_test/Helpers/colors.dart';
// import 'package:urban_hive_test/Helpers/constants.dart';
// import 'package:urban_hive_test/Models/models.dart';
// import 'package:urban_hive_test/Widgets/constant_widget.dart';
// import 'package:urban_hive_test/Widgets/navigation_drawer.dart';

// class CandidateScreen extends StatelessWidget {
//   const CandidateScreen({Key? key, required this.currentUser})
//       : super(key: key);
//   static const routeName = '/candidates';
//   final AppUser currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: background,
//       drawer: NavigationDrawer(
//         pageIndex: 5,
//         user: currentUser,
//       ),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 55,
//                     backgroundImage: NetworkImage(User.users[0].imageUrl),
//                   ),
//                   horizontalSpacer(25),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         TitleText(title: 'Anita Ike'),
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
//                 padding: EdgeInsets.all(10),
//                 child: Column(
//                   children: [
//                     SubTitleText(title: 'About'),
//                     verticalSpacer(10),
//                     Text(User.users[0].bio),
//                     verticalSpacer(10),
//                     Row(
//                       children: [
//                         Container(
//                             width: 150,
//                             child: SubTitleText(title: 'Technical:')),
//                         horizontalSpacer(50),
//                         SubTitleText(
//                           title: User.users[0].hasTechical,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ],
//                     ),
//                     verticalSpacer(10),
//                     Row(
//                       children: [
//                         Container(
//                             width: 150,
//                             child: SubTitleText(title: 'Has Idea:')),
//                         horizontalSpacer(50),
//                         SubTitleText(
//                           title: User.users[0].hasIdea,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ],
//                     ),
//                     verticalSpacer(10),
//                     Row(
//                       children: [
//                         Container(
//                             width: 150,
//                             child: FittedBox(
//                                 child: SubTitleText(title: 'Commitment:'))),
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
//                             child: CustomButton(title: 'INVITE')),
//                         horizontalSpacer(5),
//                         Container(
//                             width: 150,
//                             color: Colors.black,
//                             child: CustomButton(title: 'SAVE'))
//                       ],
//                     ),
//                     verticalSpacer(5),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                             width: 150,
//                             color: Colors.black,
//                             child: CustomButton(title: 'SKIP')),
//                         horizontalSpacer(5),
//                         Container(
//                             width: 150,
//                             color: Colors.black,
//                             child: CustomButton(title: 'HIDE'))
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
