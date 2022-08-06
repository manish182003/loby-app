import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Carousel extends StatefulWidget {
  final double? height;
  List<String>? images;
  final bool? autoPlay;
  final bool? isIndicator;

  Carousel(
      {Key? key, this.height, this.images, this.autoPlay, this.isIndicator})
      : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int activeIndex = 0;
  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final autoPlay = widget.autoPlay ?? true;
    final isIndicator = widget.isIndicator ?? true;
    return CarouselSlider.builder(
      carouselController: controller,
      options: CarouselOptions(
          height: widget.height ?? 22.h,
          initialPage: 0,
          viewportFraction: 1,
          autoPlay: autoPlay,
          autoPlayInterval: const Duration(seconds: 2),
          // enlargeCenterPage: true,
          // enlargeStrategy: CenterPageEnlargeStrategy.height,
          onPageChanged: (index, reason) {
            setState(() {
              activeIndex = index;
            });
          }),
      itemCount: widget.images!.length,
      itemBuilder: (context, index, realIndex) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset(
              widget.images![index],
              fit: BoxFit.fitWidth,
            ));
      },
    );
  }
}
