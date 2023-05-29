import 'package:flutter/material.dart';

import 'package:urban_hive_test/Models/models.dart';

import '../Config/Repositories/user_repository.dart';
import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Widgets/constant_widget.dart';
import '../Widgets/navigation_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AppUser? currentUser;

  Future<AppUser> getMyInfoFromSharedPreference() async {
    currentUser = await UserRepository().fetchCurrentUser();
    return currentUser!;
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
  }

  @override
  void initState() {
    UserRepository().fetchCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
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
          drawer: const NavigationDrawer(
            pageIndex: 4,
          ),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: currentUser != null
              ? buildUserPage(context, currentUser!)
              : loader()),
    );
  }
}

Widget buildUserPage(BuildContext context, AppUser user) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.purple,
                  Yellow,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      user.imageUrl,
                    ),
                  ),
                  verticalSpacer(5),
                  Text(
                    "${user.lastName} ${user.firstName}",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ),
            // Positioned(
            //   bottom: 20,
            //   right: 20,
            //   child: GestureDetector(
            //     onTap: (() {}),
            //   ),
            // ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.topRight,
            child: TextButton.icon(
              onPressed: () {
                // showBottomSheet(context,
                //       gender: user.gender,
                //       userName: user.userName,
                //       userEmail: user.email,
                //       userPhone: user.phone);
              },
              icon: const Icon(Icons.edit, color: Colors.pink),
              label: const Text(
                'Edit Profillle',
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ),
        ),
        verticalSpacer(20),
        UserFields(
          context,
          icon: Icons.mail,
          title: 'Email',
          details: user.email,
        ),
        verticalSpacer(20),
        UserFields(context,
            icon: Icons.phone,
            title: 'Phone Number',
            details: "(+234) ${user.phone}"),
        verticalSpacer(20),
        UserFields(context,
            icon: Icons.phone,
            title: 'Technical',
            details: user.looking == "0" ? "No" : "Yes"),
        verticalSpacer(20),
        UserFields(context,
            icon: Icons.phone,
            title: 'Looking For',
            details: user.looking == "0" ? "Non Technical" : "Technical"),
        verticalSpacer(20),
        UserFields(
          context,
          icon: Icons.people,
          title: 'About You',
          details: user.bio!,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              const Icon(
                Icons.data_usage,
                size: 17,
              ),
              horizontalSpacer(10),
              verticalSpacer(20),
              const Text(
                'Skills / Job Decription',
                textAlign: TextAlign.left,
              ),
              verticalSpacer(40),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
              children: user.skills!
                  .map((interest) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.purple, Yellow],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(interest),
                        ),
                      ))
                  .toList()),
        )
      ],
    ),
  );
}

Widget UserFields(BuildContext context,
    {required IconData icon, required String title, required String details}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Column(
      children: [
        Container(
          width: double.infinity - 50,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: [
              (Row(
                children: [
                  Icon(
                    icon,
                    size: 17,
                  ),
                  horizontalSpacer(10),
                  verticalSpacer(20),
                  Text(
                    title,
                    textAlign: TextAlign.left,
                  ),
                  verticalSpacer(40),
                ],
              )),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 35),
                  child: Text(
                    details,
                    style: Theme.of(context).textTheme.headline5,
                  )),
              verticalSpacer(15)
            ],
          ),
        ),
      ],
    ),
  );
}

// Future<dynamic> showBottomSheet(BuildContext context,
//     {var phoneNumber,
//     String? userName,
//     String? userEmail,
//     String? userPhone,
//     String? gender}) {
//   final _formKey = GlobalKey<FormBuilderState>();
//   FirestoreRepository firestoreRepository = FirestoreRepository();
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
//             children: [
//               FormBuilder(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     customFormBuilderTextField(
//                       'username',
//                       Icons.person,
//                       null,
//                       'User Name',
//                       initialValue: userName,
//                       validator: FormBuilderValidators.compose(
//                         [
//                           FormBuilderValidators.minLength(context, 4,
//                               errorText:
//                                   'A valid username should be greater than 4 characters '),
//                         ],
//                       ),
//                     ),
//                     vericalSpacer(25),
//                     customFormBuilderTextField(
//                       'email',
//                       Icons.mail,
//                       null,
//                       'Email',
//                       initialValue: userEmail,
//                       validator: FormBuilderValidators.compose(
//                         [
//                           FormBuilderValidators.email(context,
//                               errorText: 'Provided email not valid '),
//                           FormBuilderValidators.required(context,
//                               errorText: 'Email field cannot be empty '),
//                         ],
//                       ),
//                     ),
//                     vericalSpacer(25),
//                     IntlPhoneField(
//                       initialValue: userPhone,
//                       //controller: phoneController,
//                       decoration:
//                           customFormDecoration('Phone Number', null, null),
//                       initialCountryCode: 'NG',
//                       onChanged: (phone) {
//                         phoneNumber = phone.completeNumber;
//                         print(phone.completeNumber);
//                       },
//                     ),

//                     vericalSpacer(25),

//                     vericalSpacer(30),

//                     CustomButton(
//                       formKey: _formKey,
//                       onPressed: () {
//                         var validate = _formKey.currentState?.validate();
//                         if (validate == true) {
//                           _formKey.currentState?.save();
//                           var username =
//                               _formKey.currentState?.fields['username']?.value;
//                           var email =
//                               _formKey.currentState?.fields['email']?.value;

//                           var phone = phoneNumber;

//                           firestoreRepository.saveUserCredentials(
//                               username, email, phone, gender);

//                           Navigator.pop(context);
//                         }
//                       },
//                       child: Text(
//                         'Update details',
//                         style: Theme.of(context)
//                             .textTheme
//                             .headline2!
//                             .copyWith(color: Colors.white),
//                       ),
//                     ),
//                     vericalSpacer(20),
//                     // BlocListener<SignupBloc, SignupState>(
//                     //     listener: (context, state) {
//                     //   if (state is SignupSuccessful) {
//                     //     Navigator.pushReplacementNamed(
//                     //         context, SignUpSecondScreen.routeName);
//                     //   }
//                     // }, child: BlocBuilder<SignupBloc, SignupState>(
//                     //   builder: ((context, state) {
//                     //     if (state is SignupInProgress) {
//                     //       return const SpinKitRotatingPlain(
//                     //         color: Colors.red,
//                     //       );
//                     //       print(state);
//                     //     } else if (state is SignupFailed) {
//                     //       return Text(state.message);
//                     //       print(state);
//                     //     } else if (state is SignupInProgress) {
//                     //       return Container();
//                     //       print(state);
//                     //     }
//                     //     return Container();
//                     // }),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       });



// }
