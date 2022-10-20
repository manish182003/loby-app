import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../domain/entities/profile/user.dart';
import '../../../../../widgets/follow_btn.dart';

class FollowerItemWidget extends StatelessWidget {
  final User user;
  final String type;
  const FollowerItemWidget({Key? key, required this.user, required this.type}) : super(key: key);

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
                  style: textTheme.headline5?.copyWith(color: textWhiteColor),
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
                    ProfileController profileController = Get.find<ProfileController>();
                    profileController.followUnfollow(userId: user.id);
                  },
                  btnBgColor: butterflyBlueColor,
                  txtColor: textWhiteColor,
                  btnName: type == 'following' ? 'Unfollow' : 'Follow',
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
              child: CachedNetworkImage(
                imageUrl: user.image ?? '',
                fit: BoxFit.cover,
                height: 110,
                width: 110,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ), //CircleAvatar
        ),
      ),
    );
  }
}
