


// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/environment.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'exceptions.dart';
import 'failure.dart';


enum RequestType { get, post, delete }

class Helpers {

  static toast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }



  static validateEmail(String value) {
    if (value.isEmpty) {
      return "field required";
    }
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
        r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]'
        r'+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'invalid email';
  }

  static validateField(String value) {


    if (value.isEmpty || value == 'null') {
      return "field required";
    }
    return null;
  }

  static validatePhone(String value) {
    if (value.length < 10 || value.length > 10) {
      return 'Please Enter Valid Mobile Number';
    } else {
      return null;
    }
  }


  static validateTokenLimit(String? value) {
    if(value == null || value.isEmpty){
      return "Field Required";
    }else if (int.tryParse(value)! > 100000) {
      return 'Max Limit 1,00,000';
    } else {
      return null;
    }
  }

  static validateStockLimit(String? value) {
    if(value == null || value.isEmpty){
      return "Field Required";
    }else if (int.tryParse(value)! > 999) {
      return 'Max Limit 999';
    } else {
      return null;
    }
  }


  static validatePassword(String value) {
    if (value.length < 6) {
      return 'Password should be minimum 6 characters long';
    } else {
      return null;
    }
  }

  static validateWalletAdd(String? value) {
    if(value == null || value.isEmpty){
      return "Field Required";
    }else if (int.tryParse(value)! > 5000 || int.tryParse(value)! < 20) {
      return 'Add tokens between 20 - 5,000';
    } else {
      return null;
    }
  }

  static validateWalletWithdraw(String value, double balance) {
    if(value != ''){
      if (balance - double.parse(value) < 200) {
        return 'Minimum Balance Left Should be 200';
      } else if(int.tryParse(value)! > 5000 || int.tryParse(value)! < 50){
        return 'Withdraw tokens between 50 - 5,000';
      } else {
        return null;
      }
    }else{
      return 'Field Required';
    }
  }



  static validateStartDate(DateTime? value) {
    if (value == null) {
      return "Please select policy start date";
    }
    return null;
  }

  static removeNullEmptyKey(data) {
    data.removeWhere(
        (key, value) => value == null || value == '' || value == 'null');
    return data;
  }


  static validateDate(DateTime? value) {
    if (value == null) {
      return "Please select date";
    }
    return null;
  }

  static validateTime(DateTime? value) {
    if (value == null) {
      return "Please select time";
    }
    return null;
  }

  static validateLink(String? value) {
    if(value == null){
      return "Field Required";
    }else if (Uri.tryParse(value)!.hasAbsolutePath ) {
      return null;
    }else{
      return "Invalid URL";
    }
  }

  static validateOptionalLink(String? value) {
    if(value == null || value.isEmpty){
      return null;
    }else if (Uri.tryParse(value)!.hasAbsolutePath ) {
      return null;
    }else{
      return "Invalid URL";
    }
  }

  static Future launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  static int getFileType(String extension) {
    switch (extension) {
      case 'mp3':
        return 0;
      case 'mp4':
        return 1;
      case 'png':
        return 2;
      case 'jpg':
        return 2;
      case 'pdf':
        return 3;
      case 'docx':
        return 3;
      default:
        return 4;
    }
  }


  static String getFileExtension(int type) {
    switch (type) {
      case 0:
        return "Audio";
      case 1:
        return "Video";
      case 2:
        return "Image";
      case 3:
        return "Document";
      default:
        return "";
    }
  }


  static Future<Map<String, dynamic>?> sendRequest(
      Dio dio,
      RequestType type,
      String path, {
        Map<String, dynamic>? queryParams,
        Map<String, dynamic>? headers,
        dynamic data,
      }) async {

    final logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2, // number of method calls to be displayed
          errorMethodCount: 8, // number of method calls if stacktrace is provided
          lineLength: 200, // width of the output
          colors: true, // Colorful log messages
          printEmojis: true, // Print an emoji for each log message
          printTime: false // Should each log print contain a timestamp
      ),
    );

    debugPrint("Payload ${queryParams ?? data}");


    // bool isDeviceConnected = await InternetConnectionChecker().hasConnection;
    // if (!isDeviceConnected) {
    //   runApp(const NoInternetConnection());
    // }else{
    //   runMainApp();
    // }

    try {
      Response response;

      switch (type) {
        case RequestType.get:
          response = await dio.get(
            path,
            queryParameters: queryParams,
            options: Options(headers: headers),
          );
          break;

        case RequestType.post:
          response = await dio.post(
            path,
            options: Options(headers: headers, validateStatus: (code) => true),
            data: queryParams ?? data,
          );
          break;

        case RequestType.delete:
          response = await dio.delete(
              path,
              queryParameters: queryParams,
              options: Options(headers: headers),
          );
          break;

        default:
          return null;
      }

      debugPrint("$path response ${response.statusCode} with ${response.statusMessage}");

      if (response.statusCode == 200) {
        logger.i(jsonEncode(response.data as Map<String, dynamic>));
        return response.data as Map<String, dynamic>;
      }else if (response.statusCode == 400  || response.statusCode == 401 || response.statusCode == 202) {
        logger.i('Failed Response ${const JsonEncoder().convert(response.data as Map<String, dynamic>)}');
        throw ServerException(
          message: response.data['message'],
          code: response.statusCode,
        );
      }else {
        throw ServerException(
          message: response.data['message'],
          code: response.statusCode,
        );
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message, code: e.code);
    } on DioError catch (e) {
      throw ServerException(message: e.error is SocketException ? 'No Internet Connection' : e.error.toString());
    }
  }


  static Future getApiToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('apiToken');
  }

  static Future getApiHeaders() async {
    String token = await getApiToken();
    final Map<String, dynamic> headers = {
      'Authorization': 'Bearer $token',
    };
    return headers;
  }

  static Future<bool?> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }


  static loader(){
    SmartDialog.showLoading();
  }

  static hideLoader(){
    SmartDialog.dismiss();
  }


  static String convertFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return "Unknown error occurred";
  }


  static void showImagePicker({required BuildContext context, required Function() onGallery, required Function() onCamera})async{
    final textTheme = Theme.of(context).textTheme;
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: IntrinsicHeight(
            child: Container(
              margin: const EdgeInsets.all(24.0),
              width: double.maxFinite,
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: backgroundDarkJungleGreenColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Material(
                color: backgroundDarkJungleGreenColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onCamera();
                      },
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text('Camera', style: textTheme.headline3?.copyWith(color: aquaGreenColor),),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onGallery();
                      },
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text('Gallery', style: textTheme.headline3?.copyWith(color: aquaGreenColor),),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text('Cancel', style: textTheme.headline3?.copyWith(color: aquaGreenColor),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );



    // showModalBottomSheet(
    //     context: context,
    //     builder: (BuildContext bc) {
    //       return SafeArea(
    //         child: Wrap(
    //           children: <Widget>[
    //             ListTile(
    //                 leading: const Icon(Icons.photo_camera),
    //                 title: const Text('Camera'),
    //                 onTap: (){
    //                   Navigator.of(context).pop();
    //                   onCamera();
    //                 }),
    //             ListTile(
    //                 leading: const Icon(Icons.photo_library),
    //                 title: const Text('Gallery'),
    //                 onTap: () {
    //                   Navigator.of(context).pop();
    //                   onGallery();
    //                 }),
    //
    //             // ListTile(
    //             //     leading: const Icon(Icons.view_carousel_outlined),
    //             //     title: const Text('View Image'),
    //             //     onTap: () {
    //             //       Navigator.of(context).pop();
    //             //       //Navigator.push(context, new CupertinoPageRoute(builder: (context) => FullScreenImg(img: profilePic)));
    //             //     }),
    //           ],
    //         ),
    //       );
    //     });
  }

  static getImage(String image){
    if(image.contains(Environment.apiUrl)){
      return image;
    }else{
      return "${Environment.apiUrl}$image";
    }
  }

  static getDateFormat(String date){
    final year = date.split("/");
    return "${year[2]}-${year[1]}-${year[0]}";
  }

  static getUserId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId') == null ? null : int.tryParse(prefs.getString('userId')!);
  }

  static saveString(String key, String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static getString(String string) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(string);
  }

  static formatDateTime({required DateTime dateTime}){
    final format = DateFormat.yMd().add_jms().format(dateTime);
    final dateSplit = format.split(" ")[0].split("/");
    final timeSplit = format.split(" ")[1].split(":");
    final result = "${formatDigits(dateSplit[1])}/${formatDigits(dateSplit[0])}/${dateSplit[2]} ${formatDigits(timeSplit[0])}:${timeSplit[1]} ${format.split(" ")[2]}";
    return result;

    // dateTime.toMoment().toLocal().format("DD/MM/YYYY hh:mm A").toString();
  }

  static formatDigits(String number){
    if(number.length < 2) {
      return '0$number';
    }else{
      return number;
    }
  }

  static String? getListingImage(ServiceListing listing){
    final listingImages = listing.userGameServiceImages!.where((element) => element.type != 3).toList();
    return listingImages.isEmpty ? null : listingImages.first.path!;
  }

  static Future<File> urlToFile(String imageUrl) async {
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath${rng.nextInt(100)}.png');
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }


  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
