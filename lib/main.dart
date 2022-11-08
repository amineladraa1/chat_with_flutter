import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_chat/screens/login.dart';
import 'package:my_chat/screens/my_home_page.dart';
import 'package:my_chat/screens/register.dart';
import 'package:my_chat/screens/rooms.dart';
import 'package:my_chat/screens/users.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initializeFireBaseApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  void initState() {
    super.initState();
    initializeFireBaseApp();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        MyLogin.loginId: (context) => const MyLogin(),
        MyRegister.registerId: (context) => const MyRegister(),
        // MyChat.chatId: (context) =>  MyChat(),
        MyUsers.usersId: (context) => MyUsers(),
        MyRooms.roomsId: (context) => const MyRooms(),
      },
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}
