import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
    body: child,
      bottomNavigationBar: bottomNavigationBar,//이동(바텀탭)외부에서 받아올거임
      floatingActionButton: floatingActionButton,
    );
  }
  AppBar? renderAppBar(){
    if(title==null){
      return null;
    }else{
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0, //튀어나온듯한효과, 요즘은 없는 게 트랜드라네요
        title: Text(title!,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500
        ),
        ),
        foregroundColor: Colors.black,//앱바 위에 올라가는 레이어들의 색상
      );
    }
}
}
