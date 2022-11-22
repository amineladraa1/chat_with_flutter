import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:my_chat/services/chat_brain.dart';

ChatBrain chatBrain = ChatBrain();

const colors = [
  Color(0xffff6767),
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];

Color getUserAvatarNameColor(types.User user) {
  final index = user.id.hashCode % colors.length;
  return colors[index];
}

String getUserName(types.User user) =>
    '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();

Widget customAvatar(List<types.User> users) {
  int ceiling = users.length <= 4 ? users.length - 1 : 4;

  List<Widget> returnedWidget = [
    chatBrain.buildAvatar(
        EdgeInsets.zero, EdgeInsets.zero, 0.0, users[1], 25.0),
    twoUsers(users[ceiling - 1], users[ceiling]),
    threeUsers(users[ceiling >= 2 ? ceiling - 2 : 0], users[ceiling - 1],
        users[ceiling]),
    fourUsers(
        users[ceiling >= 3 ? ceiling - 3 : 0],
        users[ceiling >= 2 ? ceiling - 2 : 0],
        users[ceiling - 1],
        users[ceiling])
  ];
  return returnedWidget[ceiling - 1];
}

Container fourUsers(
  types.User user1,
  types.User user2,
  types.User user3,
  types.User user4,
) =>
    Container(
        height: 52.0,
        width: 50.0,
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 24.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                      image: user1.imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(user1.imageUrl!))
                          : null,
                      color: colors[user1.id.hashCode % colors.length],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                      )),
                  child: Center(
                    child: Text(
                      user1.firstName![0].toUpperCase(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                ),
                Container(
                  height: 24.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                      image: user2.imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(user2.imageUrl!))
                          : null,
                      color: colors[user2.id.hashCode % colors.length],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50.0),
                      )),
                  child: Center(
                    child: Text(
                      user2.firstName![0].toUpperCase(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 24.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                      image: user3.imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(user3.imageUrl!))
                          : null,
                      color: colors[user3.id.hashCode % colors.length],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                      )),
                  child: Center(
                      child: Text(
                    user3.firstName![0].toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 10.0),
                  )),
                ),
                Container(
                  height: 24.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                      image: user4.imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(user4.imageUrl!))
                          : null,
                      color: colors[user4.id.hashCode % colors.length],
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(50.0),
                      )),
                  child: Center(
                    child: Text(
                      user4.firstName![0].toUpperCase(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));

Container threeUsers(
  types.User user1,
  types.User user2,
  types.User user3,
) =>
    Container(
        height: 52.0,
        width: 50.0,
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 24.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                      image: user1.imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(user1.imageUrl!))
                          : null,
                      color: colors[user1.id.hashCode % colors.length],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                      )),
                  child: Center(
                    child: Text(
                      user1.firstName![0].toUpperCase(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                ),
                Container(
                  height: 24.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                      image: user2.imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(user2.imageUrl!))
                          : null,
                      color: colors[user2.id.hashCode % colors.length],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50.0),
                      )),
                  child: Center(
                    child: Text(
                      user2.firstName![0].toUpperCase(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 24.0,
              width: 50.0,
              decoration: BoxDecoration(
                  image: user3.imageUrl != null
                      ? DecorationImage(image: NetworkImage(user3.imageUrl!))
                      : null,
                  color: colors[user3.id.hashCode % colors.length],
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                  )),
              child: Center(
                child: Text(
                  user3.firstName![0].toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 10.0),
                ),
              ),
            ),
          ],
        ));

Container twoUsers(types.User user1, types.User user2) => Container(
    height: 52.0,
    width: 50.0,
    decoration: const ShapeDecoration(
      shape: CircleBorder(),
    ),
    child: Column(
      children: [
        Container(
          height: 24.0,
          width: 50.0,
          decoration: BoxDecoration(
              image: user1.imageUrl != null
                  ? DecorationImage(image: NetworkImage(user1.imageUrl!))
                  : null,
              color: colors[user1.id.hashCode % colors.length],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(100.0),
                topRight: Radius.circular(100.0),
              )),
          child: Center(
            child: Text(
              user1.firstName![0].toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          ),
        ),
        Container(
          height: 24.0,
          width: 50.0,
          decoration: BoxDecoration(
              image: user2.imageUrl != null
                  ? DecorationImage(image: NetworkImage(user2.imageUrl!))
                  : null,
              color: colors[user2.id.hashCode % colors.length],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(100.0),
                bottomRight: Radius.circular(100.0),
              )),
          child: Center(
            child: Text(
              user2.firstName![0].toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          ),
        ),
      ],
    ));
