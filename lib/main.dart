import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/view/root_tab.dart';
import 'package:restaurant/common/view/splash_screen.dart';
import 'package:restaurant/user/view/login_screen.dart';

import 'common/component/custom_form_field.dart';


//test@codefactory.ai
//testtest
void main() {
  runApp(
    ProviderScope(
      child: _App()
    )
  );
}

class _App extends StatelessWidget { //_:private
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "NotoSans",
      ),
      debugShowCheckedModeBanner: false,
      home:SplashScreen()
    );
  }
}
