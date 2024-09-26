import 'package:flutter/material.dart';
import 'package:restaurant/common/const/colors.dart';
import 'package:restaurant/common/layout/default_layout.dart';
import 'package:restaurant/product/view/product_screen.dart';
import 'package:restaurant/restaurant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this //현재 state를 넣,,
        );
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener(){
    setState(() {
      index=controller.index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: BODY_TEXT_COLOR,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.shifting,
          //누를때마다 확대되는효과!, 맘에안들면다른모드로,,
          onTap: (int index) {
            controller.animateTo(index);
          },
          currentIndex: index,
          //현재인덱스가어디죠? 슬라이드랑거의똑같죠
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: '홈'),
            BottomNavigationBarItem(
                icon: Icon(Icons.fastfood_outlined), label: '음식'),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined), label: '주문'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: '프로필')
          ],
        ),
        title: '수인 딜리버리',
        backgroundColor: Colors.white,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),//좌우이동은안됨.
          controller: controller,
          children: [
            RestaurantScreen(),
            ProductScreen(),
            Center(child: Container(child: Text('주문'))),
            Center(child: Container(child: Text('프로필'))),
          ],
        ));
  }
}
