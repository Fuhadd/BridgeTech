import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConstantRepository {
  List<String> convertStringToList(
      String? string1, String? string2, String? string3, String? string4) {
    try {
      List<String> skills = [];
      if (string1 != null) {
        skills.add(string1);
      }
      if (string2 != null) {
        skills.add(string2);
      }
      if (string3 != null) {
        skills.add(string3);
      }
      if (string4 != null) {
        skills.add(string4);
      }
      print(string1);
      return skills;
    } catch (error) {
      throw Exception(error);
    }
  }
}
