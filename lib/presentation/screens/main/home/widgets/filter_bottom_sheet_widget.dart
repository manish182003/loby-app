import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/buttons/custom_button.dart';
import '../../profile/wallet/widgets/token_widget.dart';

class FilterBottomSheet extends StatefulWidget {
  final ScrollController controller;
  final int categoryId;
  final int gameId;

  const FilterBottomSheet({super.key, required this.controller, required this.categoryId, required this.gameId});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {

  ListingController listingController = Get.find<ListingController>();
  final _formKey = GlobalKey<FormState>();
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;

    listingController.rangeSliderDiscreteValues.value = RangeValues(0, listingController.maxFilterPrice.value.toDouble());
    return ListView.builder(
      controller: widget.controller,
      // assign controller here
      itemCount: 1,
      itemBuilder: (_, index) =>
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 1.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text('Price',
                          textAlign: TextAlign.left,
                          style:
                          textTheme.headline3?.copyWith(color: textWhiteColor)),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 1.h,
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: whiteColor,
                      inactiveTrackColor: whiteColor,
                      trackShape: const RectangularSliderTrackShape(),
                      trackHeight: 1,
                      thumbColor: whiteColor,
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 12.0),
                      overlayColor: aquaGreenColor.withAlpha(32),
                      overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 28.0),
                    ),
                    child: Obx(() {

                      return RangeSlider(
                        values: listingController.rangeSliderDiscreteValues.value,
                        min: 0,
                        max: listingController.maxFilterPrice.value.toDouble(),
                        labels: RangeLabels(
                          listingController.rangeSliderDiscreteValues.value.start.round().toString(),
                          listingController.rangeSliderDiscreteValues.value.end.round().toString(),
                        ),
                        onChanged: (values) {
                          listingController.rangeSliderDiscreteValues.value = values;
                        },
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TokenWidget(text:  Text('${listingController.rangeSliderDiscreteValues.value.start.floor()}',
                              style: textTheme.headline4?.copyWith(color: textWhiteColor)), size: 20,),
                          TokenWidget(text: Text('${listingController.rangeSliderDiscreteValues.value.end.floor()}',
                              style: textTheme.headline4?.copyWith(color: textWhiteColor)), size: 20,),
                        ],
                      );
                    }),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 4.h,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.3,
                        child: CustomButton(
                          color: purpleLightIndigoColor,
                          textColor: textWhiteColor,
                          name: "Apply",
                          onTap: () {
                            listingController.buyerListingPageNumber.value = 1;
                            listingController.areMoreListingAvailable.value = true;
                            listingController.getBuyerListings(
                                categoryId: widget.categoryId,
                                gameId: widget.gameId,
                                priceFrom: listingController.rangeSliderDiscreteValues.value.start.floor(),
                              priceTo: listingController.rangeSliderDiscreteValues.value.end.floor());

                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
