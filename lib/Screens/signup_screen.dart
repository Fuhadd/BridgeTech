import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urban_hive_test/Config/Repositories/firebase_storage_repository.dart';
import 'package:urban_hive_test/Helpers/colors.dart';
import 'package:urban_hive_test/Screens/email_verification_screen.dart';
import 'package:urban_hive_test/Screens/home_page.dart';
import 'package:urban_hive_test/Screens/verifyuserbio_screen.dart';
import 'package:urban_hive_test/Widgets/constant_widget.dart';

import '../Config/Blocs/signup_bloc/signup_bloc.dart';
import '../Helpers/constants.dart';
import 'login_screen.dart';
// import 'package:step_progress_indicator/step_progress_indicator.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController phoneController = TextEditingController();

  SignupBloc? signupBloc;
  File? image;

  FirebaseStorageRepository? firebaseStorageRepository =
      FirebaseStorageRepository();

  @override
  Widget build(BuildContext context) {
    var phoneNumber;

    signupBloc = BlocProvider.of<SignupBloc>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  const _CustomCurvedBar(),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: image == null
                          ? CircleAvatar(
                              radius: 50,
                              child: GestureDetector(
                                  onTap: () async {
                                    final tempPath =
                                        await firebaseStorageRepository
                                            ?.pickImageFromGallery();
                                    final tempimage = File(tempPath.toString());
                                    setState(() {
                                      this.image = tempimage;
                                    });
                                    // print(imagePath);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(Icons.add_a_photo),
                                  )))
                          : CircleAvatar(
                              backgroundImage: FileImage(image!),
                              radius: 50,
                              // child: imagePath == null
                              //     ? GestureDetector(
                              //         onTap: () async {
                              //           imagePath = await firebaseStorageRepository
                              //               ?.pickImageFromGallery();
                              //           print(imagePath);
                              //         },
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(10.0),
                              //           child: Icon(Icons.add_a_photo),
                              //         ))
                              //     : Container(
                              //         alignment: Alignment.center,
                              //         height: 200,
                              //         width: 140,
                              //         decoration: BoxDecoration(
                              //           image: DecorationImage(
                              //             image: FileImage(File(imagePath)),
                              //             fit: BoxFit.cover,
                              //           ),
                              //         ),
                              //       ),
                            ))
                ],
              ),
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
                      customFormBuilderTextField(
                        'firstname',
                        Icons.person,
                        null,
                        'First Name',
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
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.minLength(4,
                                errorText:
                                    'A valid last name should be greater than 4 characters '),
                          ],
                        ),
                      ),
                      verticalSpacer(25),
                      customFormBuilderTextField(
                        'email',
                        Icons.mail,
                        null,
                        'Email',
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.email(
                                errorText: 'Provided email not valid '),
                            FormBuilderValidators.required(
                                errorText: 'Email field cannot be empty '),
                          ],
                        ),
                      ),
                      verticalSpacer(25),
                      customFormBuilderTextField(
                        'phone',
                        Icons.phone,
                        null,
                        'Phone',
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
                      // IntlPhoneField(
                      //   controller: phoneController,
                      //   decoration:
                      //       customFormDecoration('Phone Number', null, null),
                      //   initialCountryCode: 'NG',
                      //   onChanged: (phone) {
                      //     phoneNumber = phone.completeNumber;
                      //   },
                      // ),

                      verticalSpacer(25),
                      customFormBuilderTextField(
                        'password',
                        Icons.vpn_key,
                        Icons.remove_red_eye_outlined,
                        'Password',
                        obscureText: true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.minLength(6,
                              errorText:
                                  'Good passwords are greater than 6 characters'),
                          FormBuilderValidators.required(
                              errorText: 'Password field cannot be empty '),
                        ]),
                      ),
                      // vericalSpacer(25),
                      // customFormBuilderTextField(
                      //   'confirm_password',
                      //   Icons.vpn_key,
                      //   Icons.remove_red_eye_outlined,
                      //   'Confirm Password',
                      //   obscureText: true,
                      //   validator: FormBuilderValidators.compose([
                      //     FormBuilderValidators.notEqual(context,
                      //         _formKey.currentState?.fields['password']?.value,
                      //         errorText: 'Passwords do not match!  '),
                      //   ]),
                      // ),
                      verticalSpacer(40),
                      CustomButton(
                        color: Yellow,
                        title: 'Register',
                        onTap: () {
                          var validate = _formKey.currentState?.validate();
                          if (image == null) {
                            validate = false;
                            Future.delayed(Duration.zero, () {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                  content: Text('Image Field Cannot Be Empty'),
                                  backgroundColor: Colors.red,
                                ));
                            });
                          }
                          if (validate == true) {
                            _formKey.currentState?.save();
                            var firstName = _formKey
                                .currentState?.fields['firstname']?.value
                                .toString()
                                .trim();
                            var lastName = _formKey
                                .currentState?.fields['lastname']?.value
                                .toString()
                                .trim();

                            var email = _formKey
                                .currentState?.fields['email']?.value
                                .toString()
                                .trim();
                            var phone = _formKey
                                .currentState?.fields['phone']?.value
                                .toString()
                                .trim();
                            var password = _formKey
                                .currentState?.fields['password']?.value;
                            print(1);

                            signupBloc?.add(SignupButtonPressed(
                              email: email!,
                              password: password,
                              phoneNumber: phone!,
                              lastName: lastName!,
                              firstName: firstName!,
                              image: image!,
                            ));
                          }
                        },
                      ),
                      verticalSpacer(10),
                      CustomButton(
                          textcolor: Yellow,
                          color: background,
                          title: 'Login',
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          }),
                      BlocListener<SignupBloc, SignupState>(
                          listener: (context, state) {
                        if (state is SignupSuccessful) {
                          Navigator.pushReplacementNamed(
                              context, VerifyBioScreen.routeName);

                          //context, VerifyEmailScreen.routeName);
                        }
                      }, child: BlocBuilder<SignupBloc, SignupState>(
                        builder: ((context, state) {
                          if (state is SignupInProgress) {
                            Future.delayed(Duration.zero, () {
                              showdialog(context);
                            });
                          } else if (state is SignupFailed) {
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
                          // else if (state is SignupSuccessful) {
                          //   return Container();
                          // }
                          return Container();
                        }),
                      )),

                      // CustomButton(
                      //   formKey: _formKey,
                      //   onPressed: () {
                      //     var validate = _formKey.currentState?.validate();
                      //     if (validate == true) {
                      //       _formKey.currentState?.save();
                      //       var username = _formKey
                      //           .currentState?.fields['username']?.value;
                      //       var email =
                      //           _formKey.currentState?.fields['email']?.value;
                      //       var gender =
                      //           _formKey.currentState?.fields['gender']?.value;
                      //       var password = _formKey
                      //           .currentState?.fields['password']?.value;
                      //       var phone = phoneNumber;
                      //       signupBloc?.add(SignUpButtonPressed(
                      //           email: email,
                      //           password: password,
                      //           userName: username,
                      //           phone: '+23481096789',
                      //           gender: gender));
                      //     }
                      //   },
                      //   child: Text('Next Step',
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headline2!
                      //           .copyWith(color: Colors.white)),
                      // ),
                      // vericalSpacer(20),
                      // BlocListener<SignupBloc, SignupState>(
                      //     listener: (context, state) {
                      //   if (state is SignupSuccessful) {
                      //     Navigator.pushReplacementNamed(
                      //         context, SignUpSecondScreen.routeName);
                      //   }
                      // }, child: BlocBuilder<SignupBloc, SignupState>(
                      //   builder: ((context, state) {
                      //     if (state is SignupInProgress) {
                      //       Future.delayed(Duration.zero, () {
                      //         showdialog(context);
                      //       });
                      //     } else if (state is SignupFailed) {
                      //       Future.delayed(Duration.zero, () {
                      //         Navigator.of(context).pop();
                      //         ScaffoldMessenger.of(context)
                      //           ..removeCurrentSnackBar()
                      //           ..showSnackBar(SnackBar(
                      //             content: Text(state.message),
                      //             backgroundColor: Colors.red,
                      //           ));
                      //       });
                      //     }
                      //     // else if (state is SignupSuccessful) {
                      //     //   return Container();
                      //     // }
                      //     return Container();
                      //   }),
                      // )),
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
                  'Let\'s Get Started',
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
