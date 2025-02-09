import 'dart:convert';

import '../const/data.dart';

class DataUtils{
  //무조건 static여야함
  static DateTime stringToDateTime(String value){
    return DateTime.parse(value);
  }

  static pathToUrl(String value){
    return "http://$ip$value}";
  }

  static listPathsToUrls(List paths){
    return paths.map((e)=>pathToUrl(e)).toList();
  }

  static String plainToBase64(String plain){
    Codec<String,String> stringToBase64=utf8.fuse(base64); //인코딩 방식을 결정.

    String encoded =stringToBase64.encode(plain); //방식을 활용해서 rawstring를 인딩
    return encoded;
  }
}