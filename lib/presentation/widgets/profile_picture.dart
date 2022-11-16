import 'package:flutter/material.dart';
import 'package:loby/domain/entities/profile/user.dart';
import '../../core/theme/colors.dart';
import 'custom_cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePicture extends StatelessWidget {
  final User profile;
  final double? radius;
  final double? iconSize;
  const ProfilePicture({Key? key, required this.profile, this.radius, this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(profile.verifiedProfile ?? false){
      return Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          CircleAvatar(
            backgroundColor: butterflyBlueColor,
            radius: radius ?? 35,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius ?? 35),
                child: CustomCachedNetworkImage(
                  imageUrl: profile.image,
                  name: profile.displayName,
                ),
              ),
            ), //CircleAvatar
          ),
          SvgPicture.asset('assets/icons/blue_tick.svg', height: iconSize ?? 22, width: iconSize ?? 22,),
        ],
      );
    }else{
      return CircleAvatar(
        backgroundColor: aquaGreenColor,
        radius: radius ?? 35,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius ?? 35),
            child: CustomCachedNetworkImage(
              imageUrl: profile.image,
              name: profile.displayName,
            ),
          ),
        ), //CircleAvatar
      );
    }
  }
}
