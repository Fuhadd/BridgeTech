import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:urban_hive_test/Config/Blocs/login_bloc/login_bloc.dart';
import 'package:urban_hive_test/Screens/forgot_password_screen.dart';
import 'package:urban_hive_test/Screens/home_page.dart';
import 'package:urban_hive_test/Screens/signup_screen.dart';
import 'package:urban_hive_test/Widgets/constant_widget.dart';
import 'package:urban_hive_test/main.dart';

import '../Helpers/colors.dart';
import '../Helpers/constants.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  static const routeName = '/login';
  LoginBloc? loginBloc;

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
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
                      verticalSpacer(20),
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
                        'password',
                        Icons.vpn_key,
                        Icons.no_encryption_gmailerrorred_outlined,
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
                      verticalSpacer(15),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, ForgotPassword.routeName);
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Forget Password ?',
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.grey[700]),
                          ),
                        ),
                      ),
                      verticalSpacer(20),
                      CustomButton(
                        color: Yellow,
                        title: 'Login',
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          bool? validate = _formKey.currentState?.validate();
                          print(validate);
                          if (validate == true) {
                            _formKey.currentState?.save();

                            var email = _formKey
                                .currentState?.fields['email']?.value
                                .toString()
                                .trim();
                            var password = _formKey
                                .currentState?.fields['password']?.value;
                            loginBloc?.add(LoginButtonPressed(
                                email: email!, password: password));
                          }
                        },
                      ),
                      verticalSpacer(10),
                      CustomButton(
                          textcolor: Yellow,
                          color: background,
                          title: 'Create An Account',
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, SignUpScreen.routeName);
                          }),
                      verticalSpacer(20),
                      BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccessful) {
                            Navigator.of(context).pop();
                            Future.delayed(Duration.zero, () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             MyApp(currentUser: )));
                              Navigator.pushNamed(context, HomePage.routeName);
                            });
                            // Navigator.pushReplacementNamed(
                            //     context, HomePage.routeName);
                            // Navigator.popUntil(
                            //     context, (route) => HomeScreen.routeName);
                          }
                        },
                        child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginInProgress) {
                              loader();
                              // Future.delayed(Duration.zero, () {
                              //   //showdialog(context);
                              // });

                              return Container(child: loader());
                            } else if (state is LoginFailed) {
                              Future.delayed(Duration.zero, () {
                                //Navigator.of(context).pop();
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                    content: Text(state.message),
                                    backgroundColor: Colors.red,
                                  ));
                              });
                            } else if (state is LoginSuccessful) {
                              // Navigator.of(context).pop();
                              // Future.delayed(Duration.zero, () {
                              //   Navigator.pushNamed(
                              //       context, HomePage.routeName);
                              // });
                              Container();
                            }

                            return Container();
                          },
                        ),
                      ),

                      // CustomButton(
                      //   onPressed: () {
                      //     bool? validate = _formKey.currentState?.validate();
                      //     print(validate);
                      //     if (validate == true) {
                      //       _formKey.currentState?.save();

                      //       var email =
                      //           _formKey.currentState?.fields['email']?.value;
                      //       var password = _formKey
                      //           .currentState?.fields['password']?.value;
                      //       loginBloc?.add(LoginButtonPressed(
                      //           email: email, password: password));
                      //     }
                      //   },
                      //   child: Text('Login',
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headline2!
                      //           .copyWith(color: Colors.white)),
                      // ),
                      // vericalSpacer(20),
                      // BlocListener<LoginBloc, LoginState>(
                      //   listener: (context, state) {
                      //     if (state is LoginSuccessful) {
                      //       Navigator.of(context).pop();
                      //       Navigator.pushReplacementNamed(
                      //           context, VerifyEmailScreen.routeName);
                      //       // Navigator.popUntil(
                      //       //     context, (route) => HomeScreen.routeName);
                      //     }
                      //   },
                      //   child: BlocBuilder<LoginBloc, LoginState>(
                      //     builder: (context, state) {
                      //       if (state is LoginInProgress) {
                      //         Future.delayed(Duration.zero, () {
                      //           showdialog(context);
                      //         });

                      //         // return Container(child: loader());
                      //       } else if (state is LoginFailed) {
                      //         Future.delayed(Duration.zero, () {
                      //           Navigator.of(context).pop();
                      //           ScaffoldMessenger.of(context)
                      //             ..removeCurrentSnackBar()
                      //             ..showSnackBar(SnackBar(
                      //               content: Text(state.message),
                      //               backgroundColor: Colors.red,
                      //             ));
                      //         });

                      //         // WidgetsBinding.instance
                      //         //     ?.addPostFrameCallback((_) {
                      //         // ScaffoldMessenger.of(context)
                      //         //   ..removeCurrentSnackBar()
                      //         //   ..showSnackBar(SnackBar(
                      //         //     content: Text(state.message),
                      //         //     backgroundColor: Colors.red,
                      //         //   ));

                      //         // Add Your Code here.
                      //         // });

                      //         // return Text(state.message);
                      //       } else if (state is LoginSuccessful) {
                      //         Container();
                      //       }

                      //       return Container();
                      //     },
                      //   ),
                      // ),
                      // vericalSpacer(20),
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
    return Container(
      child: Stack(children: [
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 250,
            decoration: BoxDecoration(color: Yellow),
          ),
        ),
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 240,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Yellow, background],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 55, left: 40),
              child: Row(
                children: [
                  Text(
                    'Welcome Back',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);
    var firstController = Offset(0, size.height - 90);
    var firstEnd = Offset(size.width / 4, size.height - 90);
    path.quadraticBezierTo(
      firstController.dx,
      firstController.dy,
      firstEnd.dx,
      firstEnd.dy,
    );
    path.lineTo(size.width - 100, size.height - 90);
    var SecondController = Offset(size.width - 55, size.height - 90);
    var SecondEnd = Offset(size.width, size.height - 140);
    path.quadraticBezierTo(
      SecondController.dx,
      SecondController.dy,
      SecondEnd.dx,
      SecondEnd.dy,
    );
    path.lineTo(size.width, 0);
    path.close;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
