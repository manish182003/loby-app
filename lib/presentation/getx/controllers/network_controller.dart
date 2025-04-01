import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';

import '../../../core/utils/helpers.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late List<ConnectivityResult> _connectivityResult;
  late StreamSubscription<List<ConnectivityResult>> _streamSubscription;

  ProfileController profileController = Get.find<ProfileController>();

  @override
  void onInit() async {
    super.onInit();
    _initConnectivity();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivity() async {
    _connectivityResult = await _connectivity.checkConnectivity();
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResult) {
    if (kDebugMode) print("STATUS : $connectivityResult");

    if (connectivityResult.first == ConnectivityResult.none) {
      Helpers.toast("Internet Not Connected");
      // SmartDialog.show(
      //   backDismiss: false,
      //   clickMaskDismiss: false,
      //   builder: (context) {
      //   final textTheme = Theme.of(context).textTheme;
      //   return Dialog(
      //     elevation: 0,
      //     backgroundColor: backgroundDarkJungleGreenColor,
      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         SizedBox(height: 2.h,),
      //         Image.asset('assets/images/no_internet.png', width: 10.h,height: 10.h,),
      //         // SvgPicture.asset(
      //         //   'assets/icons/tick.svg',
      //         //   width: 10.h,
      //         //   height: 10.h,
      //         // ),
      //         SizedBox(height: 2.h,),
      //         Text('No Internet Connection',
      //             textAlign: TextAlign.center,
      //             style: textTheme.subtitle1?.copyWith(color: whiteColor)),
      //         SizedBox(height: 5.h,),
      //         CustomButton(
      //             name: "Retry",
      //             color: aquaGreenColor,
      //             left: 10.w,
      //             right: 10.w,
      //             bottom: 5.h,
      //             onTap: () async{
      //               bool isDeviceConnected = await InternetConnectionChecker().hasConnection;
      //               if (!isDeviceConnected) {
      //                 Helpers.toast('Internet Not Connected Yet');
      //               }else{
      //                 SmartDialog.dismiss();
      //               }
      //             }),
      //       ],
      //     ),
      //   );
      // });
    } else {
      // profileController.getProfile();
      // SmartDialog.dismiss();
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
