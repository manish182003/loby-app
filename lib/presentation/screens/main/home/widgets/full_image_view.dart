import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/widgets/carousel.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';

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
              ),
              SizedBox(
                height: 4.h,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: aquaGreenColor,
                    radius: 30,
                    child: const Icon(
                      Icons.close,
                      color: textBlackColor,
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
