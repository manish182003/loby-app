import 'package:flutter/material.dart';
import 'package:loby/presentation/screens/main/chat/chat_detail/widgets/message_receiver.dart';

import '../../../../../core/theme/colors.dart';
import 'widgets/message__sender.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
            chatInput(context, textTheme)
          ],
        ),
      ),
    );
  }

  Widget chatInput(BuildContext context, TextTheme textTheme) {
    return /*Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical:10,horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Material(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  elevation:5,
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0,top:2,bottom: 2),
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
                ),
              ),
              MaterialButton(
                  shape: CircleBorder(),
                  color: Colors.blue,
                  onPressed: () {
                  },
                  child:Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.send,color: Colors.white,),
                  )
                // Text(
                //   'Send',
                //   style: kSendButtonTextStyle,
                // ),
              ),
            ],
          ),
        ),
      ],
    );*/
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
