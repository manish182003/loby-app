import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/utils/constants.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/widgets/text_fields/auto_complete_field.dart';
import 'package:sizer/sizer.dart';
import '../../../../../widgets/drop_down.dart';
import '../../../home/widgets/ItemList.dart';

class UserListingWidget extends StatefulWidget {
  final User user;
  final String from;
  const UserListingWidget({Key? key, required this.user, required this.from}) : super(key: key);

  @override
  State<UserListingWidget> createState() => _UserListingWidgetState();
}

class _UserListingWidgetState extends State<UserListingWidget> {

  final HomeController homeController = Get.find<HomeController>();
  final ListingController listingController = Get.find<ListingController>();
  final controller = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      listingController.getBuyerListings(userId: widget.user.id, from: widget.from);

      controller.addListener(() {
        if (controller.position.maxScrollExtent == controller.offset) {
          listingController.getBuyerListings(userId: widget.user.id, from: widget.from);
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
    final textTheme = Theme
        .of(context)
        .textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        AutoCompleteField(
          selectedSuggestion: homeController.selectedCategoryName.value,
          hint: 'Select Category',
          suggestionsCallback: (pattern) async {
            await homeController.getCategories(name: pattern);
            // WidgetsBinding.instance.addPostFrameCallback((_) async {
            //
            //   homeController.categories.refresh();
            // });

            List finalList = [];
            for (int i = 0; i < homeController.categories.length; i++) {
              finalList.add(homeController.categories[i].name);
            }
            return finalList;
          },
          onSuggestionSelected: (value) async {
            final index = homeController.categories.indexWhere((element) => element.name == value);
            homeController.selectedCategoryId.value = homeController.categories[index].id!;
            homeController.selectedCategoryName.value.text = homeController.categories[index].name!;

            getListings();
          },
        ),
        SizedBox(height: 2.h),
        AutoCompleteField(
          selectedSuggestion: homeController.selectedGameName.value,
          hint: 'Select Game',
          suggestionsCallback: (pattern) async {
            await homeController.getGames(name: pattern);
            // WidgetsBinding.instance.addPostFrameCallback((_) async {
            //
            // });

            List finalList = [];
            for (int i = 0; i < homeController.games.length; i++) {
              finalList.add(homeController.games[i].name);
            }
            return finalList;
          },
          onSuggestionSelected: (value) async {

            print("calling");

            final index = homeController.games.indexWhere((element) => element.name == value);
            homeController.selectedGameId.value = homeController.games[index].id!;
            homeController.selectedGameName.value.text = homeController.games[index].name!;
            getListings();
          },
        ),
        _buildGames(textTheme),
      ],
    );
  }

  Future<void> getListings()async{
    if(homeController.selectedGameId.value != 0 && homeController.selectedCategoryId.value != 0){
      listingController.buyerListingPageNumber.value = 1;
      listingController.areMoreListingAvailable.value = true;
      listingController.buyerListingsProfile.clear();
      listingController.getBuyerListings(
        categoryId: homeController.selectedCategoryId.value,
        gameId: homeController.selectedGameId.value,
        // userId: widget.user.id,
        from: 'myProfile',
      );
    }
  }

  _buildGames(TextTheme textTheme) {
    return Obx(() {
      if (listingController.isBuyerListingsFetching.value) {
        return const Center(child: CircularProgressIndicator(),);
      } else if (listingController.buyerListingsProfile.isEmpty) {
        return SizedBox(height: 8.h,);
      }else{
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.70,
            mainAxisSpacing: 0.1,
            crossAxisSpacing: 0.1,
          ),
          controller: controller,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: listingController.buyerListingsProfile.length + 1,
          itemBuilder: (context, index) {
            if (index < listingController.buyerListingsProfile.length) {
              return ItemList(
                  from: ListingPageRedirection.profile,
                  listing: listingController.buyerListingsProfile[index]
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

    });
  }
}
