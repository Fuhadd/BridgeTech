// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:urban_hive_test/Helpers/constants.dart';
// import 'package:urban_hive_test/Models/models.dart';
// import 'package:urban_hive_test/Widgets/navigation_drawer.dart';
// import 'package:urban_hive_test/Widgets/non_included_screen.dart';

// import '../Helpers/colors.dart';

// class ProfileScreen extends StatelessWidget {
//   final _formKey = GlobalKey<FormBuilderState>();
//   ProfileScreen({Key? key, required this.currentUser}) : super(key: key);
//   final AppUser currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: background,
//         drawer: NavigationDrawer(
//           pageIndex: 4,
//           user: currentUser,
//         ),
//         appBar: CustomAppar(context, "Profile"),
//         body: SingleChildScrollView(
//             child: Column(
//           children: [
//             FormBuilder(
//                 key: _formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                   child: Column(
//                     children: [
//                       verticalSpacer(35),
//                       customFormBuilderTextField(
//                         'bio',
//                         Icons.person,
//                         null,
//                         'Tell us a bit about yourself',
//                         validator: FormBuilderValidators.compose(
//                           [
//                             FormBuilderValidators.minLength(4,
//                                 errorText:
//                                     'A valid biography should be greater than 4 characters '),
//                           ],
//                         ),
//                       ),
//                       verticalSpacer(40),
//                       customFormBuilderTextField(
//                         'country',
//                         FontAwesomeIcons.earthEurope,
//                         null,
//                         'Country / City',
//                         validator: FormBuilderValidators.compose(
//                           [
//                             FormBuilderValidators.minLength(4,
//                                 errorText:
//                                     'A valid username should be greater than 4 characters '),
//                           ],
//                         ),
//                       ),
//                       verticalSpacer(40),
//                       CustomFormBuilderRadioGroup1(
//                           "techncal", "Are You Technical"),
//                       customFormBuilderTextField(
//                         'area',
//                         FontAwesomeIcons.briefcase,
//                         null,
//                         'What areas do you work?',
//                         validator: FormBuilderValidators.compose(
//                           [
//                             FormBuilderValidators.minLength(4,
//                                 errorText:
//                                     'A valid username should be greater than 4 characters '),
//                           ],
//                         ),
//                       ),
//                       verticalSpacer(40),
//                       customFormBuilderTextField(
//                         'lookingfor',
//                         FontAwesomeIcons.searchengin,
//                         null,
//                         'What are you looking for?',
//                         validator: FormBuilderValidators.compose(
//                           [
//                             FormBuilderValidators.minLength(4,
//                                 errorText:
//                                     'A valid username should be greater than 4 characters '),
//                           ],
//                         ),
//                       ),
//                       verticalSpacer(40),
//                       customFormBuilderTextField(
//                         'github',
//                         FontAwesomeIcons.hashtag,
//                         null,
//                         'Github',
//                         validator: FormBuilderValidators.compose(
//                           [
//                             FormBuilderValidators.minLength(4,
//                                 errorText:
//                                     'A valid github link should be greater than 4 characters '),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ))
//           ],
//         )));
//   }
// }
