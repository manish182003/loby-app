import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/profile/user_profile/widgets/profile_header.dart';
import 'package:loby/presentation/screens/main/profile/user_profile/widgets/user_info.dart';


class UserProfileScreen extends StatefulWidget {
  final int userId;
  final String from;

  const UserProfileScreen({Key? key, required this.userId, required this.from}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  final HomeController homeController = Get.find<HomeController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final ListingController listingController = Get.find<ListingController>();
  final AuthController authController = Get.find<AuthController>();

  bool isFetching = true;


  @override
  void initState() {
    // TODO: implement initState
    asyncFunctions();
    super.initState();
  }


  Future<void> asyncFunctions()async{

    WidgetsBinding.instance.addPostFrameCallback((_)async{
      profileController.isProfileFetching.value = true;

      listingController.buyerListingPageNumber.value = 1;
      listingController.areMoreListingAvailable.value = true;
      listingController.buyerListingsProfile.clear();
      if(widget.from == 'other'){
        await profileController.getProfile(userId: widget.userId);
        setState(() {
          isFetching = false;
        });
      }else{
        await profileController.getProfile();
        await authController.getProfileDetails();
        setState(() {
          isFetching = false;
        });
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
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if(profileController.isProfileFetching.value || isFetching){
            return const Center(child: CircularProgressIndicator(),);
          }else{
            final user = widget.from == "other" ? profileController.otherUserProfile : profileController.profile;
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ProfileHeader(
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
