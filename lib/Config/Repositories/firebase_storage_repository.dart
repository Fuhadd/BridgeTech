import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStorageRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  ImagePicker imagePicker = ImagePicker();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  CollectionReference firestoreRepository =
      FirebaseFirestore.instance.collection('UserData');

  Future<String> pickImageFromGallery() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    }
    return '';
  }

  Future uploadImage(File image) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    Reference ref = firebaseStorage.ref().child('$uid/images');
    await ref.putFile(image);
    String downloadedUrl = await ref.getDownloadURL();

    await firestoreRepository.doc(uid.toString()).set(

        //document().set(
        {
          'imageUrl': downloadedUrl,
        },
        SetOptions(
          merge: true,
        ));
  }
}
