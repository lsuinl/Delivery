import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/provider/go_router.dart';
import 'package:restaurant/common/view/root_tab.dart';
import 'package:restaurant/common/view/splash_screen.dart';
import 'package:restaurant/user/provider/auth_provider.dart';
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

class _App extends ConsumerWidget { //_:private
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: "NotoSans",
      ),
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser:router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
