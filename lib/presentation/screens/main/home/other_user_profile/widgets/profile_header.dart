import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../data/models/ItemModel.dart';
import '../../../../../../services/routing_service/routes_name.dart';
import '../../../../../widgets/custom_button.dart';

class ProfileHeader extends StatefulWidget {
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
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  late List<ItemModel> menuItems;
  final CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuItems = [
      ItemModel(
        'Report User',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.55;
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.asset(
                "assets/images/img1.png",
                fit: BoxFit.cover,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
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
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 7.h,
                  height: 7.h,
                  child: CustomPopupMenu(
                    arrowColor: lavaRedColor,
                    menuBuilder: () => ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        color: lavaRedColor,
                        child: IntrinsicWidth(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: menuItems
                                .map(
                                  (item) => GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      _controller.hideMenu();
                                      context.pushNamed(createNewDisputePage);
                                    },
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Text(
                                                item.title,
                                                style: textTheme.headline6
                                                    ?.copyWith(
                                                        color: textWhiteColor),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    pressType: PressType.singleClick,
                    verticalMargin: -10,
                    controller: _controller,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Icon(Icons.more_vert,
                          size: 32.0, color: iconWhiteColor),
                    ),
                  ),
                ),
              ),
            ])
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 200),
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
                                              style: textTheme.headline3
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
                                            RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '536K ',
                                                    style: textTheme.headline5?.copyWith(color: selectiveYellowColor, fontWeight: FontWeight.w700,),
                                                  ),
                                                  TextSpan(
                                                      text: 'Followers',
                                                      style: textTheme.headline5?.copyWith(color: selectiveYellowColor, fontWeight: FontWeight.w200,)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 16.0),
                                            RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '120 ',
                                                    style: textTheme.headline5?.copyWith(color: selectiveYellowColor, fontWeight: FontWeight.w700,),
                                                  ),
                                                  TextSpan(
                                                      text: 'Listing',
                                                      style: textTheme.headline5?.copyWith(color: selectiveYellowColor, fontWeight: FontWeight.w200,)),
                                                ],
                                              ),
                                            ),
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
                                width: MediaQuery.of(context).size.width * 0.6,
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
                                width: 45,
                                height: 45,
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
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                      style: textTheme.headline4
                                          ?.copyWith(color: textWhiteColor, fontWeight: FontWeight.w300,)),
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
                                      style: textTheme.headline4
                                          ?.copyWith(color: textWhiteColor, fontWeight: FontWeight.w300,)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
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
