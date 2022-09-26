import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/chat/chat.dart';
import 'package:loby/presentation/screens/main/chat/message_page.dart';
import 'package:loby/services/routing_service/routes_name.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;
  const ChatTile({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
        onTap: ()async {
          final userId = await Helpers.getUserId();
          print("here is userid $userId");
          context.pushNamed(messagePage, queryParams: {'chatId' : "${chat.id}", 'senderId' : "${chat.senderId}", 'receiverId' : "${chat.receiverId}"});
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
          child: Container(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: purpleLightIndigoColor,
              border: Border.all(width: 0.2, color: dividerColor),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              children: <Widget>[
                _buildUserAvtar(lavaRedColor),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        chat.receiverInfo!.displayName ?? chat.receiverInfo!.name!,
                        style: textTheme.headline3?.copyWith(color: textWhiteColor),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        chat.chatLatestDate.toString(),
                        style: textTheme.subtitle2?.copyWith(color: textWhiteColor, fontWeight: FontWeight.w200,),
                      ),
                    ],
                  ),
                ),
                chat.badgeCount == 0 ? const SizedBox() : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // This is your Badge
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(minHeight: 28, minWidth: 28),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(spreadRadius: 1, color: orangeColor)
                      ],
                      borderRadius: BorderRadius.circular(44),
                      color: orangeColor, // This would be color of the Badge
                    ), // This is your Badge
                    child: Center(
                      // Here you can put whatever content you want inside your Badge
                      child: Text("${chat.badgeCount}",
                          style: textTheme.headline5?.copyWith(color: textWhiteColor)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }


  _buildUserAvtar(Color borderColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 28,
        backgroundColor: whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: CachedNetworkImage(
              imageUrl: chat.receiverInfo!.image ?? "",
              fit: BoxFit.cover,
              height: 110,
              width: 110,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
