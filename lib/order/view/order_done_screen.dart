import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant/common/const/colors.dart';
import 'package:restaurant/common/layout/default_layout.dart';
import 'package:restaurant/common/provider/go_router.dart';
import 'package:restaurant/common/view/root_tab.dart';

class OrderDoneScreen extends StatelessWidget {
  static String get routeName => 'order_done';
  const OrderDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.thumb_up_alt_outlined,
            color: PRIMARY_COLOR,
            size: 50,
          ),
          const SizedBox(
            height: 32,
          ),
          Text("결제가 완료되었습니다.",textAlign: TextAlign.center,),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
              onPressed: () {
                context.goNamed(RootTab.routeName);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: PRIMARY_COLOR
              ),
              child: Text("홈으로"))
        ],
      ),
    ));
  }
}
