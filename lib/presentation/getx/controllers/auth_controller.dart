
// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loby/core/usecases/auth_params.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/models/profile/user_model.dart';
import 'package:loby/domain/entities/auth/city.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/auth/profile_tag.dart';
import 'package:loby/domain/entities/auth/selected_option.dart';
import 'package:loby/domain/usecases/auth/check_username.dart';
import 'package:loby/domain/usecases/auth/forgot_and_reset_password.dart';
import 'package:loby/domain/usecases/auth/get_cities.dart';
import 'package:loby/domain/usecases/auth/get_countries.dart';
import 'package:loby/domain/usecases/auth/get_profile_tags.dart';
import 'package:loby/domain/usecases/auth/get_states.dart';
import 'package:loby/domain/usecases/auth/login.dart';
import 'package:loby/domain/usecases/auth/send_and_verify_otp.dart';
import 'package:loby/domain/usecases/auth/signup.dart';
import 'package:loby/domain/usecases/auth/update_profile.dart';
import 'package:loby/presentation/getx/controllers/core_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/profile/user_model.dart';
import '../../../domain/entities/auth/state.dart' as state;
import '../../../domain/usecases/auth/add_fcm_token.dart';
import '../../../services/routing_service/routes_name.dart';
import 'profile_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AuthController extends GetxController{

  final Signup _signup;
  final Login _login;
  final GetCountries _getCountries;
  final GetStates _getStates;
  final GetCities _getCities;
  final GetProfileTags _getProfileTags;
  final UpdateProfile _updateProfile;
  final CheckUsername _checkUsername;
  final AddFCMToken _addFCMToken;
  final SendAndVerifyOTP _sendAndVerifyOTP;
  final ForgotAndResetPassword _forgotAndResetPassword;

  AuthController({
    required Signup signup,
    required Login login,
    required GetCountries getCountries,
    required GetStates getStates,
    required GetCities getCities,
    required GetProfileTags getProfileTags, required UpdateProfile updateProfile,
    required CheckUsername checkUsername,
    required AddFCMToken addFCMToken,
    required SendAndVerifyOTP sendAndVerifyOTP,
    required ForgotAndResetPassword forgotAndResetPassword,
    }) : _signup = signup,
        _getCountries = getCountries,
        _getStates = getStates,
        _getCities = getCities,
        _getProfileTags = getProfileTags,
        _updateProfile = updateProfile,
        _login = login,
  _checkUsername = checkUsername,
        _addFCMToken = addFCMToken,
        _sendAndVerifyOTP = sendAndVerifyOTP,
        _forgotAndResetPassword = forgotAndResetPassword;



  final auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;


  final countries = <Country>[].obs;
  final areMoreCountriesAvailable = true.obs;
  final countriesPageNumber = 1.obs;
  final isCountriesFetching = false.obs;

  final states = <state.State>[].obs;

  final cities = <City>[].obs;

  final profileTags = <ProfileTag>[].obs;

  final coverImageFile = File('').obs;
  final profileImageFile = File('').obs;
  final fullName = TextEditingController().obs;
  final displayName = TextEditingController().obs;
  final selectedCountry = SelectedOption(id: 0, name: "").obs;
  final selectedState = SelectedOption(id: 0, name: "").obs;
  final selectedCity = SelectedOption(id: 0, name: "").obs;
  final DOB = TextEditingController().obs;
  final selectedProfileTags = <Map<String, dynamic>>[].obs;
  final bio = TextEditingController().obs;



  final errorMessage = ''.obs;



  final isGoogleSignInSuccess = false.obs;

  final isUsernameAvailable = false.obs;
  final usernameString = "".obs;




   Future<void> saveProfileDetails()async{
     CoreController coreController = Get.find<CoreController>();
     ProfileController profileController = Get.find<ProfileController>();
     final userId = await Helpers.getUserId();
     final apiToken = await Helpers.getString('apiToken');
     final fcmToken = await Helpers.getString('fcmToken');
     if(userId != null && apiToken != null){

       print("user id token");
       profileController.getProfile();
       addFCMToken(fcmToken: fcmToken);
       analytics.setUserId(id: '$userId');
       analytics.logEvent(name: 'loggedInUser', parameters: ({'userId' : '$userId'}));
       coreController.connect(userId);
     }else if(apiToken != null){

       print("api token");

       profileController.getProfile();
     }
   }


   Future<void> loggedUserIn()async{
       SharedPreferences prefs = await SharedPreferences.getInstance();
       prefs.setBool('isLoggedIn', true);
   }


  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clearProfileDetails();
    await prefs.remove('apiToken');
    await prefs.remove('isLoggedIn');
  }


  Future<bool> googleSignInMethod(BuildContext context) async{
    await Helpers.loader();

    try{

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      debugPrint("id : ${googleUser?.id}");
      debugPrint("name : ${googleUser?.displayName}");
      debugPrint("email : ${googleUser?.email}");
      debugPrint("image : ${googleUser?.photoUrl}");
      GoogleSignInAuthentication? googleSignInAuthentication = await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );

      await auth.signInWithCredential(credential).then((user)async{
        isGoogleSignInSuccess.value = await login(socialLoginId: googleUser?.id, socialLoginType: 2, name: googleUser?.displayName, email: googleUser?.email);
        fullName.value.text = googleUser?.displayName ?? '';
        profileImageFile.value = await Helpers.urlToFile(googleUser?.photoUrl ?? '');
        await Helpers.hideLoader();
      });

      return isGoogleSignInSuccess.value;
    }catch(e){
      debugPrint('Error is $e');
      Helpers.hideLoader();
      Helpers.toast("Can't sign in with google at this moment.");
      return false;
    }
  }

  Future<bool> signup({required String name, required String email, required String password, required String confirmPassword}) async {
    final failureOrSuccess = await _signup(
      Params(authParams: AuthParams(
          name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {

            fullName.value.text = success['name'];
            debugPrint(fullName.value.text);
        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> login({String? email, String? password, String? socialLoginId, int? socialLoginType, String? name}) async {
    final failureOrSuccess = await _login(
      Params(authParams: AuthParams(
          email: email,
          password: password,
        socialLoginId: socialLoginId,
        socialLoginType: socialLoginType,
        name: name,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
            saveProfileDetails();
        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> getCountries({required String search, int? page}) async {
    isCountriesFetching.value = true;

    final failureOrSuccess = await _getCountries(
      Params(authParams: AuthParams(
          search: search,
          page: page,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isCountriesFetching.value = false;
        },
          (success) {

            countries.value = success.countries;
            isCountriesFetching.value = false;
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> getStates({required String search, int? stateId, int? countryId, int? page}) async {


    final failureOrSuccess = await _getStates(
      Params(authParams: AuthParams(
        search: search,
        stateId: stateId,
        countryId: countryId,
        page: page,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isCountriesFetching.value = false;
      },
          (success) {
        states.value = success.states;
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> getCities({required String search, int? stateId, int? cityId, int? page}) async {

    final failureOrSuccess = await _getCities(
      Params(authParams: AuthParams(
        search: search,
        stateId: stateId,
        cityId: cityId,
        page: page,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);

      },
          (success) {
        cities.value = success.cities;
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> getProfileTags({required String search, int? page}) async {

    final failureOrSuccess = await _getProfileTags(
      Params(authParams: AuthParams(
        search: search,
        page: page,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
        profileTags.value = success.profileTags;
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> updateProfile({String? from}) async {
    final failureOrSuccess = await _updateProfile(
      Params(authParams: AuthParams(
          cover: coverImageFile.value,
          avatar: profileImageFile.value,
          fullName: fullName.value.text,
          displayName: displayName.value.text,
          countryId: selectedCountry.value.id,
          stateId: selectedState.value.id,
          cityId: selectedCity.value.id,
          DOB: Helpers.getDateFormat(DOB.value.text),
          profileTags: selectedProfileTags,
          bio: bio.value.text
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
            if(from == 'signIn'){
              clearProfileDetails();
              saveProfileDetails();
            }
            // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  void clearProfileDetails(){
    profileImageFile.value = File('');
    coverImageFile.value = File('');
    fullName.value.clear();
    displayName.value.clear();
    selectedCountry.value = SelectedOption(id: 0, name: "");
    selectedState.value = SelectedOption(id: 0, name: "");
    selectedCity.value = SelectedOption(id: 0, name: "");
    DOB.value.clear();
    selectedProfileTags.clear();
    bio.value.clear();
  }


  Future<void> getProfileDetails()async{
     ProfileController profileController = Get.find<ProfileController>();
     final profile = profileController.profile;
     // profileController.isProfileFetching(true);
     coverImageFile.value = (profile.coverImage == null ? File('') : await Helpers.urlToFile(profile.coverImage!));
     profileImageFile.value = (profile.image == null ? File('') : await Helpers.urlToFile(profile.image!));
     fullName.value.text = profile.name ?? '';
     displayName.value.text = profile.displayName ?? '';
     selectedCountry.value = SelectedOption(id: profile.country!.id!, name: profile.country!.name!);
     selectedState.value = SelectedOption(id: profile.state!.id!, name: profile.state!.name!);
     selectedCity.value = SelectedOption(id: profile.city!.id!, name: profile.city!.name!);
     DOB.value.text = (Helpers.formatDateTime(dateTime: profile.dob!)).split(" ")[0];
     selectedProfileTags.clear();
      for(final i in profile.profileTags!){
        selectedProfileTags.add({
          'name': i.name,
          'id': i.id
        });
      }
      bio.value.text = profile.bio!;
     // profileController.isProfileFetching(false);
  }


  Future<bool> checkUsername(String username) async {

    final failureOrSuccess = await _checkUsername(
      Params(authParams: AuthParams(
       displayName: username
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {

            isUsernameAvailable.value = success == "User name available" ? true : false;
        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> addFCMToken({required String fcmToken}) async {

    final failureOrSuccess = await _addFCMToken(
      Params(authParams: AuthParams(
          fcmToken: fcmToken
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {

        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> sendAndVerifyOTP({required String email, String? otp}) async {

    final failureOrSuccess = await _sendAndVerifyOTP(
      Params(authParams: AuthParams(
          email: email,
        otp: otp,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {

        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> forgotAndResetPassword({required String email, String? otp, String? password, String? confirmPassword}) async {

    final failureOrSuccess = await _forgotAndResetPassword(
      Params(authParams: AuthParams(
        email: email,
        otp: otp,
        password: password,
        confirmPassword: confirmPassword,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {

        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


}