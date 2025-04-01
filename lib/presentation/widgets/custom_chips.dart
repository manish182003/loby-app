import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

class CustomChips extends StatelessWidget {
  final String? chipName;
  final Function? removeItem;

  const CustomChips({Key? key, this.chipName, this.removeItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Wrap(
      alignment: WrapAlignment.end,
      children: <Widget>[
        Stack(alignment: AlignmentDirectional.topEnd, children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 24.0, 5.0),
            decoration: BoxDecoration(
              color: butterflyBlueColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 13.0,
              runSpacing: 10.0,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                  child: Text(
                    chipName!,
                    style:
                        textTheme.displaySmall!.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            right: 12.0,
            bottom: 0.0,
            child: GestureDetector(
              onTap: () {
                removeItem!();
              },
              child: const SizedBox(
                height: 18,
                width: 18,
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Icon(
                    Icons.close,
                    color: Color(0xffFD0000),
                    size: 16,
                  ),
                ), /*CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xffFD0000),
                        child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Icon(
                            Icons.close, color: Colors.white,
                            size: 16,),
                        )
                    ),*/
              ),
            ),
          ),
        ])
      ],
    );
  }
}
