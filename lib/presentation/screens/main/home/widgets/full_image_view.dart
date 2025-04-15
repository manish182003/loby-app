import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/widgets/carousel.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class FullImageView extends StatefulWidget {
  final List<CarouselList> image;
  const FullImageView({super.key, required this.image});

  @override
  State<FullImageView> createState() => _FullImageViewState();
}

class _FullImageViewState extends State<FullImageView> {
  VideoPlayerController videoPlayerController = VideoPlayerController.asset('');
  ChewieController? chewieController;
  int? currentVideoIndex;

  Future<void> _initPlayer(String url, int index) async {
    videoPlayerController.dispose();
    chewieController?.dispose();

    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
    await videoPlayerController.initialize();

    // videoPlayerController.addListener(() {
    //   if (videoPlayerController.value.position >=
    //           videoPlayerController.value.duration &&
    //       !videoPlayerController.value.isPlaying &&
    //       mounted) {
    //     setState(() {
    //       videoPlayerController.removeListener(
    //         () {},
    //       );
    //       _initPlayer(url, index);
    //     });
    //   }
    // });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true, // disable loop
      showOptions: false, // hide three dots menu
      allowPlaybackSpeedChanging: false,
    );

    setState(() {
      currentVideoIndex = index;
    });
  }

  @override
  void initState() {
    initiliazeFirstVideo();
    super.initState();
  }

  initiliazeFirstVideo() {
    var image = widget.image.first;
    if (image.path.contains("mp4")) {
      _initPlayer(image.path, 0);
    }
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

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
                  onPageChanged: (index) {
                    var image = widget.image[index];
                    if (image.path.contains("mp4")) {
                      _initPlayer(image.path, index);
                    }
                  },
                  itemBuilder: (context, index) {
                    var image = widget.image[index];

                    if (image.path.contains("mp4")) {
                      if (index == currentVideoIndex &&
                          videoPlayerController.value.isInitialized &&
                          chewieController != null) {
                        return AspectRatio(
                          aspectRatio: videoPlayerController.value.aspectRatio,
                          child: Chewie(controller: chewieController!),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }

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
