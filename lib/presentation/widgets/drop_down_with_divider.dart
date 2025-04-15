import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';

class DropDownDivider extends StatefulWidget {
  final int categoryId;
  final int gameId;
  const DropDownDivider(
      {super.key, required this.categoryId, required this.gameId});

  @override
  State<DropDownDivider> createState() => _DropDownDividerState();
}

class _DropDownDividerState extends State<DropDownDivider> {
  final List<String> items = [
    'Top Rated',
    'Most Recent',
    'Low to High Price',
    'High to Low Price',
  ];
  String selectedValue = 'Top Rated';
  ListingController listingController = Get.find<ListingController>();

  void _onSelect(String value) {
    setState(() {
      selectedValue = value;
    });

    listingController.buyerListingPageNumber.value = 1;
    listingController.areMoreListingAvailable.value = true;

    switch (value) {
      case 'Top Rated':
        listingController.getBuyerListings(
          categoryId: widget.categoryId,
          gameId: widget.gameId,
          sortByRating: 'desc',
        );
        break;
      case 'Most Recent':
        listingController.getBuyerListings(
          categoryId: widget.categoryId,
          gameId: widget.gameId,
        );
        break;
      case 'Low to High Price':
        listingController.getBuyerListings(
          categoryId: widget.categoryId,
          gameId: widget.gameId,
          sortByPrice: 'asc',
        );
        break;
      case 'High to Low Price':
        listingController.getBuyerListings(
          categoryId: widget.categoryId,
          gameId: widget.gameId,
          sortByPrice: 'desc',
        );
        break;
      default:
        listingController.getBuyerListings(
          categoryId: widget.categoryId,
          gameId: widget.gameId,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: PopupMenuButton<String>(
        onSelected: _onSelect,
        color: shipGreyColor,
        offset: const Offset(0, 35),
        menuPadding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        itemBuilder: (BuildContext context) {
          List<PopupMenuEntry<String>> entries = [];

          for (int i = 0; i < items.length; i++) {
            entries.add(
              PopupMenuItem<String>(
                value: items[i],
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      items[i],
                      style:
                          textTheme.titleLarge?.copyWith(color: textWhiteColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );

            if (i != items.length - 1) {
              entries.add(const PopupMenuDivider(
                height: 0.5,
              ));
            }
          }

          return entries;
        },
        child: Padding(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Text(
                selectedValue,
                style: textTheme.titleLarge?.copyWith(color: textWhiteColor),
              ),
              SizedBox(
                width: 1.w,
              ),
              const Icon(Icons.keyboard_arrow_down, color: iconWhiteColor),
            ],
          ),
        ),
      ),
    );
  }
}
