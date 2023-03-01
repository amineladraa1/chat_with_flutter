import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:my_chat/services/chat_brain.dart';

import '../constants/constants.dart';
import '../util.dart';

class ChatAppBar extends StatefulWidget with PreferredSizeWidget {
  ChatAppBar({super.key, required this.room});
  final types.Room room;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  late int numOfUsers;
  late int ceiling = numOfUsers <= 4 ? numOfUsers : 4;
  ChatBrain chatBrain = ChatBrain();

  @override
  void initState() {
    super.initState();
    numOfUsers = widget.room.users.length;
  }

  @override
  Widget build(BuildContext context) {
    if (numOfUsers == 2) {
      types.User otherUser = widget.room.users[1];
      return AppBar(
        backgroundColor: kBlueGrey,
        elevation: 1,
        leading: chatBrain.buildAvatar(const EdgeInsets.only(left: 20.0),
            EdgeInsets.zero, 15.5, otherUser, 15.0),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getUserName(otherUser),
              style: const TextStyle(fontSize: 16.0),
            ),
            Text(
              chatBrain.lastSeenBuilder(
                  DateTime.fromMillisecondsSinceEpoch(otherUser.lastSeen!).day,
                  DateTime.fromMillisecondsSinceEpoch(otherUser.lastSeen!)
                          .month -
                      1),
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.white54,
              ),
            )
          ],
        ),
      );
    }
    return AppBar(
      backgroundColor: kBlueGrey,
      elevation: 1,
      leadingWidth: (ceiling * 0.8 * 40),
      leading: SizedBox(
        // width: 200.0,
        child: Stack(
          alignment: AlignmentDirectional.center,
          // fit: StackFit.expand,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            for (var i = 0; i < ceiling; i++)
              Positioned(
                  left: (i * 0.6 * 40).toDouble(),
                  // left: 0,
                  child: chatBrain.buildAvatar(EdgeInsets.zero, EdgeInsets.zero,
                      10.0, widget.room.users[i], 20.0))
          ],
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.room.name ?? '',
            style: const TextStyle(fontSize: 16.0),
          ),
          Text(
            '${numOfUsers - 1} users',
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.white54,
            ),
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

AppBar buildChatAppBar(types.Room room) {
  int numOfUsers = room.users.length;
  int ceiling = numOfUsers <= 4 ? numOfUsers : 4;
  if (numOfUsers == 2) {
    types.User otherUser = room.users[1];
    return AppBar(
      backgroundColor: kBlueGrey,
      elevation: 1,
      leading: chatBrain.buildAvatar(const EdgeInsets.only(left: 20.0),
          EdgeInsets.zero, 15.5, otherUser, 15.0),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getUserName(otherUser),
            style: const TextStyle(fontSize: 16.0),
          ),
          Text(
            chatBrain.lastSeenBuilder(
                DateTime.fromMillisecondsSinceEpoch(otherUser.lastSeen!).day,
                DateTime.fromMillisecondsSinceEpoch(otherUser.lastSeen!).month -
                    1),
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.white54,
            ),
          )
        ],
      ),
    );
  }
  return AppBar(
    backgroundColor: kBlueGrey,
    elevation: 1,
    leadingWidth: 150.0,
    leading: SizedBox(
      // width: 200.0,
      child: Stack(
        alignment: AlignmentDirectional.center,
        // fit: StackFit.expand,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          for (var i = 0; i < ceiling; i++)
            Positioned(
                left: (i * 0.6 * 40).toDouble(),
                // left: 0,
                child: chatBrain.buildAvatar(EdgeInsets.zero, EdgeInsets.zero,
                    10.0, room.users[i], 20.0))
        ],
      ),
    ),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          room.name ?? '',
          style: const TextStyle(fontSize: 16.0),
        ),
        Text(
          '${numOfUsers - 1} users',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.white54,
          ),
        )
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
      ),
    ],
  );
}
