// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:loby/presentation/getx/controllers/chat_controller.dart';
// import 'package:loby/presentation/getx/controllers/profile_controller.dart';
// import 'package:loby/presentation/screens/main/chat/chat_detail/widgets/message_receiver.dart';
// import 'package:loby/presentation/widgets/custom_loader.dart';
//
// import '../../../../core/theme/colors.dart';
// import '../../../widgets/custom_app_bar.dart';
// import 'chat_detail/widgets/message__sender.dart';
// import 'widgets/message_widget.dart';
//
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:mime/mime.dart';
//
// import 'package:path_provider/path_provider.dart';
// import 'package:uuid/uuid.dart';
//
// class MessagePage extends StatefulWidget {
//   final int chatId;
//   final String name;
//
//   const MessagePage({Key? key, required this.chatId, required this.name})
//       : super(key: key);
//
//   @override
//   State<MessagePage> createState() => _MessagePageState();
// }
//
// class _MessagePageState extends State<MessagePage> {
//
//   ChatController chatController = Get.find<ChatController>();
//   ProfileController profileController = Get.find<ProfileController>();
//
//   List<types.Message> _messages = [];
//   final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     chatController.getMessages(chatId: widget.chatId);
//     profileController.getProfile();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//
//     return SafeArea(
//       child: Scaffold(
//         appBar: appBar(context: context, appBarName: widget.name),
//         body: Obx(() {
//           if(chatController.isMessagesFetching.value || profileController.isProfileFetching.value){
//             return const CustomLoader();
//           }else{
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ListView.builder(
//                   itemCount: chatController.messages.length,
//                   shrinkWrap: true,
//                   padding: const EdgeInsets.only(top: 16),
//                   physics: const ScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     return MessageWidget(message: chatController.messages[index]);
//                   },
//                 ),
//                 chatInput(context, textTheme)
//               ],
//             );
//           }
//         }),
//       ),
//     );
//   }
//
//   Widget chatInput(BuildContext context, TextTheme textTheme) {
//     return
//       Container(
//         margin: const EdgeInsets.all(22.0),
//         decoration: BoxDecoration(
//           color: whiteColor,
//           borderRadius: BorderRadius.circular(22.0),
//         ),
//         child: Row(
//           children: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.photo_camera),
//               onPressed: () async {},
//             ),
//             Expanded(
//               child: TextField(
//                 onChanged: (value) {
//
//                 },
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.symmetric(
//                       vertical: 10.0, horizontal: 20.0),
//                   hintText: 'Type your message here...',
//                   hintStyle: textTheme.headline6,
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.send, color: aquaGreenColor),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       );
//   }
// }
