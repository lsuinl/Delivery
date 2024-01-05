import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant/common/const/data.dart';
class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage
  });

  //1. 요청을 보낼 때
  //요청을 보낼때마다 요청의 헤더에 엑세스토큰이 true인경우 실제 엑세스 토큰을 storage에서 가져와
  //authorization: bearer $token으로 헤더 변경한다.
  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    // TODO: implement onRequest
    // print('REQUEST');
    // print(options);
    print("[REQ] [${options.method}] ${options.uri}");

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken'); //키 삭제

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll(({
        'authorization': 'Bearer $token',
      }));

      if (options.headers['refreshToken'] == 'true') {
        options.headers.remove('refreshToken'); //키 삭제

        final token = await storage.read(key: REFRESH_TOKEN_KEY);

        options.headers.addAll(({
          'authorization': 'Bearer $token',
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
    void onError(DioException err, ErrorInterceptorHandler handler) async {
      // TODO: implement onError
      //401: 토큰 에러(status code)
      //토큰 재발급 시도 후, 새로운 토큰으로 요청하기
      print("[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}");

      final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

      //refreshToken없으면 에러를 던집
      if(refreshToken == null){
        //에러를 던질 때는 handler.reject를 사용한다(dio에서의 룰임.)
        return handler.reject(err);
      }

      final isStatus401 = err.response?.statusCode==401;
      final isPathRefresh = err.requestOptions.path == '/auth/token'; //토큰 재발급 과정에서의 에러인지 체크.(리프레시 토큰 자체의문제

      if(isStatus401 && !isPathRefresh){
        final dio = Dio();
        try{
          final resp = await dio.post(
              'http://$ip/auth/token',
              options: Options(
                  headers: {
                    'authorization': 'Bearer $refreshToken',
                  }
              )
          );
          final accessToken = resp.data['accessToken'];

          final options = err.requestOptions;

          //토큰 변경하기
          options.headers.addAll({
            'authorization': 'Bearer $accessToken'
          });

          await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

          //요청 재전송
          final response = await dio.fetch(options);

          return handler.resolve(response);

        } on DioError catch(e){
          return handler.reject(e);
      }


      }
      //return handler.resolve(response);
      return handler.reject(err);
    }
  }
}