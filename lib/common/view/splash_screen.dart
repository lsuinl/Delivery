import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/const/colors.dart';
import 'package:restaurant/common/layout/default_layout.dart';

class SplashScreen extends ConsumerWidget {
  static String get routeName => 'splash';

  @override
  Widget build(BuildContext context,WidgetRef ref) {
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
