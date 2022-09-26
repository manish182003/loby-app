import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:sizer/sizer.dart';

import 'follower_item_widget.dart';

class FollowerTabScreen extends StatefulWidget {
  final String type;

  const FollowerTabScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<FollowerTabScreen> createState() => _FollowerTabScreenState();
}

class _FollowerTabScreenState extends State<FollowerTabScreen> {

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getFollowers(type: widget.type);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(profileController.isFollowersFetching.value){
        return const CustomLoader();
      }else{
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                itemCount: widget.type == 'following' ? profileController.following.length :  profileController.followers.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 8),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return FollowerItemWidget(user: widget.type == 'following' ? profileController.following[index] : profileController.followers[index], type: widget.type,);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 1.h,);
                },
              )
            ],
          ),
        );
      }
    });
  }
}
