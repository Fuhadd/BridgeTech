import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:urban_hive_test/Config/Repositories/firestore_repository.dart';
import 'package:urban_hive_test/Screens/update_user_profile_screen.dart';
import 'package:urban_hive_test/Screens/user_profile_screen.dart';
import 'package:urban_hive_test/Widgets/constant_widget.dart';

import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Models/models.dart';
import '../Widgets/navigation_drawer.dart';

class UserProfileTestScreen extends StatefulWidget {
  const UserProfileTestScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = '/userprofile';

  @override
  State<UserProfileTestScreen> createState() => _UserProfileTestScreenState();
}

class _UserProfileTestScreenState extends State<UserProfileTestScreen> {
  Stream<DocumentSnapshot>? chats;
  final _formKey = GlobalKey<FormBuilderState>();

  Widget userProfilePage() {
    return StreamBuilder(
      stream: chats,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          AppUser currentUser = AppUser(
            firstName: snapshot.data!.get('firstName'),
            email: snapshot.data!.get('email'),
            phone: snapshot.data!.get('phoneNumber'),
            lastName: snapshot.data!.get('lastName'),
            imageUrl: snapshot.data!.get('imageUrl'),
            bio: snapshot.data!.get('bio'),
            technical: snapshot.data!.get('technical'),
            looking: snapshot.data!.get('looking'),
            id: snapshot.data!.get('id'),
            skills: snapshot.data!.get('skills'),
          );
          {
            return snapshot.hasData
                ? _buildUserPage(context, currentUser)
                : Container();
          }
        }
        return loader();
      },
    );
  }

  @override
  void initState() {
    FirestoreRepository().getCurrentUserProfile().then((val) {
      setState(() {
        chats = val;
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
          body: userProfilePage()),
    );
  }
}

Widget _buildUserPage(BuildContext context, AppUser user) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Hero(
          tag: 'update',
          child: Stack(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xfff4a50c),
                  // gradient: LinearGradient(colors: [
                  //   Colors.purple,
                  //   Yellow,
                  // ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  // borderRadius: BorderRadius.only(
                  //     bottomRight: Radius.circular(20.0),
                  //     bottomLeft: Radius.circular(20.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   radius: 70,
                    //   backgroundImage: NetworkImage(
                    //     user.imageUrl,
                    //   ),
                    // ),
                    // verticalSpacer(5),
                    Text(
                      "${user.lastName} ${user.firstName}",
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.black,
                          ),
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.topRight,
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdateUserProfileTestScreen(
                      currentUser: user,
                    ),
                  ),
                );
                // _showBottomSheet(context, user: user);
                // showBottomSheet(context,
                //       gender: user.gender,
                //       userName: user.userName,
                //       userEmail: user.email,
                //       userPhone: user.phone);
              },
              icon: const Icon(Icons.edit, color: Colors.pink),
              label: const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ),
        ),
        verticalSpacer(5),
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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
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
          ),
        )
      ],
    ),
  );
}

Widget _userFields(BuildContext context,
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

Future<dynamic> _showBottomSheet(BuildContext context, {required AppUser user}
    // {var phoneNumber,
    // String? userName,
    // String? userEmail,
    // String? userPhone,
    // String? gender}
    ) {
  final formKey = GlobalKey<FormBuilderState>();
  FirestoreRepository firestoreRepository = FirestoreRepository();
  return showModalBottomSheet(
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Wrap(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormBuilder(
                      key: formKey,
                      child: Column(
                        children: [
                          // customFormBuilderTextField(
                          //   'username',
                          //   Icons.person,
                          //   null,
                          //   'User Name',
                          //   initialValue: userName,
                          //   validator: FormBuilderValidators.compose(
                          //     [
                          //       FormBuilderValidators.minLength(4,
                          //           errorText:
                          //               'A valid username should be greater than 4 characters '),
                          //     ],
                          //   ),
                          // ),
                          // verticalSpacer(25),
                          customFormBuilderTextField(
                            'firstname',
                            Icons.person,
                            null,
                            'First Name',
                            initialValue: user.firstName,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.minLength(4,
                                    errorText:
                                        'A valid first name should be greater than 4 characters '),
                              ],
                            ),
                          ),
                          verticalSpacer(25),

                          customFormBuilderTextField(
                            'lastname',
                            Icons.person,
                            null,
                            'Last Name',
                            initialValue: user.lastName,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.minLength(4,
                                    errorText:
                                        'A valid last name should be greater than 4 characters '),
                              ],
                            ),
                          ),

                          customFormBuilderTextField(
                            'email',
                            Icons.mail,
                            null,
                            'Email',
                            initialValue: user.email,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.email(
                                    errorText: 'Provided email not valid '),
                                FormBuilderValidators.required(
                                    errorText: 'Email field cannot be empty '),
                              ],
                            ),
                          ),
                          // verticalSpacer(25),
                          // customFormBuilderTextField(
                          //   'email',
                          //   Icons.mail,
                          //   null,
                          //   'Email',
                          //   validator: FormBuilderValidators.compose(
                          //     [
                          //       FormBuilderValidators.email(
                          //           errorText: 'Provided email not valid '),
                          //       FormBuilderValidators.required(
                          //           errorText: 'Email field cannot be empty '),
                          //     ],
                          //   ),
                          // ),
                          verticalSpacer(25),
                          customFormBuilderTextField(
                            'phone',
                            Icons.phone,
                            null,
                            'Phone',
                            initialValue: user.phone,
                            prefix: Text(
                              '+234 ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.grey),
                            ),
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText: 'Email field cannot be empty '),
                              ],
                            ),
                          ),
                          CustomFormBuilderRadioGroup1(
                              "technical", "Are You Technical",
                              initialValue: user.technical),
                          verticalSpacer(20),
                          CustomFormBuilderRadioGroup1(
                              "looking", "What Are You Looking For",
                              initialValue: user.looking),
                          customFormBuilderMultiTextField(
                            'bio',
                            Icons.person,
                            null,
                            'About You ',
                            initialValue: user.bio,
                            isHint: false,
                            hintText:
                                'Use this space to show Co users you have the skills and experience they\'re looking for',
                            helperText: 'Describe your strengths and skills\n'
                                ' Highlight projects, accomplishments and education'
                                'Keep it short and make sure it\'s error-free',
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.minLength(4,
                                    errorText:
                                        'A valid first name should be greater than 4 characters '),
                              ],
                            ),
                          ),
                          verticalSpacer(25),
                          // verticalSpacer(25),
                          // IntlPhoneField(
                          //   initialValue: userPhone,
                          //   decoration:
                          //       customFormDecoration('Phone Number', null, null),
                          //   initialCountryCode: 'NG',
                          //   onChanged: (phone) {
                          //     phoneNumber = phone.completeNumber;
                          //     print(phone.completeNumber);
                          //   },
                          // ),
                          verticalSpacer(25),
                          verticalSpacer(30),
                          CustomButton(
                            onTap: () {
                              var validate = formKey.currentState?.validate();
                              if (validate == true) {
                                formKey.currentState?.save();

                                var email = formKey
                                    .currentState?.fields['email']?.value
                                    .toString()
                                    .trim();
                                var firstName = formKey
                                    .currentState?.fields['firstname']?.value
                                    .toString()
                                    .trim();
                                var lastName = formKey
                                    .currentState?.fields['lastname']?.value
                                    .toString()
                                    .trim();

                                var phone = formKey
                                    .currentState?.fields['phone']?.value
                                    .toString()
                                    .trim();
                                var bio =
                                    formKey.currentState?.fields['bio']?.value;
                                var technical = formKey
                                    .currentState?.fields['technical']?.value;

                                var looking = formKey
                                    .currentState?.fields['looking']?.value;

                                // firestoreRepository.updateUserCredentials(
                                //   email: email!,
                                //   firstName: firstName!,
                                //   lastName: lastName!,
                                //   phoneNumber: phone!,
                                //   bio: bio,
                                //   technical: technical,
                                //   looking: looking,
                                // );

                                Navigator.pop(context);
                              }
                            },
                            title: 'Update details',
                          ),
                          verticalSpacer(20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
