import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/home/other_user_profile/widgets/profile_header.dart';
import 'package:loby/presentation/screens/main/home/other_user_profile/widgets/user_info.dart';

import '../../../../../core/theme/colors.dart';

class OtherUserProfileScreen extends StatefulWidget {
  final int userId;
  final String from;

  const OtherUserProfileScreen({Key? key, required this.userId, required this.from}) : super(key: key);

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {

  final HomeController homeController = Get.find<HomeController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final ListingController listingController = Get.find<ListingController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(widget.from == 'other'){
        profileController.getProfile(userId: widget.userId);
      }else{
        listingController.buyerListings.clear();
        profileController.getProfile();
      }
    });
  }

  @override
  void dispose() {
    homeController.profileSelectedOptionIndex.value = 0;
    listingController.buyerListingsProfile.clear();
    homeController.selectedGameName.value.text = "";
    homeController.selectedGameId.value = 0;
    homeController.selectedCategoryName.value.text = "";
    homeController.selectedCategoryId.value = 0;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: backgroundDarkJungleGreenColor,
        body: Obx(() {
          if(profileController.isProfileFetching.value){
            return const Center(child: CircularProgressIndicator(),);
          }else{
            final user = profileController.profile;
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ProfileHeader(
                    avatar: const AssetImage('assets/images/img.png'),
                    title: user.displayName ?? '',
                    subtitle: "",
                    user: user,
                    from: widget.from,
                  ),
                  const SizedBox(height: 10.0),
                  UserInfo(user: user, from: widget.from),
                ],
              ),
            );
          }
        }),
      ),
    );
  }




}
