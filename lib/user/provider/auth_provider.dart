import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant/common/view/splash_screen.dart';
import 'package:restaurant/restaurant/view/restaurant_detail_screen.dart';
import 'package:restaurant/user/provider/user_me_provider.dart';

import '../../common/view/root_tab.dart';
import '../model/user_model.dart';
import '../view/login_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref){
  return AuthProvider(ref:ref);
});

class AuthProvider extends ChangeNotifier{
  final Ref ref;
  
  AuthProvider({
    required this.ref,
  }){
    ref.listen<UserModelBase?>(userMeProvider,(previous,next ){
      if(previous != next){
        notifyListeners();
      }
    });
}

List<GoRoute> get routes =>[
  GoRoute(path:'/',
    name: RootTab.routeName,
    builder:(_,__)=> RootTab(),
    routes: [
      GoRoute(path:'restaurant/:rid',
        name: LoginScreen.routeName,
        builder:(_,state)=> RestaurantDetailScreen(id: state.params['rid']!
        ),
      ),
    ]
  ),
  GoRoute(path:'/splash',
    name: SplashScreen.routeName,
    builder:(_,__)=> SplashScreen(),
  ),
  GoRoute(path:'/login',
    name: LoginScreen.routeName,
    builder:(_,__)=> LoginScreen(),
  ),
];

//SplashScreen
  //앱을 처음 시작했을 때 토큰 존재여부 확인 후, 로그인 또는 홈 이동하는 로직
String? redirectLogic(GoRouterState state){
    final UserModelBase? user = ref.read(userMeProvider);

    final logginIn = state.location =='/login';

    //유저정보가 없는데 로그인 => 그대로 두고
    //유저정보가 없는데 로그인이 아니면=> 로그인으로 이동
    if(user == null){
      return logginIn ? null:'/login';
    }

    //user가 null이 아님
    //UserModel
    //사용자 정보가 있는 상태이고 로그인 or 현재가 splashScreen이면 => 홈으로
    //사용자 정보가 있는 상태이고  위 두가지가 아니면 -> 하던대로 이동하시오
    if(user is UserModel){
      return logginIn || state.location == '/splash'? '/':null;
    }

    //UserModelError
    if(user is UserModelError){
      return !logginIn ? '/login':null;
    }

    return null; //원래 가던곳으로 이동
  }
}