import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loby/presentation/widgets/carousel.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullImageView extends StatefulWidget {
  final CarouselList image;
  const FullImageView({Key? key, required this.image}) : super(key: key);

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
                  onTap: (){
                    Navigator.pop(context);
                  }, child: const Icon(Icons.close, color: whiteColor)),
              SizedBox(height: 2.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: backgroundColor,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: PhotoView(
                      imageProvider: NetworkImage(widget.image.path),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
