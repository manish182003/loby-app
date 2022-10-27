import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/screens/main/profile/my_listing/widgets/my_listing_tile.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../home/widgets/ItemList.dart';

class MyListingScreen extends StatefulWidget {
  const MyListingScreen({Key? key}) : super(key: key);

  @override
  State<MyListingScreen> createState() => _MyListingScreenState();
}

class _MyListingScreenState extends State<MyListingScreen> {


  final HomeController homeController = Get.find<HomeController>();
  final ListingController listingController = Get.find<ListingController>();
  final controller = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      listingController.buyerListingPageNumber.value = 1;
      listingController.areMoreListingAvailable.value = true;
      listingController.getBuyerListings(from: 'myProfile');

      controller.addListener(() {
        if (controller.position.maxScrollExtent == controller.offset) {
          listingController.getBuyerListings(from: 'myProfile');
        }
      });
    });
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appBar(context: context, appBarName: "My Listing"),
      body: _buildGames(textTheme)
    );
  }

  _buildGames(TextTheme textTheme) {
    return BodyPaddingWidget(
      child: Obx(() {
        if (listingController.isBuyerListingsFetching.value) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (listingController.buyerListingsProfile.isEmpty) {
          return const NoDataFoundWidget();
        }else{
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            controller: controller,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: listingController.buyerListingsProfile.length + 1,
            itemBuilder: (context, index) {
              if (index < listingController.buyerListingsProfile.length) {
                return MyListingTile(listing: listingController.buyerListingsProfile[index]
                );
              }else{
                if (listingController.areMoreListingAvailable.value) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return const SizedBox();
                }
              }
            },
          );
        }

      }),
    );
  }
}
