import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class NotificationRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future sendInboxNotification(
    String title,
    String token,
    String name,
  ) async {
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': title,
    };

    try {
      http.Response response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization':
                    'key=AAAA5n24nHs:APA91bH1eHuVe4PtEdEgszfrt6zsEtGmnmS4aSwfRvZ83ukan4RyTV-soCYSRlblSipTvVU8lokGTnfqBukQPbC0iBb0_NZXSlehKQpUgRyF2hMg720KDc-PA6xYQJ4mIgGUDjoN6dzs'
              },
              body: jsonEncode(<String, dynamic>{
                'notification': <String, dynamic>{'title': name, 'body': title},
                'priority': 'high',
                'data': data,
                'to': token
              }));

      if (response.statusCode == 200) {
        print("Your notification is sent");
      } else {
        print("Error");
      }
    } catch (e) {}
  }
}
