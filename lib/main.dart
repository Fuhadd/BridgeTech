import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_hive_test/Config/Blocs/login_bloc/login_bloc.dart';
import 'package:urban_hive_test/Config/Blocs/userinfo_bloc/userinfo_bloc.dart';
import 'package:urban_hive_test/Config/Repositories/firebase_storage_repository.dart';
import 'package:urban_hive_test/Config/Repositories/firestore_repository.dart';
import 'package:urban_hive_test/Config/Repositories/user_repository.dart';
import 'package:urban_hive_test/Helpers/theme.dart';
import 'package:urban_hive_test/Models/models.dart' as appUser;
import 'package:urban_hive_test/Screens/forgot_password_screen.dart';
import 'package:urban_hive_test/Screens/home_page.dart';
import 'package:urban_hive_test/Screens/login_screen.dart';
import 'package:urban_hive_test/Screens/settings.dart';
import 'package:urban_hive_test/Screens/signup_screen.dart';
import 'package:urban_hive_test/Screens/splash_screen.dart';
import 'package:urban_hive_test/Screens/verifyuserbio_screen.dart';

import 'Config/Blocs/auth_bloc/auth_bloc.dart';
import 'Config/Blocs/signup_bloc/signup_bloc.dart';
import 'Config/Services/local_push_notification.dart';
import 'Screens/email_verification_screen.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // name: 'bridgetech',
    // options:
    // const FirebaseOptions(
    //   apiKey: 'AIzaSyAbVs1nFKJZOw21gQGWBD3gRUpkZKQr8ww',
    //   appId: '1:989951728763:android:72607bf6f013f1f6e416de',
    //   messagingSenderId: '',
    //   projectId: 'bridge-tech-advance',
    //   storageBucket:
    //       'gs://bridge-tech-advance.appspot.com/', // Your projectId
    // )
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  final prefs = await SharedPreferences.getInstance();

  final userJson = prefs.getString('user') ?? '';

  if (userJson == null) return;
  final user = userJson == ''
      ? appUser.AppUser(
          id: '',
          firstName: '',
          email: '',
          phone: '',
          lastName: '',
          imageUrl: '',
          // technical: '',
          // looking: '',
          // bio: '',
          // skills: [],
        )
      : appUser.AppUser.fromJson(json.decode(userJson));
  runApp(MyApp(
    currentUser: user,
  ));
}

class MyApp extends StatelessWidget {
  final appUser.AppUser currentUser;
  const MyApp({Key? key, required this.currentUser}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    final firestoreRepository = FirestoreRepository();
    final firebaseStorageRepository = FirebaseStorageRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(userRepository, firestoreRepository),
        ),
        BlocProvider(
          create: (context) => SignupBloc(
              userRepository, firestoreRepository, firebaseStorageRepository),
        ),
        BlocProvider(
          create: (context) => AuthBloc(userRepository),
        ),
        BlocProvider(
          create: (context) => UserInfoBloc(
              userRepository, firestoreRepository, firebaseStorageRepository),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(),
          // home: DiscoverTest(),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                } else if (snapshot.hasData) {
                  return const HomePage();

                  // VerifyBioScreen(
                  //   user: currentUser,
                  // );

                  // VerifyEmailScreen(
                  //   user: currentUser,
                  // );
                } else {
                  return LoginScreen();
                }
              }),
          // HomePage(),
          routes: {
            SignUpScreen.routeName: (context) => SignUpScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            HomePage.routeName: (context) => const HomePage(),
            ForgotPassword.routeName: (context) => ForgotPassword(),
            VerifyBioScreen.routeName: (context) =>
                VerifyBioScreen(user: currentUser),
            VerifyEmailScreen.routeName: (context) =>
                VerifyEmailScreen(user: currentUser),
            SettingsScreen.routeName: (context) => const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
