import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
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
    _twoUsers(users[ceiling - 1], users[ceiling]),
    _threeUsers(users[ceiling >= 2 ? ceiling - 2 : 0], users[ceiling - 1],
        users[ceiling]),
    _fourUsers(
        users[ceiling >= 3 ? ceiling - 3 : 0],
        users[ceiling >= 2 ? ceiling - 2 : 0],
        users[ceiling - 1],
        users[ceiling])
  ];
  return returnedWidget[ceiling - 1];
}

Container _fourUsers(
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
                _usersContainer(
                    user: user1,
                    height: 24.0,
                    width: 25.0,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                    )),
                _usersContainer(
                    user: user2,
                    height: 24.0,
                    width: 25.0,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50.0),
                    )),
              ],
            ),
            Row(
              children: [
                _usersContainer(
                    user: user3,
                    height: 24.0,
                    width: 25.0,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                    )),
                _usersContainer(
                    user: user4,
                    height: 24.0,
                    width: 25.0,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50.0),
                    )),
              ],
            ),
          ],
        ));

Container _threeUsers(
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
                _usersContainer(
                    user: user1,
                    height: 24.0,
                    width: 25.0,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                    )),
                _usersContainer(
                    user: user2,
                    height: 24.0,
                    width: 25.0,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50.0),
                    )),
              ],
            ),
            _usersContainer(
                user: user3,
                height: 24.0,
                width: 50.0,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0),
                )),
          ],
        ));

Container _twoUsers(types.User user1, types.User user2) => Container(
    height: 52.0,
    width: 50.0,
    decoration: const ShapeDecoration(
      shape: CircleBorder(),
    ),
    child: Column(
      children: [
        _usersContainer(
            user: user1,
            width: 50.0,
            height: 24.0,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            )),
        _usersContainer(
            user: user2,
            height: 24.0,
            width: 50.0,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0),
            )),
      ],
    ));

Container _usersContainer(
    {required types.User user,
    required double height,
    required double width,
    required BorderRadiusGeometry borderRadius}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        image: user.imageUrl != null
            ? DecorationImage(
                image: NetworkImage(user.imageUrl!), fit: BoxFit.cover)
            : null,
        color: colors[user.id.hashCode % colors.length],
        borderRadius: borderRadius),
    child: Center(
      child: Text(
        user.imageUrl == null ? user.firstName![0].toUpperCase() : '',
        style: const TextStyle(color: Colors.white, fontSize: 10.0),
      ),
    ),
  );
}
