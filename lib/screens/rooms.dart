import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import '../constants/constants.dart';
import 'package:badges/badges.dart';

class MyRooms extends StatefulWidget {
  const MyRooms({Key? key}) : super(key: key);
  static String roomsId = 'MyRooms';

  @override
  State<MyRooms> createState() => _MyRoomsState();
}

class _MyRoomsState extends State<MyRooms> {
  List<int> selectedIndex = [];
  bool isLongedPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(),
        backgroundColor: kBlueGrey,
        elevation: 0.0,
        title: const Text('Rooms'),
      ),
      body: Stack(children: [
        StreamBuilder<List<types.Room>>(
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
              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
                      final room = snapshot.data![index];
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
                            : null,
                        // todo : create a build avatar for the room
                        selectedTileColor:
                            const Color.fromARGB(48, 158, 158, 158),
                        selectedColor: Colors.black54,

                        selected: selectedIndex.contains(index) ? true : false,
                        leading: Badge(
                          position:
                              BadgePosition.bottomEnd(bottom: -4, end: -6),
                          showBadge:
                              selectedIndex.contains(index) ? true : false,
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
                          child: const CircleAvatar(
                            backgroundColor: kOrange,
                            radius: 25.0,
                          ),
                        ),
                        title: Text(room.name ?? ''),
                        subtitle: Text(room.createdAt.toString()),
                      );
                    })),
              );
            })),
        DraggableScrollableSheet(
          initialChildSize: 0.2,
          minChildSize: 0.15,
          maxChildSize: 0.8,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.blue[100],
              child: ListView.builder(
                controller: scrollController,
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(title: Text('Item $index'));
                },
              ),
            );
          },
        ),
      ]),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: kBlueGrey,
      //   child: const Icon(
      //     Icons.post_add_rounded,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
