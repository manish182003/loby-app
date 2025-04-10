import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/screens/main/home/widgets/game_list_card.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../domain/entities/listing/service_listing.dart';
import '../../../../services/routing_service/routes_name.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/text_fields/text_field_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  HomeController homeController = Get.find<HomeController>();
  TextEditingController search = TextEditingController();
  Timer? debounce;
  RxList<String> searchHistoryList = <String>[].obs;

  _onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(
      Duration(milliseconds: 1000),
      () {
        if (query.trim().isNotEmpty) {
          Helpers.saveLast10Searches(query);
        }
      },
    );
  }

  @override
  void initState() {
    getSearchHistory();
    super.initState();
  }

  getSearchHistory() async {
    searchHistoryList.value = await Helpers.getLast10Searches();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appBar(context: context),
      body: SafeArea(
        child: BodyPaddingWidget(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldWidget(
                  textEditingController: search,
                  hint: 'Search...',
                  onChanged: (value) {
                    homeController.serviceListingResults.clear();
                    homeController.gameResults.clear();
                    homeController.userResults.clear();
                    if (value.isNotEmpty) {
                      searchHistoryList.clear();
                      homeController.globalSearch(search: value);
                      _onSearchChanged(value);
                    }
                  },
                ),
                SizedBox(height: 4.h),
                Obx(() {
                  if (searchHistoryList.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Last 10 Searches",
                            style: textTheme.headlineMedium
                                ?.copyWith(color: aquaGreenColor)),
                        const Divider(
                          color: aquaGreenColor,
                          thickness: 1.0,
                        ),
                        SizedBox(height: 2.h),
                        ListView.builder(
                          itemCount: searchHistoryList.length,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildSearchListItem(
                            textTheme,
                            searchText: searchHistoryList[index],
                          ),
                        ),
                      ],
                    );
                  }
                  if (homeController.isGlobalSearchFetching.value) {
                    return const CustomLoader();
                  } else if (homeController.serviceListingResults.isEmpty &&
                      homeController.gameResults.isEmpty &&
                      homeController.userResults.isEmpty) {
                    return const NoDataFoundWidget();
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (homeController
                              .serviceListingResults.isNotEmpty) ...[
                            Text("Listings",
                                style: textTheme.headlineMedium
                                    ?.copyWith(color: aquaGreenColor)),
                            const Divider(
                              color: aquaGreenColor,
                              thickness: 1.0,
                            ),
                            SizedBox(height: 2.h),
                            homeController.serviceListingResults.isEmpty
                                ? const NoDataFoundWidget()
                                : SizedBox(
                                    height: 15.h,
                                    child: ListView.builder(
                                      itemCount: homeController
                                          .serviceListingResults.length,
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          buildListItem(textTheme,
                                              listing: homeController
                                                      .serviceListingResults[
                                                  index]),
                                    ),
                                  ),
                            SizedBox(height: 2.h),
                          ],
                          if (homeController.gameResults.isNotEmpty) ...[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Games",
                                    style: textTheme.headlineMedium
                                        ?.copyWith(color: aquaGreenColor)),
                                const Divider(
                                  color: aquaGreenColor,
                                  thickness: 1.0,
                                ),
                                SizedBox(height: 2.h),
                                homeController.gameResults.isEmpty
                                    ? const NoDataFoundWidget()
                                    : SizedBox(
                                        height: 17.h,
                                        child: ListView.builder(
                                            itemCount: homeController
                                                .gameResults.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return GameCard(
                                                  game: homeController
                                                      .gameResults[index]);
                                            }),
                                      ),
                                SizedBox(height: 2.h),
                              ],
                            ),
                          ],
                          if (homeController.userResults.isNotEmpty) ...[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Users",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: textTheme.headlineMedium
                                        ?.copyWith(color: aquaGreenColor)),
                                const Divider(
                                  color: aquaGreenColor,
                                  thickness: 1.0,
                                ),
                                SizedBox(height: 2.h),
                                homeController.userResults.isEmpty
                                    ? const NoDataFoundWidget()
                                    : SizedBox(
                                        height: 15.h,
                                        child: ListView.builder(
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount:
                                              homeController.userResults.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) =>
                                              buildUsersListItem(textTheme,
                                                  user: homeController
                                                      .userResults[index]),
                                        ),
                                      ),
                              ],
                            ),
                          ]
                        ],
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildListItem(TextTheme textTheme, {required ServiceListing listing}) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(gameDetailPage, extra: {
          'serviceListingId': "${listing.id}",
          'from': ListingPageRedirection.search
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(listing.title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style:
                      textTheme.headlineSmall?.copyWith(color: textWhiteColor)),
            ),
            const SizedBox(width: 16.0),
            Container(
              decoration: BoxDecoration(
                color: orangeColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Text(listing.category?.name ?? '',
                    style:
                        textTheme.titleMedium?.copyWith(color: textWhiteColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildSearchListItem(TextTheme textTheme, {required String searchText}) {
    return GestureDetector(
      onTap: () {
        searchHistoryList.clear();
        homeController.globalSearch(search: searchText);
        search.text = searchText;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Text(searchText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style:
                    textTheme.headlineSmall?.copyWith(color: textWhiteColor)),
            const SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }

  buildUsersListItem(TextTheme textTheme, {required User user}) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(userProfilePage,
            extra: {'userId': "${user.id}", 'from': 'other'});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Text(user.displayName ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style:
                    textTheme.headlineSmall?.copyWith(color: textWhiteColor)),
            const SizedBox(width: 8.0),
            user.verifiedProfile ?? false
                ? SvgPicture.asset(
                    'assets/icons/verified_user_bedge.svg',
                    height: 15,
                    width: 15,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
