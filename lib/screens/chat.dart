import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyChat extends StatefulWidget {
  static String chatId = 'MyChat';
  const MyChat({Key? key}) : super(key: key);

  @override
  State<MyChat> createState() => _MyChatState();
}

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class _MyChatState extends State<MyChat> {
  final user = FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseFirestore.instance;

  late final _name;
  late final _uid;
  final List<types.Message> _messages = [];
  late final _user = types.User(id: _uid, firstName: _name);
  @override
  void initState() {
    super.initState();
    _addMessage();
    if (user != null) {
      _name = user?.displayName;
      _uid = user?.uid;
    } else {
      _name = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4c505b),
        title: Text(_name),
      ),
      body: Chat(
        theme: const DefaultChatTheme(
          inputBackgroundColor: Color(0xff4c505b),
        ),
        messages: _messages,
        onSendPressed: _handleSendPressedToFireStore,
        user: _user,
      ),
    );
  }

  void _addMessage() async {
    Stream<QuerySnapshot<Map<String, dynamic>>> messagesCollection;
    try {
      messagesCollection = _fireStore.collection('messages').snapshots();
      await for (var messages in messagesCollection) {
        for (var message in messages.docs) {
          // this create a user from the class chat user
          final user = types.User(
              id: message.data()['author']['id'],
              firstName: message.data()['author']['firstName']);

          // this create a textMessage from the class chat types
          final textMessage = types.TextMessage(
            id: message.data()['id'],
            author: user,
            // type: message.data()['type'],
            createdAt: message.data()['createdAt'],
            text: message.data()['text'],
          );
          print(textMessage);
          // add the message to the list directly
          setState(() {
            _messages.add(textMessage);
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void _handleSendPressedToFireStore(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );
    try {
      final toPrint =
          await _fireStore.collection('messages').add(textMessage.toJson());
      print(toPrint);
    } catch (e) {
      print(e);
    }
  }
}
