import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/component/custom_form_field.dart';
import 'package:restaurant/common/const/colors.dart';
import 'package:restaurant/common/layout/default_layout.dart';
import 'package:restaurant/user/model/user_model.dart';
import 'package:restaurant/user/provider/user_me_provider.dart';

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
  final state = ref.watch(userMeProvider);

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
                  onPressed: state is UserModelLoading ? null:() async{
                    ref.read(userMeProvider.notifier)
                        .login(username: username,
                        password: password);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR
                  ),
                  child: Text('로그인'),
                ),
                TextButton(
                    onPressed:  () async{
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
