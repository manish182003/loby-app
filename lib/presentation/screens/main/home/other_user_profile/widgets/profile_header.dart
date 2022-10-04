import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../data/models/ItemModel.dart';
import '../../../../../../services/routing_service/routes_name.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/buttons/custom_button.dart';

class ProfileHeader extends StatefulWidget {
  final String? coverImage;
  final AssetImage avatar;
  final String title;
  final String subtitle;
  final User user;
  final String from;

  const ProfileHeader({super.key,
    this.coverImage,
    required this.avatar,
    required this.title,
    this.subtitle = "",
    required this.user,required this.from,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {

  ProfileController profileController = Get.find<ProfileController>();
  AuthController authController = Get.find<AuthController>();

  List<PlatformFile> _paths = [];


  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.55;
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            SizedBox(
              height: 30.h,
              width: double.infinity,
              child: Image.asset(
                "assets/images/img1.png",
                fit: BoxFit.cover,
              ),
            ),
            appBar(context: context, appBarName: widget.title),
            GestureDetector(
              onTap: _openFileExplorer,
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
            ),
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
                              child: CircleAvatar(
                                radius: 36,
                                backgroundColor: butterflyBlueColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(36),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.user.image ?? "",
                                      fit: BoxFit.cover,
                                      height: 110,
                                      width: 110,
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: maxWidth),
                                          child: Text(widget.user.displayName ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.headline3?.copyWith(color: textWhiteColor)),
                                        ),
                                        const SizedBox(width: 8.0),
                                        widget.user.verifiedProfile! ? SvgPicture.asset(
                                          'assets/icons/verified_user_bedge.svg',
                                          height: 15,
                                          width: 15,
                                        ) : const SizedBox(),
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
                                                    text: "${widget.user.followersCount}  ",
                                                    style: textTheme.headline5?.copyWith(color: selectiveYellowColor, fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text: 'Followers',
                                                      style: textTheme.headline5?.copyWith(color: selectiveYellowColor, fontWeight: FontWeight.w200,
                                                      )),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 16.0),
                                            RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "${widget.user.listingsCount}  ",
                                                    style: textTheme.headline5?.copyWith(
                                                      color: selectiveYellowColor,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text: 'Listing',
                                                      style: textTheme.headline5?.copyWith(
                                                        color: selectiveYellowColor,
                                                        fontWeight: FontWeight.w200,
                                                      )),
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
                        widget.from == "other" ? Padding(
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
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: 45,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  color: shipGreyColor,
                                  onPressed: () {
                                    profileController.followUnfollow(userId: widget.user.id);
                                    debugPrint("Click Search");
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/a_check_icon.svg',
                                    color: iconWhiteColor,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) : const SizedBox(),
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
                                      style: textTheme.headline4?.copyWith(
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
                                      style: textTheme.headline4?.copyWith(
                                        color: textWhiteColor,
                                        fontWeight: FontWeight.w300,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12,),
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


  void _openFileExplorer() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        onFileLoading: (FilePickerStatus status) => print(status),
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
      ))!.files;

      Helpers.loader();
      await authController.updateProfile(avatar: _paths.map((e) => File(e.path!)).toList().first);
      await profileController.getProfile();
      Helpers.hideLoader();

    } on PlatformException catch (e) {
      Helpers.toast('Unsupported operation$e');
    } catch (e) {
      Helpers.toast('Something went wrong');
    }
    if (!mounted) return;
  }
}
