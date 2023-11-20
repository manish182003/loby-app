import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/screens/onboarding/widgets/image_swipe.dart';
import 'package:loby/presentation/screens/onboarding/widgets/onbaording1.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/buttons/custom_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  int selectedIndex = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageSwipe(
                pageController: _controller,
                onChanged: (index){
                  setState((){
                    selectedIndex = index;
                  });
                },
                pageView: [
                  OnBoarding1(
                    backgroundImage: "1b",
                    frontImage: "1a",
                    title: "monetize your game time \n& skills",
                    desc: "Earn money for your time & skills while helping other gamers achieve their goals",
                    frontImageSize: 33.h,
                  ),
                  OnBoarding1(
                    backgroundImage: "2b",
                    frontImage: "2a",
                    title: "buy / sell game accounts, items & currencies",
                    desc: "Buy game accounts from trusted & verified users",
                    frontImageSize: 41.h,
                    frontImagePosition: -2.h,
                  ),
                  OnBoarding1(
                    backgroundImage: "3b",
                    frontImage: "3a",
                    title: "hire pro-gamers & coaches \nto learn from them",
                    desc: "Users can hire pro-gamers or coaches for push-rank, improve gameplay, competitive gaming, streaming & much more",
                    frontImageSize: 37.h,
                    frontImagePosition: -2.h,
                  ),
                  OnBoarding1(
                    backgroundImage: "4b",
                    frontImage: "4a",
                    title: "play with your favourite \ne-athlete & streamer",
                    desc: "Book and play with your favourite streamer or gaming celebrity",
                    frontImageSize: 37.h,
                    frontImagePosition: -4.h,
                  ),
                  OnBoarding1(
                    backgroundImage: "5b",
                    frontImage: "5a",
                    title: "challenge other gamers for a duel",
                    desc: "Play duel matches or compete with other gamers",
                    frontImageSize: 42.h,
                    backImageSize: 42.h,
                    frontImagePosition: -4.h,
                  ),
                ],
              ),
              CustomButton(
                  name: selectedIndex < 4 ? "Next" : "Next",
                  color: aquaGreenColor,
                  left: 46.w,
                  right: 12.w,
                  bottom: 2.h,
                  top: 4.h,
                  onTap: () async{
                    if(selectedIndex < 4){
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOutQuint);
                    }else{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('onBoardingDone', true);
                      context.goNamed(loginPage);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
