import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_chat/constants/constants.dart';
import 'package:my_chat/services/chat_brain.dart';
import 'package:my_chat/ui/chat_app_bar.dart';
import 'package:path_provider/path_provider.dart';

class MyChat extends StatefulWidget {
  static String chatId = 'MyChat';
  final types.Room room;
  final List<types.User> otherUsers;
  const MyChat({Key? key, required this.room, required this.otherUsers})
      : super(key: key);

  @override
  State<MyChat> createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  bool _isAttachmentUploading = false;
  ChatBrain chatBrain = ChatBrain();
  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(room: widget.room),
      body: StreamBuilder<types.Room>(
          initialData: widget.room,
          stream: FirebaseChatCore.instance.room(widget.room.id),
          builder: (context, snapshot) {
            // final room = snapshot.data;
            return StreamBuilder<List<types.Message>>(
                stream: FirebaseChatCore.instance.messages(snapshot.data!),
                builder: ((context, snapshot) => Chat(
                      showUserAvatars: true,
                      showUserNames: true,
                      theme: const DefaultChatTheme(
                          inputBackgroundColor: kBlueGrey,
                          primaryColor: kOrange),
                      isAttachmentUploading: _isAttachmentUploading,
                      messages: snapshot.data ?? [],
                      onAttachmentPressed: _handleImageSelection,
                      onMessageTap: _handleMessageTap,
                      onPreviewDataFetched: _handlePreviewDataFetched,
                      onSendPressed: _handleSendPressed,
                      bubbleBuilder: chatBrain.bubbleBuilder,
                      user: types.User(
                        id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                      ),
                    )));
          }),
    );
  }

  void _handleImageSelection() async {
    final pickedImage = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      _setAttachmentUploading(true);

      final file = File(pickedImage.path);
      final size = file.lengthSync();
      final bytes = await pickedImage.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = pickedImage.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.room.id,
        );
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);

          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );
        }
      }
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  List<String> unreadMessages = [];
  void _handleSendPressed(types.PartialText message) {
    unreadMessages.add(message.text);
    final updatedRoom = widget.room.copyWith(
        metadata: {'unreadMessages': unreadMessages, 'userId': currentUser});
    FirebaseChatCore.instance.updateRoom(updatedRoom);
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }
}
