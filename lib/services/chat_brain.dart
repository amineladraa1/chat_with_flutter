import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:bubble/bubble.dart';

import '../constants/constants.dart';
import '../screens/chat.dart';
import '../util.dart';

class ChatBrain {
  final User? _user = FirebaseChatCore.instance.firebaseUser;
  final List<String> _months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  buildAvatar(EdgeInsetsGeometry padding, EdgeInsetsGeometry margin,
      double fontSize, types.User user, double radius) {
    final color = getUserAvatarNameColor(user);
    final hasImage = user.imageUrl != null;
    final name = getUserName(user);

    return Container(
      margin: margin,
      padding: padding,
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(user.imageUrl!) : null,
        radius: radius,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: fontSize),
              )
            : null,
      ),
    );
  }

  void handlePressed(types.User otherUser, BuildContext context) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    // final room = await FirebaseChatCore.instance.createGroupRoom(name: name, users: users);

    await navigator.push(
      MaterialPageRoute(
        builder: (context) => MyChat(
          room: room,
          otherUser: otherUser,
        ),
      ),
    );
  }

  String lastSeenBuilder(int day, int month) {
    return 'last Seen  $day ${_months[month]}';
  }

  Widget bubbleBuilder(
    Widget child, {
    required message,
    required nextMessageInGroup,
  }) =>
      Bubble(
        color: _user?.uid != message.author.id ||
                message.type == types.MessageType.image
            ? const Color(0xfff5f5f7)
            : kBlueGrey,
        margin: nextMessageInGroup
            ? const BubbleEdges.symmetric(horizontal: 6)
            : null,
        nip: nextMessageInGroup
            ? BubbleNip.no
            : _user?.uid != message.author.id
                ? BubbleNip.leftBottom
                : BubbleNip.rightBottom,
        child: child,
      );
}
