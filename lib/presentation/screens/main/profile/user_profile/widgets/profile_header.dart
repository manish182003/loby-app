import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/chat_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/auth/widgets/create_profile_bottom_sheet.dart';
import 'package:loby/presentation/widgets/custom_bottom_sheet.dart';
import 'package:loby/presentation/widgets/custom_cached_network_image.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../services/routing_service/routes_name.dart';
import '../../../../../getx/controllers/listing_controller.dart';
import '../../../../../widgets/ConfirmationRiseDisputeBottomDialog.dart';
import '../../../../../widgets/bottom_dialog.dart';
import '../../../../../widgets/buttons/custom_button.dart';
import '../../../../../widgets/profile_picture.dart';

class ProfileHeader extends StatefulWidget {
  final String? coverImage;
  final String title;
  final String subtitle;
  final User user;
  final String from;

  const ProfileHeader({
    super.key,
    this.coverImage,
    required this.title,
    this.subtitle = "",
    required this.user,
    required this.from,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  ProfileController profileController = Get.find<ProfileController>();
  AuthController authController = Get.find<AuthController>();
  ChatController chatController = Get.find<ChatController>();
  ListingController listingController = Get.find<ListingController>();

  final CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.55;
    final textTheme = Theme.of(context).textTheme;
    print("uid  >>> ${widget.user.uid}");
    print("userrrrrr ${widget.user}");
    print("kyc   ${widget.user.kycverify}");
    return Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            SizedBox(
              height: 30.h,
              width: double.infinity,
              child: CustomCachedNetworkImage(
                  imageUrl: widget.user.coverImage,
                  placeHolder: Image.asset("assets/images/profile_bg_img.png",
                      fit: BoxFit.cover)),
            ),
            AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(
                    left: 10, bottom: 10, top: 10, right: 5),
                child: SizedBox(
                  width: 42,
                  height: 42,
                  child: MaterialButton(
                    shape: const CircleBorder(),
                    color: textCharcoalBlueColor,
                    onPressed: () {
                      Navigator.pop(context);
                      // if(onBack == null){
                      //   Navigator.pop(context);
                      // }else{
                      //   onBack();
                      //   Navigator.pop(context);
                      // }
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // title: Text(widget.title , maxLines: 1,
              //   overflow: TextOverflow.ellipsis ,style: textTheme.headline2?.copyWith(color: aquaGreenColor)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            // appBar(context: context, appBarName: widget.title),
            widget.from == 'myProfile'
                ? GestureDetector(
                    onTap: () async {
                      Helpers.loader();
                      await authController.getProfileDetails();
                      Helpers.hideLoader();
                      _showCreateProfileBottomSheet(context);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.only(top: 3.h, right: 4.w),
                        child: SvgPicture.asset(
                          'assets/icons/edit_icon.svg',
                          color: whiteColor,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  )
                : _reportAccount(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
          child: Container(
            margin: EdgeInsets.only(top: 20.h),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ProfilePicture(
                                profile: widget.user,
                                radius: 36,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: maxWidth),
                                        child: Row(
                                          children: [
                                            Text(widget.user.displayName ?? '',
                                                overflow: TextOverflow.ellipsis,
                                                style: textTheme.displaySmall
                                                    ?.copyWith(
                                                        color: textWhiteColor)),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            widget.user.kycverify == "Y"
                                                ? const Image(
                                                    image: AssetImage(
                                                        "assets/images/sheild.png"),
                                                    height: 20,
                                                  )
                                                : const SizedBox()
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'User ID : ',
                                                style: textTheme.headlineSmall
                                                    ?.copyWith(
                                                  color: selectiveYellowColor,
                                                  fontWeight: FontWeight.w200,
                                                )),
                                            TextSpan(
                                              text: widget.user.uid == null
                                                  ? "000000000"
                                                  : "${widget.user.uid}",
                                              style: textTheme.headlineSmall
                                                  ?.copyWith(
                                                color: selectiveYellowColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
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
                                          GestureDetector(
                                            onTap: () {
                                              if (widget.from == "myProfile") {
                                                context.pushNamed(followerPage);
                                              }
                                            },
                                            child: RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${widget.user.followersCount}  ",
                                                    style: textTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                      color:
                                                          selectiveYellowColor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text: 'Followers',
                                                      style: textTheme
                                                          .headlineSmall
                                                          ?.copyWith(
                                                        color:
                                                            selectiveYellowColor,
                                                        fontWeight:
                                                            FontWeight.w200,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16.0),
                                          GestureDetector(
                                            onTap: () {
                                              if (widget.from == "myProfile") {
                                                context
                                                    .pushNamed(myListingPage);
                                              }
                                            },
                                            child: RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${widget.user.listingsCount}  ",
                                                    style: textTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                      color:
                                                          selectiveYellowColor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text: 'Listing',
                                                      style: textTheme
                                                          .headlineSmall
                                                          ?.copyWith(
                                                        color:
                                                            selectiveYellowColor,
                                                        fontWeight:
                                                            FontWeight.w200,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        widget.from == "other"
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.56,
                                      child: CustomButton(
                                        height: 7.0.h,
                                        color: purpleLightIndigoColor,
                                        textColor: textWhiteColor,
                                        name: "Message",
                                        onTap: () async {
                                          Helpers.loader();
                                          final isSuccess = await chatController
                                              .checkEligibility(
                                                  receiverId: widget.user.id!);
                                          await chatController.getChats();
                                          final chat = chatController
                                              .checkEligibilityResponse.value;
                                          Helpers.hideLoader();
                                          if (isSuccess) {
                                            context
                                                .pushNamed(messagePage, extra: {
                                              'chatId': "${chat.id}",
                                              'senderId': "${chat.senderId}",
                                              'receiverId': "${chat.receiverId}"
                                            });
                                          } else {
                                            BottomDialog(
                                                    textTheme: textTheme,
                                                    tileName:
                                                        "Buy a Service First",
                                                    titleColor: aquaGreenColor,
                                                    contentName:
                                                        "Sorry you can not chat with a verified profile without buying a service",
                                                    contentLinkName: '')
                                                .showBottomDialog(context);
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 4.0),
                                    GestureDetector(
                                      onTap: () {
                                        profileController.followUnfollow(
                                            userId: widget.user.id);
                                        setState(() {
                                          widget.user.userFollowStatus =
                                              widget.user.userFollowStatus ==
                                                      'N'
                                                  ? 'Y'
                                                  : 'N';
                                          widget.user.followersCount = widget
                                                      .user.userFollowStatus ==
                                                  'N'
                                              ? widget.user.followersCount - 1
                                              : widget.user.followersCount + 1;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        widget.user.userFollowStatus == 'N'
                                            ? 'assets/icons/follow.svg'
                                            : 'assets/icons/unfollow.svg',
                                        color: iconWhiteColor,
                                        width: 40,
                                        height: 7.h,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: MediaQuery.of(context).size.width * 0.15,
                                    //   height: 45,
                                    //   child: MaterialButton(
                                    //     shape: RoundedRectangleBorder(
                                    //       borderRadius: BorderRadius.circular(12.0),
                                    //     ),
                                    //     color: shipGreyColor,
                                    //     onPressed: () {
                                    //       profileController.followUnfollow(userId: widget.user.id);
                                    //     },
                                    //     child: SvgPicture.asset(
                                    //       'assets/icons/a_check_icon.svg',
                                    //       color: iconWhiteColor,
                                    //       width: 24,
                                    //       height: 24,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Text("${widget.user.avgRatingCount ?? 0}",
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headlineMedium?.copyWith(
                                        color: textWhiteColor,
                                        fontWeight: FontWeight.w300,
                                      )),
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
                                  Text("${widget.user.orderCount} Orders",
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headlineMedium?.copyWith(
                                        color: textWhiteColor,
                                        fontWeight: FontWeight.w300,
                                      )),
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

  void _showCreateProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const CustomBottomSheet(
              isDismissible: false,
              initialChildSize: 0.97,
              maxChildSize: 0.97,
              minChildSize: 0.5,
              child: CreateProfileCard(from: 'profile')),
        );
      },
    );
  }

  Widget _reportAccount() {
    final textTheme = Theme.of(context).textTheme;
    return Positioned(
        top: 0.0,
        right: 10.0,
        child: CustomPopupMenu(
          arrowColor: lavaRedColor,
          menuBuilder: () => ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: lavaRedColor,
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: ['Report Account']
                      .map(
                        (item) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            _controller.hideMenu();
                            ConfirmationRiseDisputeBottomDialog(
                                textTheme: textTheme,
                                contentName:
                                    "Are you sure you want to report this account ?",
                                yesBtnClick: () async {
                                  Helpers.loader();
                                  final isSuccess = await listingController
                                      .reportListing(userId: widget.user.id);
                                  Helpers.hideLoader();
                                  if (isSuccess) {
                                    Navigator.of(context).pop();
                                  }
                                }).showBottomDialog(context);
                          },
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      item,
                                      style: textTheme.titleLarge
                                          ?.copyWith(color: textWhiteColor),
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
          horizontalMargin: 0,
          verticalMargin: 0,
          arrowSize: 15,
          controller: _controller,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.only(top: 3.h, right: 4.w),
              child: SvgPicture.asset(
                'assets/icons/option.svg',
                color: whiteColor,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ));
  }
}
