
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../screens/chat.dart';
import '../util.dart';

class ChatBrain {


  buildAvatar(EdgeInsetsGeometry padding, EdgeInsetsGeometry margin,
      double fontSize, types.User user,double radius) {
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

    // navigator.pop();
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => MyChat(
          room: room,
          otherUser: otherUser,
        ),
      ),
    );
  }


}
