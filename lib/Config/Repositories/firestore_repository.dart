import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_hive_test/Models/models.dart';

class FirestoreRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference firebaseFirestore =
      FirebaseFirestore.instance.collection('UserData');
  CollectionReference chatFirebaseFirestore =
      FirebaseFirestore.instance.collection("chatRoom");

  CollectionReference matchFirebaseFirestore =
      FirebaseFirestore.instance.collection("matches");

  Future<void> saveUserCredentials(
    String email,
    String firstName,
    String lastName,
    String phoneNumber,
    DateTime accountCreated,
  ) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).set(
        {
          'id': uid.toString(),
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'accountCreated': accountCreated,
          'matchedUsers': [uid.toString()],
        },
        SetOptions(
          merge: true,
        ));
    return;
  }

  Future<void> saveMatched(List<String> matchedUserId) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).update(
      //.set(
      {
        'matchedUsers': FieldValue.arrayUnion(matchedUserId),
        // 'email': email,
        // 'firstName': firstName,
        // 'lastName': lastName,
        // 'phoneNumber': phoneNumber,
        // 'accountCreated': accountCreated,
      },
    );
    return;
  }

  Future<void> saveMatchedBuddy(
      String buddyUid, List<String> matchedUserId) async {
    await firebaseFirestore.doc(buddyUid.toString()).update(
      //.set(
      {
        'matchedUsers': FieldValue.arrayUnion(matchedUserId),
        // 'email': email,
        // 'firstName': firstName,
        // 'lastName': lastName,
        // 'phoneNumber': phoneNumber,
        // 'accountCreated': accountCreated,
      },
    );
    return;
  }

  Future<AppUser?> getUsersCredentials() async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      final appUser = firebaseFirestore.doc(uid);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        return AppUser.fromJson(snapshot.data());
        //as Map<String, dynamic>);

        // app_user.User.fromJson(snapshot.data());
      }
      //print(snapshot);
    } catch (error) {}
  }

  Future<AppUser?> getUsersCredentialsbyid(String uid) async {
    try {
      final appUser = firebaseFirestore.doc(uid);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        return AppUser.fromJson(snapshot.data());
        //as Map<String, dynamic>);

        // app_user.User.fromJson(snapshot.data());
      }
      //print(snapshot);
    } catch (error) {}
  }

  Future<bool> checkUserBio() async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      final appUser = firebaseFirestore.doc(uid);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        var userInfo = AppUser.fromJson(snapshot.data());
        if (userInfo.bio!.isEmpty) {
          return false;
        }
        return true;
      }
      return false;
      //print(snapshot);
    } catch (error) {
      return false;
    }
  }

  Future<List<AppUser?>> getAllUsers(String id) async {
    List<String> test = [];
    List<AppUser?> allAppUsers = [];
    int? userLength;
    int counter = 0;
    try {
      print(id);
      final allUsers = await firebaseFirestore.get();

      allUsers.docs.forEach((element) async {
        userLength = element.reference.id.length;
        var userId = element.reference.id;
        test.add(userId);

        final appUser = firebaseFirestore.doc(userId);

        final snapshot = await appUser.get();

        if (snapshot.exists) {
          if (id != userId) {
            var userInfo = AppUser.fromJson(snapshot.data());

            allAppUsers.add(userInfo);
            counter = counter + 1;
            print("This is counter ${counter}");
          }
        }
      });

      await Future.delayed(Duration(seconds: 3));
      //   print(chats); //snapshots();
      return allAppUsers;
    } catch (error) {
      return [];
    }
  }

  Future<AppUser?> saveUsersCredentialslocal() async {
    try {
      AppUser? user = await getUsersCredentials();

      if (user != null) {
        final userJson = json.encode(user.toJson());

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', userJson);
      }
    } catch (error) {}
  }

  Future<void> saveMoreUsersInfo(
      List<String> skills, String bio, String technical, String looking) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).set(
        {
          'skills': skills,
          'bio': bio,
          'technical': technical,
          'looking': looking,
        },
        SetOptions(
          merge: true,
        ));
    return;
  }

  createChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Future<void> addChatRoom(chatRoom, chatRoomId) async {
    await chatFirebaseFirestore
        .doc(chatRoomId)
        .set(
            chatRoom,
            SetOptions(
              merge: true,
            ))
        .catchError((e) {
      print(e);
    });
  }

  Future<void> openChatroom(
      String currentUserName, String invitedUserName) async {
    List<String> users = [currentUserName, invitedUserName];

    String chatRoomId =
        await createChatRoomId(currentUserName, invitedUserName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    await addChatRoom(chatRoom, chatRoomId);

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => Chat(
    //               chatRoomId: chatRoomId,
    //             )))

    // ;
  }

  Future<void>? initalizeChat(String chatRoomId, chatMessageData) {
    chatFirebaseFirestore
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> sendMessage(
      {required String message,
      required String currentUserId,
      required String chatRoomId,
      required DateTime time}) async {
    if (message.isNotEmpty) {
      AppUser? listenerUser = await getUsersCredentialsbyid(currentUserId);
      Map<String, dynamic> chatMessageMap = {
        "sendBy": currentUserId,
        "message": message,
        'time': time,
        // "listenerName": listenerUser!.firstName,
        // "listenerImage": listenerUser.imageUrl,
        // "listenerId": listenerUser.imageUrl,
      };

      await initalizeChat(chatRoomId, chatMessageMap);
    }
  }

  getChats(String chatRoomId) async {
    return chatFirebaseFirestore
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  getUsers(String chatRoomId) async {
    return firebaseFirestore
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms(String currentUserId) async {
    return chatFirebaseFirestore
        .where("users", arrayContains: currentUserId)
        .orderBy("lastMessageSendTime", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getMatchedConnections(
      String currentUserId) async {
    return matchFirebaseFirestore
        .where("users", arrayContains: currentUserId)
        .where("isAccept", isEqualTo: "1")
        .orderBy("sentAt", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getAllRequest(String currentUserId) async {
    return matchFirebaseFirestore
        .where("users", arrayContains: currentUserId)
        .where("isAccept", isEqualTo: "0")
        .where("isReject", isEqualTo: "0")
        .where("sentBy", isNotEqualTo: currentUserId)
        .orderBy("sentBy", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getSentRequest(String currentUserId) async {
    return matchFirebaseFirestore
        .where("users", arrayContains: currentUserId)
        .where("isAccept", isEqualTo: "0")
        .where("isReject", isEqualTo: "0")
        .where("sentBy", isEqualTo: currentUserId)
        // .orderBy("sentBy", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getFailedConnections(
      String currentUserId) async {
    return matchFirebaseFirestore
        .where("users", arrayContains: currentUserId)
        .where("isReject", isEqualTo: "1")
        .orderBy("sentAt", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getTheUsers(
      List<dynamic> matchedUserId, String mainUserId) async {
    print(4949);
    print(matchedUserId);
    print(124);
    print(mainUserId);
    return firebaseFirestore
        .orderBy("id", descending: true)
        .where("id", whereNotIn: matchedUserId)
        // .where("id", isNotEqualTo: mainUserId)
        // .where("isReject", isEqualTo: "1")
        // .orderBy("technical", descending: true)
        .orderBy("technical", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> checkTheUsers(currentUserId, buddyUserId
      // String currentUserId
      ) async {
    String matchId = await createChatRoomId(currentUserId, buddyUserId);
    return matchFirebaseFirestore
        .where("matchId", isNotEqualTo: matchId)
        // .where("users", whereNotIn: )
        // .where("isReject", isEqualTo: "1")
        // .orderBy("sentAt", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String buddyUserId) async {
    return await firebaseFirestore.where("id", isEqualTo: buddyUserId).get();
  }

  Future<AppUser?> getThisUserInfo(
      String chatRoomId, String currentUserId) async {
    String? buddyUserId =
        chatRoomId.replaceAll(currentUserId, "").replaceAll("_", "");
    //QuerySnapshot querySnapshot = await getUserInfo(buddyUserId);
    AppUser? buddyDetails = await getUsersCredentialsbyid(buddyUserId);
    return buddyDetails;
  }

  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return chatFirebaseFirestore.doc(chatRoomId).set(
        lastMessageInfoMap,
        SetOptions(
          merge: true,
        ));
  }

  Future<void>? sendInvite(String matchId, chatMessageData) {
    matchFirebaseFirestore
        .doc(matchId)
        .set(
            chatMessageData,
            SetOptions(
              merge: true,
            ))
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void>? acceptInvite(String matchId) {
    matchFirebaseFirestore.doc(matchId).set(
        {
          "isAccept": "1",
        },
        SetOptions(
          merge: true,
        )).catchError((e) {
      print(e.toString());
    });
  }

  Future<void>? rejectInvite(String matchId) {
    matchFirebaseFirestore.doc(matchId).set(
        {
          "isReject": "1",
        },
        SetOptions(
          merge: true,
        )).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> initializeMatches(
      {required String currentUserId,
      required String invitedUserId,
      required DateTime time}) async {
    List<String> users = [currentUserId, invitedUserId];

    String matchId = await createChatRoomId(currentUserId, invitedUserId);

    Map<String, dynamic> matchesData = {
      "users": users,
      "matchId": matchId,
      "sentBy": currentUserId,
      "isAccept": "0",
      "isReject": "0",
      "sentAt": time,
    };
    await sendInvite(matchId, matchesData);
  }
}
