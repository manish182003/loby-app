import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import '../chat_detail/message_page.dart';

class ConversationList extends StatelessWidget {
  String name;
  String? imageUrl;
  String time;

  ConversationList(
      {Key? key,
      required this.name, this.imageUrl,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MessagePage()));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
          child: Card(
            elevation: 0,
            color: backgroundBalticSeaColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: backgroundBalticSeaColor,
                border: Border.all(width: 0.2, color: dividerColor),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        _buildUserAvtar(lavaRedColor),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  name,
                                  style: textTheme.headline4?.copyWith(color: textWhiteColor),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  time,
                                  style: textTheme.headline5?.copyWith(color: textLightColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          // This is your Badge
                          padding: const EdgeInsets.all(8),
                          constraints:
                          const BoxConstraints(minHeight: 46, minWidth: 46),
                          decoration: BoxDecoration(
                            // This controls the shadow
                            boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 1,
                                  color: orangeColor)
                            ],
                            borderRadius: BorderRadius.circular(32),
                            color:
                            orangeColor, // This would be color of the Badge
                          ), // This is your Badge
                          child: Center(
                            // Here you can put whatever content you want inside your Badge
                            child: Text('4',
                                style: textTheme.headline5
                                    ?.copyWith(color: textWhiteColor)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _buildUserAvtar(Color borderColor) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 36,
        backgroundColor: butterflyBlueColor,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundColor: backgroundDarkJungleGreenColor,
            radius: 36,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/img.png'),
                radius: 36,
                backgroundColor: backgroundBalticSeaColor,
              ),
            ), //CircleAvatar
          ),
        ),
      ),
    );
  }
}
