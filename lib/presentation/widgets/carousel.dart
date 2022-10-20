import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/domain/entities/listing/user_game_service_image.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';


class Carousel extends StatefulWidget {
  final double? height;
  final List<UserGameServiceImage> images;
  final bool autoPlay;
  final bool isIndicator;
  const Carousel({Key? key, this.height,required this.images, this.autoPlay = true, this.isIndicator = true}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {

  int activeIndex = 0;
  final controller = CarouselController();

  VideoPlayerController videoPlayerController = VideoPlayerController.asset('');
  ChewieController? chewieController;


  void _initPlayer(String url) async {
    videoPlayerController = VideoPlayerController.network(url);
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () => debugPrint('Option 1 pressed!'),
            iconData: Icons.chat,
            title: 'Option 1',
          ),
          OptionItem(
            onTap: () =>
                debugPrint('Option 2 pressed!'),
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
              onPageChanged: (index, reason){
                setState(() {
                  activeIndex = index;
                });
              }
          ),
          itemCount: widget.images.length,
          itemBuilder: (context, index, realIndex) {
            final list = widget.images.where((element) => element.type != 3).toList();
            if(list[index].type == 2){
              print("build image");
              return buildImage(
                urlImage: widget.images[index].path,
                index: index,
              );
            }else if(list[index].type == 1){
              _initPlayer(list[index].path!);
              if(chewieController != null){
                print("build controllee");
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Chewie(
                    controller: chewieController!,
                  ),
                );
              }else{
                print("build circular");
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }else{
              print("build norhing");
              return const SizedBox();
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
                      onTap: (){
                        animateToSlide(activeIndex-1);
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
                      onTap: (){
                        animateToSlide(activeIndex+1);
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


  Widget buildImage({String? urlImage, int? index, Function()? onTap}){
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
            placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }


  Widget buildLocalImage({String? imagePath, int? index, Function()? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        // margin: EdgeInsets.symmetric(horizontal: 12),
        child:  Image.asset(imagePath!,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  void animateToSlide(int index){
    controller.animateToPage(index);
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<VideoPlayerController>('videoPlayerController', videoPlayerController));
  }
}
