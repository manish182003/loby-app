
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loby/core/usecases/auth_params.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/auth/city.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/auth/profile_tag.dart';
import 'package:loby/domain/usecases/auth/check_username.dart';
import 'package:loby/domain/usecases/auth/get_cities.dart';
import 'package:loby/domain/usecases/auth/get_countries.dart';
import 'package:loby/domain/usecases/auth/get_profile_tags.dart';
import 'package:loby/domain/usecases/auth/get_states.dart';
import 'package:loby/domain/usecases/auth/login.dart';
import 'package:loby/domain/usecases/auth/signup.dart';
import 'package:loby/domain/usecases/auth/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/auth/state.dart' as state;
import 'profile_controller.dart';

class AuthController extends GetxController{

  final Signup _signup;
  final Login _login;
  final GetCountries _getCountries;
  final GetStates _getStates;
  final GetCities _getCities;
  final GetProfileTags _getProfileTags;
  final UpdateProfile _updateProfile;
  final CheckUsername _checkUsername;

  AuthController({
    required Signup signup,
    required Login login,
    required GetCountries getCountries,
    required GetStates getStates,
    required GetCities getCities,
    required GetProfileTags getProfileTags, required UpdateProfile updateProfile,
    required CheckUsername checkUsername,
    }) : _signup = signup,
        _getCountries = getCountries,
        _getStates = getStates,
        _getCities = getCities,
        _getProfileTags = getProfileTags,
        _updateProfile = updateProfile,
        _login = login,
  _checkUsername = checkUsername;

  final countries = <Country>[].obs;
  final areMoreCountriesAvailable = true.obs;
  final countriesPageNumber = 1.obs;
  final isCountriesFetching = false.obs;

  final states = <state.State>[].obs;

  final cities = <City>[].obs;

  final profileTags = <ProfileTag>[].obs;


  final fullName = TextEditingController().obs;
  final displayName = TextEditingController().obs;
  final selectedCountryId = 0.obs;
  final selectedStateId = 0.obs;
  final selectedCityId = 0.obs;
  final DOB = TextEditingController().obs;
  final selectedProfileTags = <Map<String, dynamic>>[].obs;
  final bio = TextEditingController().obs;
  final avatarUrl = "".obs;


  final errorMessage = ''.obs;

  final auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  final isGoogleSignInSuccess = false.obs;

  final isUsernameAvailable = false.obs;
  final usernameString = "".obs;

   Future<void> saveProfileDetails()async{
     final userId = await Helpers.getUserId();
     final apiToken = await Helpers.getString('apiToken');
     if(userId != null && apiToken != null){
       ProfileController profileController = Get.find<ProfileController>();
       profileController.getProfile();
     }
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
        avatarUrl.value = googleUser?.photoUrl ?? '';
        await Helpers.hideLoader();
      });

      return isGoogleSignInSuccess.value;
    }catch(e){
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


  Future<bool> updateProfile({File? cover, File? avatar}) async {


    final failureOrSuccess = await _updateProfile(
      Params(authParams: AuthParams(
          cover: cover,
          avatar: avatar,
          fullName: fullName.value.text,
          displayName: displayName.value.text,
          countryId: selectedCountryId.value,
          stateId: selectedStateId.value,
          cityId: selectedCityId.value,
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
            avatarUrl.value = "";
            fullName.value.clear();
            displayName.value.clear();
            selectedCountryId.value = 0;
            selectedStateId.value = 0;
            selectedCityId.value = 0;
            DOB.value.clear();
            selectedProfileTags.clear();
            bio.value.clear();

            saveProfileDetails();

            // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
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



}