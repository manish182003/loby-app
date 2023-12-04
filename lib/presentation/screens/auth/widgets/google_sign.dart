import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loby/core/theme/colors.dart';

class googleSignin extends StatefulWidget {
  const googleSignin({super.key});

  @override
  State<googleSignin> createState() => _googleSigninState();
}

class _googleSigninState extends State<googleSignin> {
  
  final List<String> scopes = <String>[
  'email',
  'profile',
  'https://www.googleapis.com/auth/userinfo.email',
  'https://www.googleapis.com/auth/user.phonenumbers.read',
  'https://www.googleapis.com/auth/userinfo.profile',
];

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
  'email',
  'profile',
  'https://www.googleapis.com/auth/userinfo.email',
  'https://www.googleapis.com/auth/user.phonenumbers.read',
  'https://www.googleapis.com/auth/userinfo.profile',
]
);

Future<void> _handleGetData(GoogleSignInAccount user) async {
    final response = await Dio().get(
      
      'https://people.googleapis.com/v1/people/me?personFields=phoneNumbers,emailAddresses,names,addresses',
      // headers: await user.authHeaders,
    );

 
    print('People API ${response.statusCode} response: ${response.data}');
    
    final Map<String, dynamic> data =
        jsonDecode(response.data) as Map<String, dynamic>;
    
  }


@override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      unawaited(_handleGetData(account!));
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print({'error': error});
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleSignIn,
      child: Container(
        alignment: Alignment.center,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: shipGreyColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/logo-google.svg',
              semanticsLabel: 'lock content',
              width: 18,
              height: 18,
            ),
            const SizedBox(width: 11),
            Text(
              'Continue with Google',
              style: TextStyle()
            ),
          ],
        ),
      ),
    );
  }
}