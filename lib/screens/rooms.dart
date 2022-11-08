import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import '../constants/constants.dart';

class MyRooms extends StatelessWidget {
  const MyRooms({Key? key}) : super(key: key);
  static String roomsId = 'MyRooms';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(),
          backgroundColor: kBlueGrey,
          title: const Text('Rooms'),
        ),
        body: StreamBuilder<List<types.Room>>(
            initialData: const [],
            stream: FirebaseChatCore.instance.rooms(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    bottom: 200,
                  ),
                  child: const Text('No rooms'),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) {
                    final room = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => MyChat(room: room)));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          // todo : create a build avatar for the room
                          leading: const CircleAvatar(
                            backgroundColor: kOrange,
                            radius: 25.0,
                          ),
                          title: Text(room.name ?? ''),
                          subtitle: Text(room.createdAt.toString()),
                        ),
                      ),
                    );
                  }));
            })));
  }
}
