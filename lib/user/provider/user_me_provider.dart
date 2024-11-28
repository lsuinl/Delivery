import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant/common/const/data.dart';
import 'package:restaurant/user/repository/auth_repository.dart';

import '../model/user_model.dart';
import '../repository/user_me_repository.dart';

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    //내 정보 가져오기
    getMe();
  }

  Future<void> getMe() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }
    final resp = await repository.getMe();

    state = resp;
  }

  Future<UserModelBase> login({
    required String username,
    required String password,
  }) async {
    try{
      state = UserModelLoading();

      final resp = await authRepository.login(
          username:username,
          passward:password
      );

      await storage.write(
          key: REFRESH_TOKEN_KEY,
          value: resp.refreshToken);
      await storage.write(
          key: ACCESS_TOKEN_KEY,
          value: resp.accessToken);

      final userResp = await repository.getMe();
      state = userResp;

      return userResp;
    }
    catch(e){
      state = UserModelError(message: "로그인에 실패하였습니댜.");

      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null; //바로 null로 만들어서 로그인페이지로 보내기

    //두가지를 동시에 실행하여 await시키기. 각각 await로 삭제하는 것보다 조금 더 빠름
    await Future.wait([
     storage.delete(key: REFRESH_TOKEN_KEY),
     storage.delete(key: ACCESS_TOKEN_KEY)
    ]);

  }
}