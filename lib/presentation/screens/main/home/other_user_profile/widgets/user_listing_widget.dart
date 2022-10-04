import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/widgets/text_fields/auto_complete_field.dart';
import 'package:sizer/sizer.dart';
import '../../../../../widgets/drop_down.dart';
import '../../widgets/ItemList.dart';

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
      listingController.buyerListingPageNumber.value = 1;
      listingController.areMoreListingAvailable.value = true;
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
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await homeController.getCategories(name: pattern);
            });

            List finalList = [];
            for (int i = 0; i < homeController.categories.length; i++) {
              finalList.add(homeController.categories[i].name);
            }
            return finalList;
          },
          onSuggestionSelected: (value) async {
            final index = homeController.categories.indexWhere((
                element) => element.name == value);
            homeController.selectedCategoryId.value =
            homeController.categories[index].id!;
            homeController.selectedCategoryName.value.text =
            homeController.categories[index].name!;
          },
        ),
        SizedBox(height: 2.h),
        AutoCompleteField(
          selectedSuggestion: homeController.selectedGameName.value,
          hint: 'Select Game',
          suggestionsCallback: (pattern) async {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await homeController.getGames(name: pattern);
            });

            List finalList = [];
            for (int i = 0; i < homeController.games.length; i++) {
              finalList.add(homeController.games[i].name);
            }
            return finalList;
          },
          onSuggestionSelected: (value) async {
            final index = homeController.games.indexWhere((element) =>
            element.name == value);
            homeController.selectedGameId.value =
            homeController.games[index].id!;
            homeController.selectedGameName.value.text =
            homeController.games[index].name!;

            listingController.getBuyerListings(
              categoryId: homeController.selectedCategoryId.value,
              gameId: homeController.selectedGameId.value,
              userId: widget.user.id,
              from: 'profile',
            );
          },
        ),
        _buildGames(textTheme),
      ],
    );
  }

  _buildGames(TextTheme textTheme) {
    return Obx(() {
      if (listingController.isBuyerListingsFetching.value) {
        return const Center(child: CircularProgressIndicator(),);
      } else if (listingController.buyerListingsProfile.isEmpty) {
        return SizedBox(height: 8.h,);
      }else{
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 6.0 / 9,
            mainAxisSpacing: 0.h,
            crossAxisSpacing: 3.h,
          ),
          controller: controller,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: listingController.buyerListingsProfile.length + 1,
          itemBuilder: (context, index) {
            if (index < listingController.buyerListingsProfile.length) {
              return ItemList(
                  name: 'hello $index',
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
