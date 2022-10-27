import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/screens/main/home/widgets/ItemList.dart';
import 'package:loby/presentation/screens/main/home/widgets/filter_bottom_sheet_widget.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import '../../../../core/theme/colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_chip.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/drop_down_with_divider.dart';

class GameItemScreen extends StatefulWidget {
  final int categoryId;
  final int gameId;
  final String gameName;

  const GameItemScreen(
      {Key? key, required this.categoryId, required this.gameId, required this.gameName})
      : super(key: key);

  @override
  State<GameItemScreen> createState() => _GameItemScreenState();
}

class _GameItemScreenState extends State<GameItemScreen> {

  final HomeController homeController = Get.find<HomeController>();
  final ListingController listingController = Get.find<ListingController>();
  final controller = ScrollController();

  int categoryId = 0;

  final List<String> items = [
    'Top Rated',
    'Most Recent',
    'Low to High Price',
    'High to Low Price',
  ];
  String? selectedValue = 'Top Rated';


  @override
  void initState() {
    categoryId = widget.categoryId;
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      homeController.getCategoryGames(categoryId: categoryId);

      listingController.buyerListingPageNumber.value = 1;
      listingController.areMoreListingAvailable.value = true;
      listingController.getBuyerListings(categoryId: categoryId, gameId: widget.gameId);

      controller.addListener(() {
        if (controller.position.maxScrollExtent == controller.offset) {
          listingController.getBuyerListings(categoryId: categoryId, gameId: widget.gameId);
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
      appBar: appBar(context: context, appBarName: widget.gameName),
      body: SingleChildScrollView(
        controller: controller,
        child: BodyPaddingWidget(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (homeController.isCategoryFetching.value) {
                    return const CustomLoader();
                  } else {
                    return CustomChip(
                      labelName: homeController.categories.map((element) => element.name!).toList(),
                      selectedIndex: homeController.categories.indexWhere((element) => element.id == categoryId),
                      onChanged: (index) {
                        listingController.buyerListingPageNumber.value = 1;
                        listingController.areMoreListingAvailable.value = true;
                        setState(() {
                          categoryId = homeController.categories[index].id!;
                        });
                        listingController.getBuyerListings(categoryId: categoryId, gameId: widget.gameId);
                      },
                    );
                  }
                }),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: textFieldColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                            child: SvgPicture.asset(
                              'assets/icons/search_icon.svg',
                              color: iconWhiteColor,
                              width: 18,
                              height: 18,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextField(
                              onChanged: (value){
                                listingController.buyerListingPageNumber.value = 1;
                                listingController.areMoreListingAvailable.value = true;
                                listingController.getBuyerListings(categoryId: categoryId, gameId: widget.gameId, search: value);
                                },
                              style: textTheme.headline4?.copyWith(color: textWhiteColor),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: textTheme.headline4?.copyWith(color: textWhiteColor),
                                hintText: 'Search',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    SizedBox(
                      height: 45,
                      width: 66,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: backgroundBalticSeaColor,
                        onPressed: () {
                          _showDialog(context, textTheme);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/filter_icon.svg',
                          color: iconTintColor,
                          height: 18,
                          width: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Obx(() {
                        return Text(
                          "${listingController.buyerListings.length} Result",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headline6?.copyWith(color: textWhiteColor),
                        );
                      }),
                    ),
                    const SizedBox(width: 4.0),
                    DropDownDivider(categoryId: categoryId, gameId: widget.gameId),
                  ],
                ),
                const SizedBox(height: 4.0),
                const Divider(
                  color: dividerColor,
                  height: 4,
                  thickness: 2,
                  endIndent: 0,
                ),
                const SizedBox(height: 10.0),
                _buildGames(textTheme),
                const SizedBox(height: 16.0),
              ]
          ),
        ),
      ),
    );
  }


  _buildGames(TextTheme textTheme) {
    return Obx(() {
      if (listingController.isBuyerListingsFetching.value) {
        return const CustomLoader();
      } else if(listingController.buyerListings.isEmpty){
        return const NoDataFoundWidget(text: 'No Listings Found');
      }else{
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.70,
            mainAxisSpacing: 0.1,
            crossAxisSpacing: 0.1,
          ),
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: listingController.buyerListings.length + 1,
          itemBuilder: (context, index) {
            if (index < listingController.buyerListings.length) {
              return ItemList(
                  name: 'hello $index',
                  menuIcon: true,
                  listing: listingController.buyerListings[index]
              );
            }else{
              if (listingController.areMoreListingAvailable.value) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
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

  void _showDialog(BuildContext context, TextTheme textTheme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.3,
          maxChildSize: 0.3,
          minChildSize: 0.3,
          builder: (context, scrollController) {
            return Column(
              children: <Widget>[
                Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: backgroundBalticSeaColor,
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      child: FilterBottomSheet(controller: scrollController, categoryId: categoryId, gameId: widget.gameId),
                    )),
              ],
            );
          },
        );
      },
    );
  }
}
