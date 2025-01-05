
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant/common/component/custom_form_field.dart';
import 'package:restaurant/common/const/colors.dart';
import 'package:restaurant/common/const/data.dart';
import 'package:restaurant/common/layout/default_layout.dart';
import 'package:restaurant/common/secure_storage/secure_storage.dart';
import 'package:restaurant/common/view/root_tab.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username='';
  String password='';
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Title(),
                const SizedBox(height: 16),
                _SubTitle(),
                Image.asset('asset/img/misc/logo.png',width: MediaQuery.of(context).size.width/3*2,),
                CustomTextFormField(
                  hintText: "이메일을 입력해주세요.",
                  onChanged: (String value) {
                    username=value;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: "이메일을 입력해주세요.",
                  onChanged: (String value) {
                    password=value;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async{
                    final rawString = '$username:$password';

                    Codec<String,String> stringToBase64=utf8.fuse(base64); //인코딩 방식을 결정.

                    String token=stringToBase64.encode(rawString); //방식을 활용해서 rawstring를 인딩

                    final resp = await dio.post('http://$ip/auth/login',
                      options: Options(
                          headers: {
                            'authorization':'Basic $token',
                          }
                      ),
                    );
                    final refreshToken = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];

                    final storage = ref.read(secureStorageProvider);

                    await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                    await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_)=>RootTab()
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR
                  ),
                  child: Text('로그인'),
                ),
                TextButton(
                    onPressed: () async{
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.black
                    ),
                    child: Text('회원가입')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요! \n오늘도 성곡적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
