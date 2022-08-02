import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../services/routing_service/routes_name.dart';
import '../../../../../widgets/custom_button.dart';

class ProfileHeader extends StatelessWidget {
  final coverImage;
  final avatar;
  final String title;
  final String subtitle;

  const ProfileHeader({
    this.coverImage,
    required this.avatar,
    required this.title,
    this.subtitle = "",
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.55;
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.asset(
                "assets/images/img1.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 7.h,
                    height: 7.h,
                    child: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      color: iconWhiteColor,
                      icon: const Icon(Icons.more_vert, size: 32.0),
                      onPressed: () {
                        context.pushNamed(createNewDisputePage);
                      },
                    ),
                  ),
                ),
              ]
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 150),
            child: Column(
              children: <Widget>[
                Card(
                  color: backgroundBalticSeaColor,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: const BorderSide(color: textLightColor, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 36,
                                backgroundColor: butterflyBlueColor,
                                child: Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        backgroundDarkJungleGreenColor,
                                    radius: 36,
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/images/img.png'),
                                        radius: 36,
                                        backgroundColor:
                                            backgroundDarkJungleGreenColor,
                                      ),
                                    ), //CircleAvatar
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(followerPage);
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: maxWidth),
                                          child: Text("Mukesh Kumar",
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.headline4
                                                  ?.copyWith(
                                                      color: textWhiteColor)),
                                        ),
                                        const SizedBox(width: 8.0),
                                        SvgPicture.asset(
                                          'assets/icons/verified_user_bedge.svg',
                                          height: 15,
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("536K followers",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: textTheme.headline6
                                                    ?.copyWith(
                                                        color:
                                                            selectiveYellowColor)),
                                            const SizedBox(width: 16.0),
                                            Text("120 Listings",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: textTheme.headline6
                                                    ?.copyWith(
                                                        color:
                                                            selectiveYellowColor)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: CustomButton(
                                  color: purpleLightIndigoColor,
                                  textColor: textWhiteColor,
                                  name: "Message",
                                  onTap: () {
                                    debugPrint('click chat');
                                  },
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              SizedBox(
                                width: 6.3.h,
                                height: 6.3.h,
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
                                    color: iconWhiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/outline_rating_icon.svg',
                                    color: iconWhiteColor,
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text("4.2",
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline3
                                          ?.copyWith(color: textWhiteColor)),
                                ],
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/briefcase_icon.svg',
                                    color: iconWhiteColor,
                                    height: 18,
                                    width: 18,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text("123 Orders",
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline3
                                          ?.copyWith(color: textWhiteColor)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
