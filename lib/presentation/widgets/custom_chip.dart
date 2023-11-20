import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';

class CustomChip extends StatefulWidget {
  final String? label;
  final Color? color;
  final List<String> labelName;
  final ValueChanged<int>? onChanged;
  final int selectedIndex;
  final double? spacing;

  const CustomChip({Key? key, this.label, this.color, required this.labelName, this.onChanged, this.selectedIndex = 0, this.spacing}) : super(key: key);

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  int _selectedIndex = 0;

@override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    return Wrap(
      spacing: widget.spacing ?? 8.0,
      children: [
        ...List.generate(
            widget.labelName.length,
            (index) => ChoiceChip(
                  selected: _selectedIndex == index,
                  label: Text(widget.labelName[index].toString(),
                        style: textTheme.headline6?.copyWith(color: textWhiteColor)),
                  elevation: 1,
                  side: BorderSide(
                      color: widget.color ?? orangeColor,
                      width: 1,
                      style: BorderStyle.solid),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  pressElevation: 1,
                  backgroundColor: backgroundDarkJungleGreenColor,
                  selectedColor: widget.color ?? orangeColor,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedIndex = index;
                        widget.onChanged!(index);
                      }
                    });
                  },
            ),),
      ],
    );
  }
}
