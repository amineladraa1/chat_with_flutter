import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:my_chat/screens/rooms.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class FireApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///////////////// signin Logic
  void signinWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential credenial = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credenial.user != null) {
        Navigator.pushNamed(context, MyRooms.roomsId);
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Attention',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              content: Text(e.toString()),
            );
          });
    }
  }

  ///////////////// signup Logic
  void signupWithEmailAndPassword(String email, String password, String name,
      String lastName, BuildContext context) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCred.user != null) {
        await FirebaseChatCore.instance.createUserInFirestore(
          types.User(
            firstName: name,

            id: userCred.user!.uid, // UID from Firebase Authentication

            lastName: lastName,
          ),
        );
        Navigator.pushNamed(context, MyRooms.roomsId);
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Attention',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              content: Text(e.toString()),
            );
          });
    }
  }
}
