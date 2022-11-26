import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:my_chat/constants/constants.dart';
import 'package:my_chat/services/chat_brain.dart';
import 'package:badges/badges.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_chat/util.dart';

import '../ui/modal_bottom_sheet_body.dart';

class MyUsers extends StatefulWidget {
  static String usersId = 'MyUsers';

  const MyUsers({super.key});

  @override
  State<MyUsers> createState() => _MyUsersState();
}

class _MyUsersState extends State<MyUsers> {
  ChatBrain chatBrain = ChatBrain();
  List<int> selectedIndex = [];
  List<types.User> selectedUsers = [];
  bool isLongedPressed = false;
  @override
  Widget build(BuildContext context) => Scaffold(

        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(),
          backgroundColor: kBlueGrey,
          elevation: 0.0,
          title: const Text('Select Users'),
        ),
        body: StreamBuilder<List<types.User>>(
          stream: FirebaseChatCore.instance.users(),
          initialData: const [],
          builder: ((context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 200,
                ),
                child: const Text('No users'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];

                return ListTile(
                  onLongPress: () => setState(() {
                    selectedIndex.add(index);
                    isLongedPressed = true;
                    selectedUsers.add(user);
                  }),
                  onTap: isLongedPressed == true
                      ? () => setState(() {
                            if (selectedIndex.contains(index)) {
                              selectedIndex.remove(index);
                              selectedUsers.remove(user);
                            } else {
                              selectedIndex.add(index);
                              selectedUsers.add(user);
                            }
                          })
                      : null,
                  selectedTileColor: const Color.fromARGB(48, 158, 158, 158),
                  selectedColor: Colors.black,
                  selected: selectedIndex.contains(index) ? true : false,
                  mouseCursor: MouseCursor.defer,
                  // leading: chatBrain.buildAvatar(EdgeInsets.zero,
                  //     const EdgeInsets.only(right: 10), 0.0, user, 25.0),
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
                    child: chatBrain.buildAvatar(
                        EdgeInsets.zero, EdgeInsets.zero, 0.0, user, 25.0),
                  ),
                  title: Text(getUserName(user)),
                  subtitle: Text(
                    chatBrain.lastSeenBuilder(
                        DateTime.fromMillisecondsSinceEpoch(user.lastSeen!).day,
                        DateTime.fromMillisecondsSinceEpoch(user.lastSeen!)
                                .month -
                            1),
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black45,
                    ),
                  ),
                );
              },
            );
          }),
        ),
        floatingActionButton: selectedIndex.isNotEmpty
            ? FloatingActionButton(
                onPressed: () async {
                  // FirebaseChatCore.instance.createGroupRoom(name: name, users:selectedUsers);
                  await showCupertinoModalBottomSheet(
                    context: context,
                    expand: kIsWeb ? false : true,
                    builder: (context) => ModalBottomSheetBody(
                        selectedUsers: selectedUsers, chatBrain: chatBrain),
                  );
                },
                backgroundColor: kBlueGrey,
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              )
            : null,
      );
}
