import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urban_hive_test/Config/Repositories/constant_repository.dart';
import 'package:urban_hive_test/Config/Repositories/firebase_storage_repository.dart';
import 'package:urban_hive_test/Config/Repositories/firestore_repository.dart';
import 'package:urban_hive_test/Helpers/colors.dart';
import 'package:urban_hive_test/Screens/home_page.dart';
import 'package:urban_hive_test/Widgets/constant_widget.dart';

import '../Config/Blocs/userinfo_bloc/userinfo_bloc.dart';
import '../Helpers/constants.dart';
// import 'package:step_progress_indicator/step_progress_indicator.dart';

class MoreInfoScreen extends StatelessWidget {
  MoreInfoScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController phoneController = TextEditingController();

  UserInfoBloc? userinfoBloc;
  File? image;

  FirebaseStorageRepository? firebaseStorageRepository =
      FirebaseStorageRepository();

  FirestoreRepository firestoreRepository = FirestoreRepository();

  ConstantRepository? constantRepository = ConstantRepository();
  @override
  Widget build(BuildContext context) {
    var phoneNumber;
    List<String> skills;

    userinfoBloc = BlocProvider.of<UserInfoBloc>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const _CustomCurvedBar(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                  bottom: 40,
                ),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      customFormBuilderMultiTextField(
                        'bio',
                        Icons.person,
                        null,
                        'About You ',
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
                      CustomFormBuilderRadioGroup1(
                          "technical", "Are You Technical"),
                      verticalSpacer(20),
                      CustomFormBuilderRadioGroup1(
                          "looking", "What Are You Looking For"),
                      verticalSpacer(45),
                      GestureDetector(
                          onTap: (() {
                            var validate = _formKey.currentState?.validate();
                            if (validate == true) {
                              _formKey.currentState?.save();
                              var bio =
                                  _formKey.currentState?.fields['bio']?.value;
                              var technical = _formKey
                                  .currentState?.fields['technical']?.value;

                              var looking = _formKey
                                  .currentState?.fields['looking']?.value;

                              showBottomSheetSkills(context,
                                  formKey: _formKey,
                                  repository: constantRepository,
                                  userinfoBloc: userinfoBloc,
                                  bio: bio,
                                  looking: looking,
                                  technical: technical);
                            }
                          }),
                          child: _UserInfoCard('Continue', color: Yellow)),
                      verticalSpacer(40),
                      BlocListener<UserInfoBloc, UserInfoState>(
                          listener: (context, state) {
                        if (state is UserInfoSuccessful) {
                          // Restart.restartApp();
                          Navigator.pushReplacementNamed(
                              context, HomePage.routeName);
                        }
                        //KAchi
                      }, child: BlocBuilder<UserInfoBloc, UserInfoState>(
                        builder: ((context, state) {
                          if (state is UserInfoInProgress) {
                            Future.delayed(Duration.zero, () {
                              showdialog(context);
                            });
                          } else if (state is UserInfoFailed) {
                            Future.delayed(Duration.zero, () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                  content: Text(state.message),
                                  backgroundColor: Colors.red,
                                ));
                            });
                          }
                          // else if (state is UserInfoSuccessful) {
                          //   return Container();
                          // }
                          return Container();
                        }),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class _CustomCurvedBar extends StatelessWidget {
  const _CustomCurvedBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipPath(
        clipper: WaveClipper(),
        child: Container(
          height: 200,
          decoration: BoxDecoration(color: Yellow),
        ),
      ),
      ClipPath(
        clipper: WaveClipper(),
        child: Container(
          height: 190,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Yellow, background],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60, left: 40),
            child: Row(
              children: [
                Text(
                  'Almost In',
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.insert_emoticon)
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    var firstController = Offset(0, size.height - 70);
    var firstEnd = Offset(size.width / 4, size.height - 70);
    path.quadraticBezierTo(
      firstController.dx,
      firstController.dy,
      firstEnd.dx,
      firstEnd.dy,
    );
    path.lineTo(size.width - 100, size.height - 70);
    var secondController = Offset(size.width - 55, size.height - 70);
    var secondEnd = Offset(size.width, size.height - 135);
    path.quadraticBezierTo(
      secondController.dx,
      secondController.dy,
      secondEnd.dx,
      secondEnd.dy,
    );
    path.lineTo(size.width, 0);
    path.close;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

  InputDecoration formDecoration = const InputDecoration(
      floatingLabelStyle: TextStyle(color: Colors.pink),
      fillColor: Colors.pink,
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
      prefixIcon: Icon(
        Icons.mail,
        size: 20,
      ),
      labelText: 'Gender');
}

Container _UserInfoCard(String title,
    {Color color = Colors.white, double elevation = 5}) {
  return Container(
    height: 70,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      // color: color,
    ),
    child: Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: color,
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.toolbox,
                  color: Colors.grey,
                  size: 19,
                ),
                horizontalSpacer(10),
                CustomSubTitleText(
                  title: title,
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

Future<dynamic> showBottomSheetSkills(
  BuildContext context, {
  required String bio,
  required String technical,
  required String looking,
  ConstantRepository? repository,
  UserInfoBloc? userinfoBloc,
  var formKey,
  var phoneNumber,
}) {
  List<String>? skills = [];
  final formKey1 = GlobalKey<FormBuilderState>();
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
            children: [
              FormBuilder(
                key: formKey1,
                child: Column(
                  children: [
                    customFormBuilderTextField(
                      'skill1',
                      Icons.person,
                      null,
                      'Your Job Descripion',
                      helperText:
                          "Current Job Decription (e.g Flutter Developer)",
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.minLength(4,
                              errorText: 'This is mandatory'),
                        ],
                      ),
                    ),
                    verticalSpacer(25),
                    customFormBuilderTextField(
                      'skill2',
                      Icons.mail,
                      null,
                      'Add additional skill(optional)',
                    ),
                    verticalSpacer(25),
                    customFormBuilderTextField(
                      'skill3',
                      Icons.mail,
                      null,
                      'Add additional skill(optional)',
                    ),
                    customFormBuilderTextField(
                      'skill4',
                      Icons.mail,
                      null,
                      'Add additional skill(optional)',
                    ),
                    verticalSpacer(30),
                    CustomButton(
                      onTap: () {
                        var validate = formKey1.currentState?.validate();
                        if (validate == true) {
                          formKey1.currentState?.save();
                          var skill1 =
                              formKey1.currentState?.fields['skill1']?.value;
                          print(skill1);
                          var skill2 =
                              formKey1.currentState?.fields['skill2']?.value;
                          var skill3 =
                              formKey1.currentState?.fields['skill3']?.value;
                          var skill4 =
                              formKey1.currentState?.fields['skill4']?.value;
                          skills = repository?.convertStringToList(
                              skill1, skill2, skill3, skill4);

                          print(skills);

                          userinfoBloc?.add(UserInfoButtonPressed(
                            skills: skills!,
                            bio: bio,
                            technical: technical,
                            looking: looking,
                          ));

                          Navigator.pop(context);
                        }
                      },
                      title: 'Add Skills',
                    ),
                    verticalSpacer(20),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
