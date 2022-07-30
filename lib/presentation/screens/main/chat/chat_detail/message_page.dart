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
                    width: 7.h,
                    height: 7.h,
                    child: MaterialButton(
                      shape: const CircleBorder(),
                      color: backgroundBalticSeaColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        'assets/icons/back_icon.svg',
                        color: whiteColor,
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
    return Container(
      width: MediaQuery.of(context).size.width - (2 * 17),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundBalticSeaColor,
        borderRadius: BorderRadius.circular(75),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Type Something',
          ),
          Icon(Icons.send)
        ],
      ),
    );
  }
}
