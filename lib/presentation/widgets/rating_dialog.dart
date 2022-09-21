import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loby/presentation/widgets/text_fields/text_field_widget.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';
import 'buttons/custom_button.dart';
import 'input_text_widget.dart';

class RatingDialog extends StatefulWidget {
  final String? title, descriptions, text;
  final TextEditingController review;
  final ValueChanged<double>? onChanged;
  final Function() onSubmit;

  const RatingDialog({super.key, this.title, this.descriptions, this.text, this.onChanged, required this.onSubmit, required this.review});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      insetPadding: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context, textTheme),
    );
  }

  contentBox(context, textTheme) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: backgroundDarkJungleGreenColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.title ?? 'test',
            style: textTheme.headline2?.copyWith(color: textWhiteColor),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            textAlign: TextAlign.center,
            widget.descriptions ?? 'test',
            style: textTheme.headline5?.copyWith(color: textWhiteColor),
          ),
          const SizedBox(
            height: 22,
          ),
          RatingBar.builder(
            initialRating: 1,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: aquaGreenColor,
            ),
            onRatingUpdate: widget.onChanged!,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            textEditingController: widget.review,
            title: 'Write Review',
            titleColor: textWhiteColor,
            maxLines: 5,
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Align(
                alignment: Alignment.bottomRight,
                child: CustomButton(
                    color: aquaGreenColor,
                    textColor: textBlackColor,
                    name: "OK",
                    onTap: widget.onSubmit
                )),
          ),
        ],
      ),
    );
  }
}
