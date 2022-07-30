import 'package:flutter/material.dart';
import 'package:loby/presentation/screens/main/chat/widgets/conversation_list.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../../data/models/ChatUsers.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Jane Russel", time: "Now"),
    ChatUsers(name: "Glady's Murphy", time: "Yesterday"),
    ChatUsers(name: "Jorge Henry", time: "31 Mar"),
    ChatUsers(name: "Philip Fox", time: "28 Mar"),
    ChatUsers(name: "Debra Hawkins", time: "23 Mar"),
    ChatUsers(name: "Jacob Pena", time: "17 Mar"),
    ChatUsers(name: "Andrey Jones", time: "24 Feb"),
    ChatUsers(name: "John Wick", time: "18 Feb"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: body(),
      ),
    );
  }

  Widget body() {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: backgroundBalticSeaColor),
            child: Padding(
              padding: EdgeInsets.all(2.h),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 9.h,
                  child: Image.asset(
                    "assets/icons/app_icon.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 8.0),
                      child: Text(
                        'Chat',
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
          _buildchatUser(textTheme),
        ],
      ),
    );
  }

  _buildchatUser(TextTheme textTheme) {
    return ListView.builder(
      itemCount: chatUsers.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ConversationList(
          name: chatUsers[index].name,
          time: chatUsers[index].time,
        );
      },
    );
  }
}
