import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loby/presentation/screens/main/chat/chat_detail/widgets/message_receiver.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import 'widgets/message__sender.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      floatingActionButton: chatInput(context),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 42,
                    height: 42,
                    child: MaterialButton(
                      shape: const CircleBorder(),
                      color: textCharcoalBlueColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 8.0),
                        child: Text(
                          'Gavin Henry',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.headline2
                              ?.copyWith(color: textWhiteColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const MessageSenderWidget(
                imageUrl: 'assets/images/img.png',
                text: 'How are you Bro? ',
                time: '3m ago'),
            const MessageReceiverWidget(
                imageUrl: 'assets/images/img.png',
                text: 'I am well bro.',
                time: '2:30'),
            const MessageSenderWidget(
                imageUrl: 'assets/images/img1.png',
                text: 'Love them',
                time: '16m ago'),
          ],
        ),
      ),
    );
  }

  Widget chatInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              SizedBox(width: 8.0),
              Icon(Icons.insert_emoticon,
                  size: 30.0, color: Theme.of(context).hintColor),
              SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Icon(Icons.attach_file,
                  size: 30.0, color: Theme.of(context).hintColor),
              SizedBox(width: 8.0),
              Icon(Icons.camera_alt,
                  size: 30.0, color: Theme.of(context).hintColor),
              SizedBox(width: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
