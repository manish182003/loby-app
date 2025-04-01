import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      log("Running on Production");
      return '.env.production';
    }
    log("Running on Development");
    return '.env.development';
  }

  static String get apiBaseUrl {
    return dotenv.env['API_BASE_URL'] ?? 'API_BASE_URL not found!';
  }

  static String get apiUrl {
    return dotenv.env['API_URL'] ?? 'API_URL not found!';
  }

  static String get socketUrl {
    return dotenv.env['SOCKET_URL'] ?? 'SOCKET_URL not found!';
  }

  static String get socketPath {
    return dotenv.env['SOCKET_PATH'] ?? 'SOCKET_PATH not found!';
  }

  static bool get isPaytmStaging {
    return dotenv.env['PAYTM_STAGING'] == 'true' ? true : false;
  }
}
