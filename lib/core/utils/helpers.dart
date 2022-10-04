


import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/utils/environment.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

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
    if (value.isEmpty) {
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

  static validatePassword(String value) {
    if (value.length < 2) {
      return 'Password should be minimum 6 characters long';
    } else {
      return null;
    }
  }

  static validateWalletWithdraw(int value, int balance) {
    if (balance - value <= 200) {
      return 'Minimum Balance Left Should be 200';
    } else {
      return null;
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


  static Future<Map<String, dynamic>?> sendRequest(
      Dio dio,
      RequestType type,
      String path, {
        Map<String, dynamic>? queryParams,
        Map<String, dynamic>? headers,
        dynamic data,
      }) async {

    final logger = Logger();

    debugPrint("Payload ${queryParams ?? data}");

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
    } catch (e) {
      throw ServerException(message: e.toString());
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


    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      Navigator.of(context).pop();
                      onGallery();
                    }),
                ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: (){
                      Navigator.of(context).pop();
                      onCamera();
                      }),
                // ListTile(
                //     leading: const Icon(Icons.view_carousel_outlined),
                //     title: const Text('View Image'),
                //     onTap: () {
                //       Navigator.of(context).pop();
                //       //Navigator.push(context, new CupertinoPageRoute(builder: (context) => FullScreenImg(img: profilePic)));
                //     }),
              ],
            ),
          );
        });
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
    final result = "${formatDigits(dateSplit[1])}/${formatDigits(dateSplit[0])}/${dateSplit[2]} at ${formatDigits(timeSplit[0])}:${timeSplit[1]} ${format.split(" ")[2]}";
    return result;
  }

  static formatDigits(String number){
    if(number.length < 2) {
      return '0$number';
    }else{
      return number;
    }
  }


}
