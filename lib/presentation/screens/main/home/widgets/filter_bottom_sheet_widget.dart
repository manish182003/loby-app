import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_button.dart';

class FilterBottomSheet extends StatefulWidget {
  final ScrollController controller;

  const FilterBottomSheet({Key? key, required this.controller});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  bool visible = false;
  RangeValues _rangeSliderDiscreteValues = const RangeValues(0, 235000);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView.builder(
      controller: widget.controller,
      // assign controller here
      itemCount: 1,
      itemBuilder: (_, index) => Padding(
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
                  trackShape: RectangularSliderTrackShape(),
                  trackHeight: 1,
                  thumbColor: whiteColor,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  overlayColor: aquaGreenColor.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                ),
                child: RangeSlider(
                  values: _rangeSliderDiscreteValues,
                  min: 0,
                  max: 235000,
                  labels: RangeLabels(
                    _rangeSliderDiscreteValues.start.round().toString(),
                    _rangeSliderDiscreteValues.end.round().toString(),
                  ),
                  onChanged: (values) {
                    setState(() {
                      _rangeSliderDiscreteValues = values;
                      debugPrint(values.toString());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0',
                        style: textTheme.headline4
                            ?.copyWith(color: textWhiteColor)),
                    Text('2,35,000',
                        style: textTheme.headline4
                            ?.copyWith(color: textWhiteColor)),
                  ],
                ),
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
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: CustomButton(
                      color: purpleLightIndigoColor,
                      textColor: textWhiteColor,
                      name: "Apply",
                      onTap: () {
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
