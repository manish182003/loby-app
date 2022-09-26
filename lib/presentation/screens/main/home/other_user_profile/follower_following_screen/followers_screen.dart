import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../core/theme/colors.dart';
import 'follower_tab.dart';
import 'following_tab.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({Key? key}) : super(key: key);

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {

  ProfileController profileController = Get.find<ProfileController>();

  final _tabs = [
    const Tab(text: 'Following'),
    const Tab(text: 'Followers'),
  ];


  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.55;
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child:  Scaffold(
        appBar: appBar(context: context),
        body: SafeArea(
          child: BodyPaddingWidget(
            child: Column(
              children: [
                SizedBox(
                  child: Column(
                    children: <Widget>[
                      Card(
                        color: backgroundBalticSeaColor,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.green[500],
                                    radius: 36,
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: CachedNetworkImage(
                                        imageUrl: profileController.profile.image ?? '',
                                        fit: BoxFit.cover,
                                        height: 110,
                                        width: 110,
                                        placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    ), //CircleAvatar
                                  ),
                                  GestureDetector(
                                    onTap: (){

                                    },
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            constraints: BoxConstraints(maxWidth: maxWidth),
                                            child: Text(profileController.profile.displayName!,
                                                overflow: TextOverflow.ellipsis,
                                                style: textTheme.headline3
                                                    ?.copyWith(
                                                    fontSize: 16.sp,
                                                    color: textWhiteColor)),
                                          ),
                                          const SizedBox(width: 8.0),
                                          profileController.profile.verifiedProfile ?? false ? SvgPicture.asset(
                                            'assets/icons/verified_user_bedge.svg',
                                            height: 15,
                                            width: 15,
                                          ) : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: butterflyBlueColor,
                  indicatorWeight: 4.0,
                  labelColor: textWhiteColor,
                  labelStyle: textTheme.headline5,
                  tabs: _tabs,
                ),
                SizedBox(height: 2.h,),
                const Expanded(
                  child:  TabBarView(
                    children: <Widget>[
                      FollowerTabScreen(type: 'following',),
                      FollowerTabScreen(type: 'followers',),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}