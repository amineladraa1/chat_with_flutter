import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:my_chat/constants/constants.dart';
import 'package:my_chat/services/chat_brain.dart';

import 'package:my_chat/util.dart';

class MyUsers extends StatelessWidget {
  static String usersId = 'MyUsers';

  MyUsers({super.key});
  ChatBrain chatBrain = ChatBrain();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(),
          backgroundColor: kBlueGrey,
          title: const Text('All Users'),
        ),
        body: StreamBuilder<List<types.User>>(
          stream: FirebaseChatCore.instance.users(),
          initialData: const [],
          builder: (context, snapshot) {
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

                return GestureDetector(
                  onTap: () {
                    chatBrain.handlePressed(user, context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                        mouseCursor: MouseCursor.defer,
                        leading: chatBrain.buildAvatar(EdgeInsets.zero,
                            const EdgeInsets.only(right: 10), 0.0, user, 25.0),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getUserName(user)),
                            Text(
                              chatBrain.lastSeenBuilder(
                                  DateTime.fromMillisecondsSinceEpoch(
                                          user.lastSeen!)
                                      .day,
                                  DateTime.fromMillisecondsSinceEpoch(
                                              user.lastSeen!)
                                          .month -
                                      1),
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black45,
                              ),
                            )
                          ],
                        )),
                  ),
                );
              },
            );
          },
        ),
      );
}
