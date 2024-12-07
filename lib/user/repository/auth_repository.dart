import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/dio/dio.dart';
import 'package:restaurant/common/model/login_response.dart';
import 'package:restaurant/common/model/token_response.dart';
import 'package:restaurant/common/utils/data_utils.dart';
import '../../common/const/data.dart';

final authRepositoryProvider = Provider((ref){
  final dio = ref.watch(dioProvider);

return AuthRepository(baseUrl: 'http://$ip/auth', dio: dio);
});

class AuthRepository{
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
});
  Future<LoginResponse>  login ({
    required String username,
    required String passward
  })async{
    final serialized = DataUtils.plainToBase64('$username:$passward');
    final resp  = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {
          'quthorization':'Basic $serialized'
        }
      )
    );
    return LoginResponse.fromJson(
      resp.data
    );

  }

  Future<TokenResponse> token()async{
    final resp = await dio.post(
      '$baseUrl/token',
      options: Options(
        headers: {'refreshToken':'true'}
      )
    );
    return TokenResponse.fromJson(resp.data);
  }
}