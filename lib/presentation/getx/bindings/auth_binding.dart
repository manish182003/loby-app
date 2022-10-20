import 'package:get/get.dart';
import 'package:loby/domain/usecases/auth/add_fcm_token.dart';
import 'package:loby/domain/usecases/auth/check_username.dart';
import 'package:loby/domain/usecases/auth/get_cities.dart';
import 'package:loby/domain/usecases/auth/get_countries.dart';
import 'package:loby/domain/usecases/auth/get_profile_tags.dart';
import 'package:loby/domain/usecases/auth/get_states.dart';
import 'package:loby/domain/usecases/auth/login.dart';
import 'package:loby/domain/usecases/auth/signup.dart';
import 'package:loby/domain/usecases/auth/update_profile.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';

import '../../../domain/usecases/auth/send_and_verify_otp.dart';


class AuthBinding extends Bindings {

  @override
  void dependencies() {

    final signup = Get.find<Signup>();
    final getCountries = Get.find<GetCountries>();
    final getStates = Get.find<GetStates>();
    final getCities = Get.find<GetCities>();
    final getProfileTags = Get.find<GetProfileTags>();
    final updateProfile = Get.find<UpdateProfile>();
    final login = Get.find<Login>();
    final checkUsername = Get.find<CheckUsername>();
    final addFCMToken = Get.find<AddFCMToken>();
    final sendAndVerifyOTP = Get.find<SendAndVerifyOTP>();

    Get.lazyPut(() => AuthController(
      signup: signup,
      getCountries: getCountries,
      getStates: getStates,
      getCities: getCities,
      getProfileTags: getProfileTags,
      updateProfile: updateProfile, login: login, checkUsername: checkUsername,
      addFCMToken: addFCMToken,
      sendAndVerifyOTP: sendAndVerifyOTP

    ));
  }

}