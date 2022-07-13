//import 'dart:html';

class AppUser {
  final String? id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String? bio;
  final String? looking;
  final String? technical;
  final List<dynamic>? skills;
  final List<dynamic>? matchedUsers;

  final String imageUrl;

  AppUser({
    this.id,
    required this.firstName,
    required this.email,
    required this.phone,
    required this.lastName,
    required this.imageUrl,
    this.bio,
    this.looking,
    this.skills,
    this.technical,
    this.matchedUsers,
  });

  static AppUser fromJson(json) => AppUser(
      id: json['id'],
      phone: json['phoneNumber'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      bio: json['bio'],
      looking: json['looking'],
      technical: json['technical'],
      skills: json['skills'],
      matchedUsers: json['matchedUsers'],
      imageUrl: json['imageUrl']);

  Map<String, dynamic> toJson() => {
        "bio": bio,
        "id": id,
        "looking": looking,
        "technical": technical,
        "skills": skills,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phone,
        "email": email,
        "imageUrl": imageUrl,
        "matchedUsers": matchedUsers,
      };
}

class User1 {
  final String name;

  final String commitment;

  final String imageUrl;
  final String hasIdea;
  final String hasTechical;
  final String state;
  final String country;
  final String city;
  final String bio;

  User1(
      {required this.name,
      required this.commitment,
      required this.imageUrl,
      required this.hasIdea,
      required this.hasTechical,
      required this.state,
      required this.country,
      required this.city,
      required this.bio});

  static List<User1> users = [
    User1(
        name: 'Benita Ike',
        commitment: '20 hours',
        imageUrl:
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDIwfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
        hasIdea: 'Yes',
        hasTechical: 'Yes',
        state: 'Lagos',
        bio:
            'Hey! I am passionate about technology and love to build things. I am obsessed with learning new things everyday. I am a self taught software dev and i have always been a tech geek. I would love to find someone as passionate about changing education industry with techology.',
        country: 'Nigeria',
        city: 'Lekki'),
    // User(
    //     name: 'Benita Ike',
    //     commitment: '20 hours',
    //     imageUrl:
    //         'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDIwfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
    //     hasIdea: 'Yes',
    //     hasTechical: 'Yes',
    //     state: 'Lagos',
    //     bio:
    //         'Hey! I am passionate about technology and love to build things. I am obsessed with learning new things everyday. I am a self taught software dev and i have always been a tech geek. I would love to find someone as passionate about changing education industry with techology.',
    //     country: 'Nigeria',
    //     city: 'Lekki'),
    // User(
    //     name: 'Benita Ike',
    //     commitment: '20 hours',
    //     imageUrl:
    //         'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDIwfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
    //     hasIdea: 'Yes',
    //     hasTechical: 'Yes',
    //     state: 'Lagos',
    //     bio:
    //         'Hey! I am passionate about technology and love to build things. I am obsessed with learning new things everyday. I am a self taught software dev and i have always been a tech geek. I would love to find someone as passionate about changing education industry with techology.',
    //     country: 'Nigeria',
    //     city: 'Lekki'),
    // User(
    //     name: 'Benita Ike',
    //     commitment: '20 hours',
    //     imageUrl:
    //         'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDIwfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
    //     hasIdea: 'Yes',
    //     hasTechical: 'Yes',
    //     state: 'Lagos',
    //     bio:
    //         'Hey! I am passionate about technology and love to build things. I am obsessed with learning new things everyday. I am a self taught software dev and i have always been a tech geek. I would love to find someone as passionate about changing education industry with techology.',
    //     country: 'Nigeria',
    //     city: 'Lekki'),
    // User(
    //     name: 'Benita Ike',
    //     commitment: '20 hours',
    //     imageUrl:
    //         'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDIwfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
    //     hasIdea: 'Yes',
    //     hasTechical: 'Yes',
    //     state: 'Lagos',
    //     bio:
    //         'Hey! I am passionate about technology and love to build things. I am obsessed with learning new things everyday. I am a self taught software dev and i have always been a tech geek. I would love to find someone as passionate about changing education industry with techology.',
    //     country: 'Nigeria',
    //     city: 'Lekki'),
  ];
}

class Conversation {
  final String name;

  final String duration;

  final String imageUrl;

  final String content;

  Conversation({
    required this.name,
    required this.imageUrl,
    required this.duration,
    required this.content,
  });

  static List<Conversation> conversations = [
    Conversation(
      name: 'Frank Kalu',
      imageUrl:
          'https://images.unsplash.com/photo-1520943219761-6ca840e2e585?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE4fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
      duration: '3 weeks',
      content: 'Great, I look forward to...',
    ),
    Conversation(
      name: 'Adam Kanayo',
      imageUrl:
          'https://images.unsplash.com/photo-1530021232320-687d8e3dba54?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDd8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      duration: '1 month',
      content: 'Great, I look forward to...',
    ),
    Conversation(
      name: 'Peter Leno',
      imageUrl:
          'https://images.unsplash.com/flagged/photo-1558085140-c899b1bc1ce5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MTB8MjMwMjQzODd8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
      duration: '1 month',
      content: 'Great, I look forward to...',
    ),
    Conversation(
      name: 'Nkethi Ann',
      imageUrl:
          'https://images.unsplash.com/photo-1623954360656-c259d5be351c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MTF8MjMwMjQzODd8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
      duration: '2 months',
      content:
          'Great, I look forward to connecting and going over the different possibilities. Please find my details below \n \n \nSkype: NkethiAnn \n \n \n \nSent on July 16, 2021',
    ),
    Conversation(
      name: 'Alex Pierre',
      imageUrl:
          'https://images.unsplash.com/photo-1639928758287-db12413453c8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80',
      duration: '3 months',
      content: 'Great, I look forward to...',
    ),
  ];
}

class Message {
  final String message;
  final DateTime time;
  final String sendBy;

  Message({
    required this.message,
    required this.sendBy,
    required this.time,
  });

  static Message fromJson(json) => Message(
        message: json['message'],
        time: json['time'],
        sendBy: json['sendBy'],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "time": time,
        "sendBy": sendBy,
      };
}

class ChatRoom {
  final String chatRoomId;
  final List<dynamic> users;
  // final String sendBy;

  ChatRoom({
    required this.users,
    required this.chatRoomId,
    //required this.time,
  });

  static ChatRoom fromJson(json) => ChatRoom(
        users: json['users'],
        chatRoomId: json['chatRoomId'],
        //sendBy: json['sendBy'],
      );

  Map<String, dynamic> toJson() => {
        "users": users,
        "chatRoomId": chatRoomId,
        //"sendBy": sendBy,
      };
}

class ChatMap {
  final String chatRoomId;
  final AppUser users;
  // final String sendBy;

  ChatMap({
    required this.users,
    required this.chatRoomId,
    //required this.time,
  });
}
