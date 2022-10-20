import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class ImageSwipe extends StatefulWidget {
  final List<Widget> pageView;
  final ValueChanged<int>? onChanged;
  final PageController pageController;
  const ImageSwipe({super.key, required this.pageView, this.onChanged, required this.pageController, });

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {

  int _selectedPage = 0;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Stack(
        children: [
          PageView(
            controller: widget.pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedPage = index;
                widget.onChanged!(index);
              });
            },
            children: [
              for(var i=0; i < widget.pageView.length; i++)
               widget.pageView[i],
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 30,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for(var i=0; i < widget.pageView.length; i++)
                  AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 300
                    ),
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    width: _selectedPage == i ? 35.0 : 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: _selectedPage == i ? aquaGreenColor : whiteColor,
                      borderRadius: BorderRadius.circular(12.0)
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
