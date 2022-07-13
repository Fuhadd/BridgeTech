import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urban_hive_test/Helpers/sharedPrefs.dart';
import 'package:urban_hive_test/Models/models.dart';

class UserRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> createUserWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (error) {
      var message = 'An Error Occures';
      switch (error.code) {
        case 'invalid-email:':
          message = 'Email is Invalid!';
          break;
        case 'email-already-in-use:':
          message =
              'The email address already exists.Please proceed to login Screen ';
          break;
        case 'wrong-password':
          message = 'Invalid password. Please enter correct password.';
          break;
      }
      throw Exception(message);
      print(message);
    }
  }

  Future<User?> LoginWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (error) {
      var message = 'An error has occured.'; // default message
      switch (error.code) {
        case 'user-disabled':
          message =
              'This user has been temporarily disabled, Contact Support for more information';
          break;
        case 'user-not-found':
          message =
              'The email address is not assocciated with a user.Try another Email up or Register with this email address ';
          break;
        case 'wrong-password':
          message = 'Invalid password. Please enter correct password.';
          break;
      }
      throw Exception(message);
    }
  }

  Future isUserSignedIn() async {
    User? user = firebaseAuth.currentUser;
    return user != null && user.uid.isNotEmpty;
  }

  Future logOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (error) {
      throw Exception(error);
    }
  }

  Future<AppUser> fetchCurrentUser() async {
    try {
      String? userJson = await SharedPreferenceHelper().getcurrentUser();
      AppUser currentUser = AppUser.fromJson(json.decode(userJson!));
      return currentUser;
    } on PlatformException catch (error) {
      throw Exception(error);
    }
  }
}
