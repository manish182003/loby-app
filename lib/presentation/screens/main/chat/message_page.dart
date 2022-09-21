import 'package:flutter/material.dart';
import 'package:loby/presentation/screens/main/chat/chat_detail/widgets/message_receiver.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import 'widgets/message__sender.dart';

class MessagePage extends StatelessWidget {
  final int chatId;
  final String name;
  const MessagePage({Key? key, required this.chatId,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: appBar(context: context, appBarName: name),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MessageSenderWidget(
                  imageUrl: 'assets/images/img.png',
                  text: 'How are you Bro? ',
                  time: '3m ago'),
              MessageReceiverWidget(
                  imageUrl: 'assets/images/img.png',
                  text: 'I am well bro.',
                  time: '2:30'),
              MessageSenderWidget(
                  imageUrl: 'assets/images/img1.png',
                  text: 'Love them',
                  time: '16m ago'),
              MessageSenderWidget(
                  imageUrl: 'assets/images/img.png',
                  text: 'How are you Bro? ',
                  time: '3m ago'),
              MessageReceiverWidget(
                  imageUrl: 'assets/images/img.png',
                  text: 'I am well bro.',
                  time: '2:30'),
              MessageSenderWidget(
                  imageUrl: 'assets/images/img1.png',
                  text: 'Love them',
                  time: '16m ago'),
              MessageSenderWidget(
                  imageUrl: 'assets/images/img.png',
                  text: 'How are you Bro? ',
                  time: '3m ago'),
              MessageReceiverWidget(
                  imageUrl: 'assets/images/img.png',
                  text: 'I am well bro.',
                  time: '2:30'),
              MessageReceiverWidget(
                  imageUrl: 'assets/images/img.png',
                  text: 'I am well bro.',
                  time: '2:30'),
              MessageReceiverWidget(
                  imageUrl: 'assets/images/img.png',
                  text: 'I am well bro.',
                  time: '2:30'),
              MessageSenderWidget(
                  imageUrl: 'assets/images/img1.png',
                  text: 'Love them',
                  time: '16m ago'),
              chatInput(context, textTheme)
            ],
          ),
        ),
      ),
    );
  }

  Widget chatInput(BuildContext context, TextTheme textTheme) {
    return
        Container(
      margin: const EdgeInsets.all(22.0),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(22.0),
          ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async {},
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {

              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                hintText: 'Type your message here...',
                hintStyle: textTheme.headline6,
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: aquaGreenColor),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
