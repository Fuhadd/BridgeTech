import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  Future<void> updateUserCredentials({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String bio,
    required List skills,
    required String technical,
    required String looking,
  }) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).set(
        {
          'id': uid.toString(),
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'bio': bio,
          'technical': technical,
          'looking': looking,
          'skills': skills,
        },
        SetOptions(
          merge: true,
        ));
    return;
  }

  Future<void> saveMatched(List<String> matchedUserId) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).update(
      {
        'matchedUsers': FieldValue.arrayUnion(matchedUserId),
      },
    );
    return;
  }

  Future<void> storeNotificationToken() async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    String? token = await FirebaseMessaging.instance.getToken();

    await firebaseFirestore.doc(uid.toString()).set(
        {
          'token': token,
        },
        SetOptions(
          merge: true,
        ));
    return;
  }

  Future<void> saveMatchedBuddy(
      String buddyUid, List<String> matchedUserId) async {
    await firebaseFirestore.doc(buddyUid.toString()).update(
      {
        'matchedUsers': FieldValue.arrayUnion(matchedUserId),
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
      }
    } catch (error) {}
    return null;
  }

  Future<AppUser?> getUsersCredentialsbyid(String uid) async {
    try {
      final appUser = firebaseFirestore.doc(uid);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        return AppUser.fromJson(snapshot.data());
      }
    } catch (error) {}
    return null;
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
    } catch (error) {
      return false;
    }
  }

  Future<AppUser?> saveUsersCredentialslocal() async {
    try {
      AppUser? user = await getUsersCredentials();

      print(user);

      if (user != null) {
        final userJson = json.encode(user.toJson());

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', userJson);
      }
    } catch (error) {}
    return null;
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
      return "${b}_$a";
    } else {
      return "${a}_$b";
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
  }

  Future<void>? initalizeChat(String chatRoomId, chatMessageData) {
    chatFirebaseFirestore
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
    return null;
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
        .snapshots();
  }

  Future<Stream<DocumentSnapshot>> getCurrentUserProfile() async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    return firebaseFirestore.doc(uid).snapshots();
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
        .orderBy("technical", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> checkTheUsers(
      currentUserId, buddyUserId) async {
    String matchId = await createChatRoomId(currentUserId, buddyUserId);
    return matchFirebaseFirestore
        .where("matchId", isNotEqualTo: matchId)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String buddyUserId) async {
    return await firebaseFirestore.where("id", isEqualTo: buddyUserId).get();
  }

  Future<AppUser?> getThisUserInfo(
      String chatRoomId, String currentUserId) async {
    String? buddyUserId =
        chatRoomId.replaceAll(currentUserId, "").replaceAll("_", "");

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
    return null;
  }

  Future<void>? acceptInvite(String matchId) {
    print(matchId);
    matchFirebaseFirestore.doc(matchId).set(
        {
          "isAccept": "1",
        },
        SetOptions(
          merge: true,
        )).catchError((e) {
      print(e.toString());
    });
    return null;
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
    return null;
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

  Future<void> unMatch({
    required String currentUserId,
    required String invitedUserId,
  }) async {
    List<String> users = [currentUserId, invitedUserId];

    String matchId = await createChatRoomId(currentUserId, invitedUserId);

    await chatFirebaseFirestore.doc(matchId).delete().catchError((e) {
      print(e.toString());
    });

    await matchFirebaseFirestore.doc(matchId).delete().catchError((e) {
      print(e.toString());
    });
  }

  Future<String> getUserTokenbyid(String uid) async {
    try {
      final appUser = firebaseFirestore.doc(uid);
      var snapshot = await appUser.get();

      if (snapshot.exists) {
        dynamic data = snapshot.data();
        String value = data?['token'];
        return value;
      }
    } catch (error) {}
    return '';
  }

  Future<UnreadModel?> getUserunreadbyid({
    required String currentUserId,
    required String invitedUserId,
  }) async {
    try {
      String matchId = await createChatRoomId(currentUserId, invitedUserId);
      final appUser = chatFirebaseFirestore.doc(matchId);
      var snapshot = await appUser.get();

      if (snapshot.exists) {
        dynamic data = snapshot.data();
        int unreadCount = data?['unreadCount'] ?? 0;
        String unreadBy = data?['unreadBy'];
        UnreadModel result =
            UnreadModel(unreadBy: unreadBy, unreadCount: unreadCount);
        return result;
      }
    } catch (error) {}
    return null;
  }

  Future<void>? updateUnreadCount(
      {required String chatRoomId,
      required String unreadBy,
      required int unreadCount}) async {
    chatFirebaseFirestore.doc(chatRoomId).set(
        {
          "unreadCount": unreadCount,
          "unreadBy": unreadBy,
        },
        SetOptions(
          merge: true,
        )).catchError((e) {
      print(e.toString());
    });
    return;
  }
}
