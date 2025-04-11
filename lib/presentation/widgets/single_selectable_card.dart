import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class SingleSelectableCard extends StatefulWidget {
  final List<String> options;
  final double? height;
  final double? leftRightPadding;
  final int? gridCount;
  final Function(Object) onSelected;
  final int? selectedCard;

  const SingleSelectableCard(
      {super.key,
      required this.options,
      required this.onSelected,
      this.height,
      this.gridCount,
      this.leftRightPadding,
      this.selectedCard});

  @override
  SingleSelectableCardState createState() => SingleSelectableCardState();
}

class SingleSelectableCardState extends State<SingleSelectableCard> {
  int? _selected;

  @override
  void initState() {
    _selected = widget.selectedCard;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 6,
      mainAxisSpacing: 0,
      crossAxisSpacing: 4.w,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 3,
          mainAxisCellCount: 1.2,
          child: selectWinnerTile(0),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 3,
          mainAxisCellCount: 1.2,
          child: selectWinnerTile(1),
        ),
      ],
    );
  }

  Widget selectWinnerTile(int index) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        widget.onSelected(widget.options[index]);
        setState(() {
          _selected = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _selected == index ? Color(0xFFF47960) : null,
          border: Border.all(
              // color: _selected == index ? aquaGreenColor : carminePinkColor,
              color:
                  _selected == index ? Colors.transparent : Color(0xFFD9D9D9),
              width: 1,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(12.0),
        ),
        alignment: Alignment.center,
        child: Text(widget.options[index],
            style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w500,
                // color: _selected == index ? aquaGreenColor : carminePinkColor,
                color: _selected == index ? textBlackColor : textWhiteColor)),
      ),
    );
  }
}
