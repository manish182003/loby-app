import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:loby/presentation/screens/main/profile/wallet/widgets/token_widget.dart';
import 'package:loby/presentation/widgets/custom_cached_network_image.dart';
import 'package:sizer/sizer.dart';

class CustomMessage extends StatelessWidget {
  final types.CustomMessage message;
  const CustomMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: backgroundBalticSeaColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: SizedBox(
                height: 12.h,
                child: CustomCachedNetworkImage(
                  imageUrl: message.metadata!['image'],
                  placeHolder: Image.asset("assets/images/listing_placeholder.jpg", fit: BoxFit.cover,),
                ),
              ),
            ),
          ),
          SizedBox(width: 2.w,),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.48,
                  child: Text(message.metadata!['name'] ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: textTheme.headline5?.copyWith(color: textWhiteColor)),
                ),
                SizedBox(height: 0.5.h),
                SizedBox(
                  child: Text(message.metadata!['desc'] ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: textTheme.headline6
                          ?.copyWith(color: textInputTitleColor)),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: orangeColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        child: Text(message.metadata!['category'] ?? "", style: textTheme.headline6?.copyWith(color: textWhiteColor)),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    TokenWidget(
                      size: 20,
                      text: Text(
                        "${message.metadata!['price'] ?? ""}",
                        style: textTheme.headline2?.copyWith(color: aquaGreenColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
