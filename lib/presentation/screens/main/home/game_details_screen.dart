import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../../services/routing_service/routes_name.dart';
import '../../../widgets/bottom_dialog_widget.dart';
import '../../../widgets/custom_button.dart';
import 'other_user_profile/other_user_profile_screen.dart';

class GameDetailScreen extends StatefulWidget {
  const GameDetailScreen({Key? key}) : super(key: key);

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
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
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        'Test',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headline2
                            ?.copyWith(color: aquaGreenColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: backgroundBalticSeaColor,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  color: saffronMangoOrangeColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Image.asset(
                  "assets/images/img.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            child: Text(
                "Lvl 78 Account on SALE. Trusted Seller. 100% Guaranteed",
                style: textTheme.headline5?.copyWith(color: textWhiteColor)),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: orangeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    child: Text('Battlegrounds Mobile India',
                        style: textTheme.headline5
                            ?.copyWith(color: textWhiteColor)),
                  ),
                ),
                const SizedBox(width: 4.0),
                Container(
                  decoration: BoxDecoration(
                    color: purpleLightIndigoColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    child: Text('Account',
                        style: textTheme.headline5
                            ?.copyWith(color: textWhiteColor)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: backgroundBalticSeaColor,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Unit Price / Per Hour",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: textTheme.headline5
                                ?.copyWith(color: textLightColor),
                          ),
                          Text(
                            "₹ 25,000",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: textTheme.headline1
                                ?.copyWith(color: aquaGreenColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Stock",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: textTheme.headline5
                                ?.copyWith(color: textLightColor),
                          ),
                          Text(
                            "10",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: textTheme.headline5
                                ?.copyWith(color: textLightColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/plus_circle_icon.svg',
                            color: whiteColor,
                            width: 5.h,
                            height: 5.h,
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            // This is your Badge
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                                minHeight: 46, minWidth: 46),
                            decoration: BoxDecoration(
                              // This controls the shadow
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    color: Colors.black.withAlpha(50))
                              ],
                              borderRadius: BorderRadius.circular(32),
                              color:
                                  iconWhiteColor, // This would be color of the Badge
                            ), // This is your Badge
                            child: Center(
                              // Here you can put whatever content you want inside your Badge
                              child: Text('4',
                                  style: textTheme.headline3
                                      ?.copyWith(color: bodyTextColor)),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          SvgPicture.asset(
                            'assets/icons/minus_circle_icon.svg',
                            color: whiteColor,
                            width: 5.h,
                            height: 5.h,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Price",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: textTheme.headline5
                                ?.copyWith(color: textLightColor),
                          ),
                          Text(
                            "₹ 50,000",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: textTheme.headline1
                                ?.copyWith(color: aquaGreenColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Earn Loby Coins",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: textTheme.headline5
                                ?.copyWith(color: textLightColor),
                          ),
                          Text(
                            "500",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: textTheme.headline5
                                ?.copyWith(color: textLightColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OtherUserProfileScreen(),
                ),
              );*/
              context.pushNamed(otherUserPage);
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              child: Card(
                color: backgroundBalticSeaColor,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundColor: aquaGreenColor,
                          radius: 36,
                          child: Padding(
                            padding: EdgeInsets.all(1.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/img.png'),
                              radius: 36,
                            ),
                          ), //CircleAvatar
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mukesh Kumar Patel",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textTheme.headline3
                                      ?.copyWith(color: textWhiteColor),
                                ),
                                Row(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/user_rating_icon.svg',
                                          color: iconWhiteColor,
                                          height: 16.0,
                                          width: 16.0,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          "4.5",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: textTheme.headline3
                                              ?.copyWith(color: textWhiteColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 16.0),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/user_chat_icon.svg',
                                          color: iconWhiteColor,
                                          height: 16.0,
                                          width: 16.0,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          "12",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: textTheme.headline3
                                              ?.copyWith(color: textWhiteColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        SizedBox(
                          width: 7.h,
                          height: 7.h,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: backgroundDarkJungleGreenColor,
                            onPressed: () {
                              debugPrint("Click Search");
                            },
                            child: SvgPicture.asset(
                              'assets/icons/a_check_icon.svg',
                              color: iconYellowColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Listing ID",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headline5
                              ?.copyWith(color: textLightColor),
                        ),
                        Text(
                          "#46747",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headline5
                              ?.copyWith(color: textLightColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Game",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headline5
                              ?.copyWith(color: textLightColor),
                        ),
                        Text(
                          "BGMI",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headline5
                              ?.copyWith(color: textLightColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headline5
                              ?.copyWith(color: textLightColor),
                        ),
                        Text(
                          "Accounts",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headline5
                              ?.copyWith(color: textLightColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Service Type",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headline5
                              ?.copyWith(color: textLightColor),
                        ),
                        Text(
                          "#46747",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headline5
                              ?.copyWith(color: textLightColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Game Platform",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headline5
                              ?.copyWith(color: textLightColor),
                        ),
                        Text(
                          "Mobile",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headline5
                              ?.copyWith(color: textLightColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Description: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                            style: textTheme.headline5
                                ?.copyWith(color: textLightColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.17,
                  height: 6.3.h,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: purpleLightIndigoColor,
                    onPressed: () {
                      debugPrint("Click Search");
                    },
                    child: SvgPicture.asset(
                      'assets/icons/chat_icon.svg',
                      color: iconWhiteColor,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 4.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: CustomButton(
                    color: orangeColor,
                    name: "Buy Now",
                    textColor: textWhiteColor,
                    onTap: () {
                      BottomDialog(
                              textTheme: textTheme,
                              tileName: "Congratulations",
                              titleColor: aquaGreenColor,
                              contentName:
                                  "Payment Successful. You can check your order status from ",
                              contentLinkName: 'My Orders')
                          .showBottomDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
