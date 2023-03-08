import 'package:flutter/material.dart';
import 'package:restaurant/common/const/colors.dart';
import 'package:restaurant/common/layout/default_layout.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  int index =0;
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: BODY_TEXT_COLOR,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.shifting, //누를때마다 확대되는효과!, 맘에안들면다른모드로,,
          onTap: (int index){
            setState(() {
              this.index=index;
            });
          },
          currentIndex: index, //현재인덱스가어디죠? 슬라이드랑거의똑같죠
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.fastfood_outlined), label: '음식'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), label: '주문'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: '프로필')
          ],
        ),
        title: '수인 딜리버리',
        backgroundColor: PRIMARY_COLOR,
        child: Center(
          child: Text('Root Tab'),
        )
    );
  }
}

