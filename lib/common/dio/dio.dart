import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant/common/const/data.dart';
class CustomInterceptor extends Interceptor{
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage
});
  //1. 요청을 보낼 때
  //요청을 보낼때마다 요청의 헤더에 엑세스토큰이 true인경우 실제 엑세스 토큰을 storage에서 가져와
  //authorization: bearer $token으로 헤더 변경한다.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // TODO: implement onRequest
    // print('REQUEST');
    // print(options);
    print("[REQ] [${options.method}] ${options.uri}");

    if(options.headers['accessToken']=='true'){
      options.headers.remove('accessToken'); //키 삭제

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll(({
        'authorization' : 'Bearer $token',
      }));

      if(options.headers['refreshToken']=='true'){
        options.headers.remove('refreshToken'); //키 삭제

        final token = await storage.read(key: REFRESH_TOKEN_KEY);

        options.headers.addAll(({
          'authorization' : 'Bearer $token',
        }));
    }

    super.onRequest(options, handler);
  }

  //2. 응답을 받을 때
@override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  //3. 에러 났을 때
@override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}