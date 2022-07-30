import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';
import 'custom_button.dart';
import 'input_text_widget.dart';

class RatingDialog extends StatefulWidget {
  final String? title, descriptions, text;

  const RatingDialog({Key? key, this.title, this.descriptions, this.text});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _stars = 3;

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        // size: 30.0,
        color: _stars >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        setState(() {
          _stars = starCount;
        });
      },
    );
  }

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
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
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
                  widget.descriptions ?? 'test',
                  style: textTheme.headline5?.copyWith(color: textWhiteColor),
                ),
                const SizedBox(
                  height: 22,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildStar(1),
                      _buildStar(2),
                      _buildStar(3),
                      _buildStar(4),
                      _buildStar(5),
                    ]),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    textAlign: TextAlign.start,
                    'Write Review',
                    style: textTheme.headline5?.copyWith(color: textWhiteColor),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const InputTextWidget(
                  hintName: '',
                  maxLines: 4,
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
                          onTap: () {
                            Navigator.pop(context);
                          })),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
