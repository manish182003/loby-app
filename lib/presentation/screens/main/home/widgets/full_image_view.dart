import 'package:flutter/material.dart';
import 'package:loby/presentation/widgets/carousel.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';

class FullImageView extends StatefulWidget {
  final List<CarouselList> image;
  const FullImageView({super.key, required this.image});

  @override
  State<FullImageView> createState() => _FullImageViewState();
}

class _FullImageViewState extends State<FullImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close, color: whiteColor)),
              SizedBox(height: 2.h),
              SizedBox(
                // height: 300,
                height: MediaQuery.of(context).size.height / 1.5,

                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.image.length,
                  itemBuilder: (context, index) {
                    var image = widget.image[index];
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.5,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: PhotoView(
                        imageProvider: NetworkImage(image.path),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
