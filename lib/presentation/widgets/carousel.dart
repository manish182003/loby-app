import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../screens/main/home/widgets/full_image_view.dart';

class Carousel extends StatefulWidget {
  final double? height;
  final List<CarouselList> images;
  final bool autoPlay;
  final bool isIndicator;
  const Carousel(
      {super.key,
      this.height,
      required this.images,
      this.autoPlay = true,
      this.isIndicator = true});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int activeIndex = 0;
  final controller = CarouselSliderController();

  VideoPlayerController videoPlayerController = VideoPlayerController.asset('');
  ChewieController? chewieController;

  Future<void> _initPlayer(String url) async {
    videoPlayerController = VideoPlayerController.network(url);
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: (context) => debugPrint('Option 1 pressed!'),
            iconData: Icons.chat,
            title: 'Option 1',
          ),
          OptionItem(
            onTap: (context) => debugPrint('Option 2 pressed!'),
            iconData: Icons.share,
            title: 'Option 2',
          ),
        ];
      },
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = widget.images.where((element) => element.type != 3).toList();

    return Stack(
      children: [
        CarouselSlider.builder(
            carouselController: controller,
            options: CarouselOptions(
                height: widget.height ?? 22.h,
                initialPage: 0,
                viewportFraction: 1,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 2),
                pauseAutoPlayOnTouch: true,
                // enlargeCenterPage: true,
                // enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                }),
            itemCount: list.length,
            itemBuilder: (context, index, realIndex) {
              if (list[index].type == 2) {
                return buildImage(
                    urlImage: widget.images[index].path,
                    index: index,
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  FullImageView(image: list)));
                    });
              } else if (list[index].type == 1) {
                return GestureDetector(
                  onTap: () async {
                    Helpers.loader(canCancel: true);
                    await _initPlayer(widget.images[index].path);
                    _videoPlayerDialog(context);
                    Helpers.hideLoader();
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: buildLocalImage(
                            imagePath: "assets/images/listing_placeholder.jpg"),
                      ),
                      const Icon(
                        Icons.play_circle_outline,
                        color: whiteColor,
                        size: 50,
                      ),
                    ],
                  ),
                );
              } else {
                return buildLocalImage(
                    imagePath: "assets/images/listing_placeholder.jpg");
              }
            }),
        Positioned.fill(
          bottom: 12.0,
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: SizedBox(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        animateToSlide(activeIndex - 1);
                      },
                      child: const SizedBox(
                        height: 32,
                        width: 32,
                        child: CircleAvatar(
                          backgroundColor: orangeColor,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: iconWhiteColor,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        animateToSlide(activeIndex + 1);
                      },
                      child: const SizedBox(
                        height: 32,
                        width: 32,
                        child: CircleAvatar(
                          backgroundColor: orangeColor,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: iconWhiteColor,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        )
      ],
    );
  }

  Widget buildImage({String? urlImage, int? index, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: CachedNetworkImage(
            imageUrl: urlImage!,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Widget buildLocalImage({String? imagePath, int? index, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          // margin: EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset(
            imagePath!,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }

  void animateToSlide(int index) {
    controller.animateToPage(index);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<VideoPlayerController>(
        'videoPlayerController', videoPlayerController));
  }

  void _videoPlayerDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            videoPlayerController.pause();
            chewieController?.pause();
            return Future.value(true);
          },
          child: Dialog(
            elevation: 0,
            backgroundColor: backgroundDarkJungleGreenColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      onTap: () {
                        videoPlayerController.pause();
                        chewieController?.pause();
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close, color: whiteColor)),
                  SizedBox(height: 2.h),
                  AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: Chewie(
                      controller: chewieController!,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CarouselList {
  final int type;
  final String path;

  CarouselList({required this.type, required this.path});
}
