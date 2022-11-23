import 'package:my_chat/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:my_chat/services/chat_brain.dart';
import 'package:my_chat/constants/constants.dart';

class ModalBottomSheetBody extends StatefulWidget {
  const ModalBottomSheetBody({
    Key? key,
    required this.selectedUsers,
    required this.chatBrain,
  }) : super(key: key);

  final List<types.User> selectedUsers;
  final ChatBrain chatBrain;

  @override
  State<ModalBottomSheetBody> createState() => _ModalBottomSheetBodyState();
}

class _ModalBottomSheetBodyState extends State<ModalBottomSheetBody> {
  String name = '';
  bool isInputChanged = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.0,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: SizedBox(
                  height: 100.0,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.selectedUsers.length,
                      itemBuilder: ((context, index) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.chatBrain.buildAvatar(
                                  EdgeInsets.zero,
                                  EdgeInsets.zero,
                                  40.0,
                                  widget.selectedUsers[index],
                                  50.0),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(getUserName(widget.selectedUsers[index])),
                            ],
                          )),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 20,
                          )),
                ),
              ),
              TextField(
                onChanged: ((value) => setState(() {
                      isInputChanged = true;
                      name = value;
                    })),
                decoration: kLoginDecoration.copyWith(
                    hintText: 'Name the room for future use'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              RawMaterialButton(
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                onPressed: name.isEmpty
                    ? null
                    : () => widget.chatBrain
                        .handlePressed(name, widget.selectedUsers, context),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                fillColor: name.isEmpty ? Colors.grey.shade200 : kBlueGrey,
                child: const Text(
                  'create room',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
