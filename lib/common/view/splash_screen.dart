import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/const/colors.dart';
import 'package:restaurant/common/const/data.dart';
import 'package:restaurant/common/layout/default_layout.dart';
import 'package:restaurant/common/secure_storage/secure_storage.dart';
import 'package:restaurant/common/view/root_tab.dart';
import 'package:restaurant/user/view/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  //initState는 await가 안되네요
  }

  void deleteToken() async {
    final storage = ref.read(secureStorageProvider);

    await storage.deleteAll();
  }
  void checkToken() async {
    final storage = ref.read(secureStorageProvider);

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio= Dio();
    try{
      final resp = await dio.post(
        'http://$ip/auth/token',
        options: Options(
            headers: {
              'authorization':'Bearer $refreshToken',
            }
        ),
      );
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_)=>RootTab(),
          ), (route) => false
      );
    }catch(e){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_)=>LoginScreen(),
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
