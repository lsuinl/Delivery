import 'dart:html';

import 'package:flutter/material.dart';
import 'package:restaurant/common/const/colors.dart';
import 'package:restaurant/common/const/data.dart';
import 'package:restaurant/common/layout/default_layout.dart';
import 'package:restaurant/common/view/root_tab.dart';
import 'package:restaurant/user/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  //initState는 await가 안되네요
  }

  void deleteToken() async {
    await storage.deleteAll();
  }
  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if(refreshToken==null || accessToken==null){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_)=>LoginScreen(),
      ), (route) => false
      );
    }else{
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_)=>RootTab(),
          ), (route) => false
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
            width: MediaQuery.of(context).size.width, //너비최대
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/img/logo/logo.png',
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CircularProgressIndicator(
                  color: Colors.white,
                )
              ],
            )));
  }
}
