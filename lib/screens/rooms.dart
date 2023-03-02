// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:my_chat/screens/chat.dart';
import 'package:my_chat/screens/users.dart';
import 'package:my_chat/ui/rooms_app_bar.dart';
import '../constants/constants.dart';
import 'package:badges/badges.dart';

import '../util.dart';

class MyRooms extends StatefulWidget {
  const MyRooms({Key? key}) : super(key: key);
  static String roomsId = 'MyRooms';

  @override
  State<MyRooms> createState() => _MyRoomsState();
}

class _MyRoomsState extends State<MyRooms> {
  List<int> selectedIndex = [];
  bool isLongedPressed = false;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffFFAAC3).withAlpha(120),

      body: StreamBuilder<List<types.Room>>(
          initialData: const [],
          stream: _sortStreamByUpdatedAt(
            FirebaseChatCore.instance.rooms(),
          ),
          builder: ((context, snapshot) {
            return !snapshot.hasData || snapshot.data!.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                        delegate: _SliverRoomAppBar(),
                        // Set this param so that it won't go off the screen when scrolling
                        pinned: true,
                      ),
                      SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        final room = snapshot.data![index];

                        final unreadMessage =
                            room.metadata!['unreadMessages'].length;
                        final unreadMessageUser = room.metadata!['userId'];

                        return roomListTile(
                            index, room, unreadMessage, unreadMessageUser);
                      }, childCount: snapshot.data!.length)),
                    ],
                  );
          })),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MyUsers.usersId);
        },
        backgroundColor: kBlueGrey,
        child: const Icon(
          Icons.post_add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  ListTile roomListTile(
      int index, types.Room room, unreadMessage, unreadMessageUser) {
    return ListTile(
      onLongPress: () => setState(() {
        selectedIndex.add(index);
        isLongedPressed = true;
      }),
      onTap: isLongedPressed == true
          ? () => setState(() {
                if (selectedIndex.contains(index)) {
                  selectedIndex.remove(index);
                } else {
                  selectedIndex.add(index);
                }
              })
          : (() => _onTap(room)),

      // todo : create a build avatar for the room
      selectedTileColor: const Color.fromARGB(48, 158, 158, 158),
      selectedColor: Colors.black54,
      tileColor: unreadMessage > 0 && unreadMessageUser != currentUser
          ? const Color.fromARGB(48, 158, 158, 158)
          : null,
      selected: selectedIndex.contains(index) ? true : false,
      leading: Badge(
        position: BadgePosition.bottomEnd(bottom: -4, end: -6),
        showBadge: selectedIndex.contains(index) ? true : false,
        elevation: 0,
        badgeColor: kBlueGrey,
        badgeContent: const Icon(
          Icons.check,
          size: 12.0,
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(5.0),
        borderSide: const BorderSide(
          width: 2.0,
          color: Color.fromARGB(179, 158, 158, 158),
        ),
        child: customAvatar(room.users),
      ),
      title: Text(
        room.name ?? '',
        style: TextStyle(
            color: Colors.black87,
            fontWeight:
                // ignore: iterable_contains_unrelated_type
                unreadMessage > 0 && unreadMessageUser != currentUser
                    ? FontWeight.w600
                    : null),
      ),
      subtitle: unreadMessage > 0 && unreadMessageUser != currentUser
          ? Text(
              '$unreadMessage New Messages',
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w600),
            )
          : Text(chatBrain.roomCreatedAtBuilder(
              DateTime.fromMillisecondsSinceEpoch(room.createdAt!).day,
              DateTime.fromMillisecondsSinceEpoch(room.createdAt!).month - 1)),

      trailing: unreadMessage > 0 && unreadMessageUser != currentUser
          ? const Icon(
              Icons.wechat,
              color: Colors.red,
            )
          : const Text(''),
    );
  }

  void _onTap(types.Room room) {
    final updatedRoom =
        room.copyWith(metadata: {'unreadMessages': [], 'userId': ''});
    FirebaseChatCore.instance.updateRoom(updatedRoom);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyChat(
                  otherUsers: room.users,
                  room: room,
                )));
  }
}

Stream<List<types.Room>> _sortStreamByUpdatedAt(
    Stream<List<types.Room>> stream) {
  Stream<List<types.Room>> sortedStream = stream.transform(
    StreamTransformer.fromHandlers(
      handleData: (list, sink) {
        List<types.Room> sortedList = list.toList();

        sortedList.sort(
            (a, b) => b.updatedAt!.toInt().compareTo(a.updatedAt!.toInt()));

        sink.add(sortedList);
      },
    ),
  );

  return sortedStream;
}

class _SliverRoomAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var adjustedShrikOffset =
        shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrikOffset) * 0.5;
    double topPadding = MediaQuery.of(context).padding.top + 40;

    return SizedBox(
      height: 280,
      child: RoomCustomAppBar(
        offset: offset,
        topPadding: topPadding,
      ),
    );
  }

  @override
  double get maxExtent => 280;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
