import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/chat_controller.dart';
import 'package:loby/presentation/getx/controllers/core_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/chat/widgets/custom_message.dart';
import 'package:loby/presentation/screens/main/chat/widgets/message_widget.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';


class ChatPage extends StatefulWidget {
  final int chatId;
  final int senderId;
  final int receiverId;
  const ChatPage({super.key, required this.chatId, required this.senderId, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  ChatController chatController = Get.find<ChatController>();
  CoreController coreController = Get.find<CoreController>();
  ProfileController profileController = Get.find<ProfileController>();

  // List<types.Message> chatController.chatMessages = [];
  types.User _user = const types.User(id: '');

  @override
  void initState() {
    super.initState();

    chatController.getMessages(chatId: widget.chatId);
    profileController.getProfile();

    print("chat ${widget.chatId}");
  }

  @override
  void dispose() {
    chatController.chatMessagesMap.clear();
    // chatController.messages.clear();
    chatController.chatMessages.clear();
    // coreController.socket.off('receive_message');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final chatChannel = chatController.chats.where((chat) => chat.receiverId == widget.receiverId).toList().first;

    return WillPopScope(
      onWillPop: (){
        chatController.getChats();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: appBar(context: context, appBarName: chatChannel.receiverInfo?.displayName),
        body: Obx(() {
          if(chatController.isMessagesFetching.value || profileController.isProfileFetching.value){
            return const CustomLoader();
          }else {
            chatController.chatMessages.refresh();
            _user = types.User(id: widget.senderId.toString());
            return Chat(
                messages: chatController.chatMessages,
                onAttachmentPressed: _handleAttachmentPressed,
                onMessageTap: _handleMessageTap,
                onPreviewDataFetched: _handlePreviewDataFetched,
                onSendPressed: _handleSendPressed,
                showUserAvatars: true,
                showUserNames: true,
                user: _user,
                theme: const DarkChatTheme(
                  backgroundColor: backgroundColor,
                  secondaryColor: textFieldColor,
                  inputBackgroundColor: textFieldColor,
                ),
                customMessageBuilder: (message, {messageWidth = 0}) {
                  return CustomMessage(message: message);
                }
            );
          }
        }),
      ),
    );
  }


  void _sendMessage(types.Message message) {
    setState(() {
      chatController.chatMessages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) =>
          SafeArea(
            child: SizedBox(
              height: 144,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _handleImageSelection();
                    },
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('Photo'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _handleFileSelection();
                    },
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('File/Video'),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'jpg', 'png', 'pdf', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );


      final isSuccess = await chatController.sendMessage(receiverId: widget.receiverId, file: File(result.files.single.path!), fileType: Helpers.getFileType(result.files.single.extension!));
      if(isSuccess){
        _sendMessage(message);
      }else{
        Helpers.toast("Message Not Sent");
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime
            .now()
            .millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );


      final isSuccess = await chatController.sendMessage(receiverId: widget.receiverId, file: File(result.path), fileType: 2);
      if(isSuccess){
        _sendMessage(message);
      }else{
        Helpers.toast("Message Not Sent");
      }
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;
      if (message.uri.startsWith('http')) {
        try {
          final index = chatController.chatMessages.indexWhere((element) =>
          element.id == message.id);
          final updatedMessage = (chatController.chatMessages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            chatController.chatMessages[index] = updatedMessage;
          });

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
          final index = chatController.chatMessages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (chatController.chatMessages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            chatController.chatMessages[index] = updatedMessage;
          });
        }
      }

      // await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(types.TextMessage message,
      types.PreviewData previewData,) {
    final index = chatController.chatMessages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (chatController.chatMessages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      chatController.chatMessages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) async{
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
      status: types.Status.delivered,
    );


    final isSuccess = await chatController.sendMessage(receiverId: widget.receiverId, message: textMessage.text);
    if(isSuccess){
      _sendMessage(textMessage);
    }else{
      Helpers.toast("Message Not Sent");
    }
  }
}