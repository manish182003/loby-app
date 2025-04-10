import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/theme/theme.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/main.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:loby/presentation/widgets/custom_loading_widget.dart';
import 'package:sizer/sizer.dart';

class NoInternetConnection extends StatefulWidget {
  const NoInternetConnection({super.key});

  @override
  State<NoInternetConnection> createState() => _NoInternetConnectionState();
}

class _NoInternetConnectionState extends State<NoInternetConnection> {
  Rx<bool> isloading = false.obs;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Loby',
        theme: ApplicationTheme.getAppThemeData(),
        builder: FlutterSmartDialog.init(
          loadingBuilder: (String msg) => const CustomLoadingWidget(),
        ),
        home: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/no_internet.png',
                width: 10.h,
                height: 10.h,
              ),
              // SvgPicture.asset(
              //   'assets/icons/tick.svg',
              //   width: 10.h                ,
              //   height: 10.h,
              // ),
              SizedBox(
                height: 2.h,
              ),
              Text('No Internet Connection',
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(color: whiteColor)),
              SizedBox(
                height: 5.h,
              ),
              Obx(() {
                if (isloading.value) {
                  return CustomLoader();
                }
                return CustomButton(
                    name: "Retry",
                    color: aquaGreenColor,
                    left: 10.w,
                    right: 10.w,
                    bottom: 5.h,
                    onTap: () async {
                      isloading.value = true;
                      bool isDeviceConnected =
                          await InternetConnectionChecker.createInstance()
                              .hasConnection;
                      isloading.value = false;
                      if (!isDeviceConnected) {
                        Helpers.toast('Internet Not Connected');
                      } else {
                        // Helpers.hideLoader();
                        runMainApp();
                      }
                    });
              }),
            ],
          ),
        ),
      );
    });
  }
}
