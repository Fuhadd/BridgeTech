import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:urban_hive_test/Config/Repositories/firestore_repository.dart';
import 'package:urban_hive_test/Widgets/constant_widget.dart';

import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Models/models.dart';

class UpdateUserProfileTestScreen extends StatelessWidget {
  const UpdateUserProfileTestScreen({required this.currentUser, Key? key})
      : super(key: key);
  final AppUser currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      right: false,
      left: false,
      bottom: false,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: _buildUserPage(context, currentUser)),
    );
  }
}

Widget _buildUserPage(BuildContext context, AppUser user) {
  final _formKey = GlobalKey<FormBuilderState>();
  return SingleChildScrollView(
    child: Column(
      children: [
        Hero(
          tag: 'update',
          child: Stack(
            children: [
              Container(
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
                      "Update Information",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Yellow,
                    Colors.purple,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
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
        verticalSpacer(20),
        FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                verticalSpacer(25),
                CustomFormBuilderRadioGroup1("technical", "Are You Technical",
                    initialValue: user.technical),
                verticalSpacer(25),
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
                verticalSpacer(35),

                CustomButton1(
                  onTap: () {
                    var validate = _formKey.currentState?.validate();
                    if (validate == true) {
                      _formKey.currentState?.save();

                      var email = _formKey.currentState?.fields['email']?.value
                          .toString()
                          .trim();
                      var firstName = _formKey
                          .currentState?.fields['firstname']?.value
                          .toString()
                          .trim();
                      var lastName = _formKey
                          .currentState?.fields['lastname']?.value
                          .toString()
                          .trim();

                      var phone = _formKey.currentState?.fields['phone']?.value
                          .toString()
                          .trim();
                      var bio = _formKey.currentState?.fields['bio']?.value;
                      var technical =
                          _formKey.currentState?.fields['technical']?.value;

                      var looking =
                          _formKey.currentState?.fields['looking']?.value;

                      FirestoreRepository().updateUserCredentials(
                        email: email!,
                        firstName: firstName!,
                        lastName: lastName!,
                        phoneNumber: phone!,
                        bio: bio,
                        technical: technical,
                        looking: looking,
                      );

                      Navigator.pop(context);
                    }
                  },
                  title: 'Update details',
                ),
                verticalSpacer(20),
              ],
            ),
          ),
        ),
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
          width: double.infinity - 50,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
            color: Colors.white,
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
  final _formKey = GlobalKey<FormBuilderState>();
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
                      key: _formKey,
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
                              var validate = _formKey.currentState?.validate();
                              if (validate == true) {
                                _formKey.currentState?.save();

                                var email = _formKey
                                    .currentState?.fields['email']?.value
                                    .toString()
                                    .trim();
                                var firstName = _formKey
                                    .currentState?.fields['firstname']?.value
                                    .toString()
                                    .trim();
                                var lastName = _formKey
                                    .currentState?.fields['lastname']?.value
                                    .toString()
                                    .trim();

                                var phone = _formKey
                                    .currentState?.fields['phone']?.value
                                    .toString()
                                    .trim();
                                var bio =
                                    _formKey.currentState?.fields['bio']?.value;
                                var technical = _formKey
                                    .currentState?.fields['technical']?.value;

                                var looking = _formKey
                                    .currentState?.fields['looking']?.value;

                                firestoreRepository.updateUserCredentials(
                                  email: email!,
                                  firstName: firstName!,
                                  lastName: lastName!,
                                  phoneNumber: phone!,
                                  bio: bio,
                                  technical: technical,
                                  looking: looking,
                                );

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
