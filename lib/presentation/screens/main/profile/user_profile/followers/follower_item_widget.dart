import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/custom_cached_network_image.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../domain/entities/profile/user.dart';
import '../../../../../widgets/follow_btn.dart';

class FollowerItemWidget extends StatelessWidget {
  final User user;
  final String type;
  const FollowerItemWidget({Key? key, required this.user, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MessagePage()));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildUserAvatar(lavaRedColor),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  user.displayName ?? '',
                  overflow: TextOverflow.ellipsis,
                  style:
                      textTheme.headlineSmall?.copyWith(color: textWhiteColor),
                  maxLines: 1,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.31,
                child: Button(
                  width: MediaQuery.of(context).size.width * 0.31,
                  height: 36,
                  onPress: () {
                    ProfileController profileController =
                        Get.find<ProfileController>();
                    profileController.followUnfollow(userId: user.id);
                    int index = type == 'following'
                        ? profileController.following
                            .indexWhere((e) => e.id == user.id)
                        : profileController.followers
                            .indexWhere((e) => e.id == user.id);

                    if (type == "following") {
                      print(profileController.following[index]);
                      profileController.following[index].followStatus =
                          profileController.following[index].followStatus == 'Y'
                              ? 'N'
                              : 'Y';
                      print(profileController.following[index]);
                    } else {
                      print(profileController.followers[index]);
                      profileController.followers[index].followStatus =
                          profileController.followers[index].followStatus == 'Y'
                              ? 'N'
                              : 'Y';
                      print(profileController.followers[index]);
                    }
                    profileController.followers.refresh();
                    profileController.following.refresh();
                  },
                  btnBgColor: butterflyBlueColor,
                  txtColor: textWhiteColor,
                  btnName: user.followStatus == 'N' ? 'Follow' : 'Unfollow',
                ),
              ),
            ],
          ),
        ));
  }

  _buildUserAvatar(Color borderColor) {
    return CircleAvatar(
      radius: 28,
      backgroundColor: aquaGreenColor,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: CircleAvatar(
          backgroundColor: backgroundDarkJungleGreenColor,
          radius: 28,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: CustomCachedNetworkImage(
                imageUrl: user.image,
                name: user.displayName,
              ),
            ),
          ), //CircleAvatar
        ),
      ),
    );
  }
}
